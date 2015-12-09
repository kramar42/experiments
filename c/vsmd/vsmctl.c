#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

#include "vsmctl.h"
#include "vsmsig.h"

int main (argc, argv)
     int argc;
     char *argv[];
{
  int pid;

  /* if one parameter - print usage */
  if (argc != 2) {
    print_usage(argv[0]);
    exit(EXIT_SUCCESS);
  }

  /* change working dir */
  if ((chdir (RUNNING_DIR)) < 0) {
    printf("Could not change working dir to %s.\n", RUNNING_DIR);
    exit(EXIT_FAILURE);
  }

  pid = readpid();

  if (! strcmp("start", argv[1])) {
    startd(pid);
    
  } else if (! strcmp("stop", argv[1])) {
    stopd(pid);
    
  } else if (! strcmp("restart", argv[1])) {
    stopd(pid);
    usleep(500000);
    /* read new process pid. need to be NULL - if we stopped correctly */
    pid = readpid();
    startd(pid);
    
  } else if (! strcmp("poll", argv[1])) {
    if (pid) {
      /* kill - sending signals */
      kill(pid, SIGPOLL);
    } else {
        printf("Daemon is not running.\n");
    }
  } else if (! strcmp("freezy", argv[1])) {
    if (pid) {
      kill(pid, SIGFREEZY);
    } else {
      printf("Daemon is not running.\n");
    }
  } else if (! strcmp("defrost", argv[1])) {
    if (pid) {
      kill(pid, SIGDEFROST);
    } else {
      printf("Daemon is not running.\n");
    }
  }
  
  return 0;
}

int readpid (void)
{
  int lfp;
  char buff[10];
  int pid;

  memset(buff, 0, 10);
  lfp = open(LOCK_FILE, O_RDONLY, 0640);

  if (lfp < 0) {
    return 0;
  }

  if (read(lfp, buff, 10) == -1) {
    printf("Could not read lock file.\n");
    exit(EXIT_FAILURE);
  }
  close(lfp);
  
  pid = atoi(buff);
  return pid;
}

void print_usage (progname)
     char *progname;
{
  printf("usage: %s start|stop|restart|poll|freezy|defrost", progname);
}

void startd (pid)
     int pid;
{
  printf("Starting daemon...\n");

  if (! pid) {
    if (system("vsmd") == -1) {
      printf("Could not run daemon.\n");
      exit(EXIT_FAILURE);
    }
  } else {
    printf("Daemon is already running.\n");
  }
}

void stopd (pid)
     int pid;
{
  printf("Stopping daemon...\n");
  
  if (pid) {
    kill(pid, SIGTERM);
  } else {
    printf("Daemon is not running.\n");
  }
}
