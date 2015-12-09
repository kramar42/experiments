#include <errno.h>
#include <fcntl.h>
#include <libudev.h>
#include <modbus/modbus.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <syslog.h>
#include <time.h>
#include <unistd.h>

#include "vsmd.h"
#include "vsmsig.h"

int main ()
{
  start();
  return 0;
}

int daemonize (progname)
     char *progname;
{
  pid_t pid, sid;
  int lfp;
  char str [10];
  memset(str, 0, 10);

  /* connect to syslog */
  openlog(progname, LOG_NOWAIT | LOG_PID, LOG_USER);
  
  /* create new process */
  pid = fork ();  
  if (pid < 0) {
    /* error in forking */
    syslog(LOG_ERR, "Fork #1 failed.\n");
    exit(EXIT_FAILURE);
  }
  
  if (pid > 0) {
    /* we are parent. closing. */
    exit(EXIT_SUCCESS);
  }

  /* change current directory */
  if ((chdir (RUNNING_DIR)) < 0) {
    syslog(LOG_ERR, "Could not change working dir to %s.\n", RUNNING_DIR);
    exit(EXIT_FAILURE);
  }

  /* create new session and process group */  
  if ((sid = setsid ()) < 0) {
    syslog(LOG_ERR, "Could not create process group.\n");
    exit(EXIT_FAILURE);
  }
  
  /* change the file mode mask */
  umask(0);

  /* create second process */
  pid = fork ();
  if (pid < 0) {
    syslog(LOG_ERR, "Fork #2 failed.\n");
    exit(EXIT_FAILURE);
  }
  
  if (pid > 0) {
    exit(EXIT_SUCCESS);
  }
  
  /* closing 1,2,3 */
  close(STDIN_FILENO);
  close(STDOUT_FILENO);
  close(STDERR_FILENO);

  /* open lock file descriptor */
  lfp = open(LOCK_FILE, O_RDWR | O_CREAT, 0640);

  /* trying to lock */
  if (lockf(lfp, F_TLOCK, 0) < 0) {
    syslog(LOG_NOTICE, "Daemon is already running.\n");
    exit(EXIT_FAILURE);
  }

  /* can't open */
  if (lfp < 0) {
    syslog(LOG_ERR, "Could not open lock file.\n");
    exit(EXIT_FAILURE);
  }
  /* all is good - write to file */
  sprintf(str, "%d\n", getpid());
  if (write(lfp, str, strlen(str)) < 0) {
    syslog(LOG_ERR, "Could not write to lock file.\n");
    exit(EXIT_FAILURE);
  }

  /* save file descriptor in global variable */
  LFP = lfp;

  /* SIGNALS */
  /* ignore tty signals */
  /*
  signal(SIGCHLD, SIG_IGN);
  signal(SIGTSTP, SIG_IGN); 
  signal(SIGTTOU, SIG_IGN);
  signal(SIGTTIN, SIG_IGN);
  */

  /* tcp/ip socket part */
  int sockfd, portno;
  struct sockaddr_in serv_addr;
  
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if (sockfd < 0)
    error("Could not open socket.\n");
  
  memset(&serv_addr, 0, sizeof(serv_addr));
  portno = 888;
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_addr.s_addr = INADDR_ANY;
  serv_addr.sin_port = htons(portno);
  
  if (bind(sockfd, (struct sockaddr *) &serv_addr,
           sizeof(serv_addr)) < 0)
    error("Could not bind socket.\n");
  
  listen(sockfd, 5);
  
  syslog(LOG_NOTICE, "Successfully started daemon.\n");
  return sockfd;
}

void stop (void)
{
  /* deleting lock file */
  dellock();
  /* closing syslog */
  closelog();
}

void start()
{
  char buffer[256];
  int newsockfd, sockfd, n;
  socklen_t clilen;
  struct sockaddr_in cli_addr;
  
  sockfd = daemonize("vsmd");
  clilen = sizeof(cli_addr);

  while (1) {
    newsockfd = accept(sockfd, 
                       (struct sockaddr *) &cli_addr, 
                       &clilen);
  
    if (newsockfd < 0)
      error("Could not accept socket.\n");

    while (1) {
      memset(buffer, '\0', 256);
      n = read(newsockfd, buffer, 255);
      if (n < 0)
        error("Could not read from socket.\n");
      
      syslog(LOG_NOTICE, "Here is the message: %s", buffer);
      n = write(newsockfd,"I got your message.\n",19);
      
      if (n < 0)
        error("Could not write to socket.\n");
    }
  }
}

void restart ()
{
  stop();
  start();
}

void dellock (void)
{
  close(LFP);
  if (remove(LOCK_FILE) != 0) {
    syslog(LOG_ERR, "Could not delete lock file.\n");
    exit(EXIT_FAILURE);
  } else {
    syslog(LOG_NOTICE, "Successfully deleted lock file.\n");
  }
}

void error(msg)
     const char *msg;
{
  syslog(LOG_ERR, msg);
  stop();
  exit(EXIT_FAILURE);
}

void signal_handler (sig)
     int sig;
{
  switch (sig)
    {
    case SIGTERM:
      syslog(LOG_NOTICE, "Exiting daemon.\n");
      stop();
      exit(EXIT_SUCCESS);
    case SIGPOLL:
      syslog(LOG_NOTICE, "SIGPOOL\n");
      poll();
      break;
    case SIGFREEZY:
      syslog(LOG_NOTICE, "Restarting...\n");
      restart();
      break;
    case SIGDEFROST:
      syslog(LOG_NOTICE, "SIGDEFROST\n");
      break;
    }
}

/*Function for detect devive address*/
const char* dev_select( void )
{
  struct udev *udev;
  struct udev_enumerate *enumerate;
  struct udev_list_entry *devices;
  struct udev_device *dev = NULL;
 
  udev = udev_new();
  if (!udev) {
    syslog(LOG_ERR, "Can't create udev\n");
    return NULL;
  }

  /*Added subsystem tty*/
  enumerate = udev_enumerate_new(udev);
  udev_enumerate_add_match_subsystem(enumerate, "tty");
  udev_enumerate_scan_devices(enumerate);
  devices = udev_enumerate_get_list_entry(enumerate);

  char *result;
  result = NULL;

  /*Searching device with specific name*/
  while(devices) {
    const char *path = udev_list_entry_get_name(devices);
    dev = udev_device_new_from_syspath(udev, path);

    struct udev_list_entry *e;
    struct udev_list_entry *tmp;    
    e = udev_device_get_properties_list_entry(dev);
    tmp = udev_list_entry_get_by_name(e, "ID_MODEL");

    if(tmp && strcmp(udev_list_entry_get_value(tmp), DEVICE_NAME) == 0) {
      const char* tmp = udev_device_get_devnode(dev);
      int length = strlen(tmp) + 1;
      result =(char*)malloc(length);
      strncpy(result, tmp, length);
      break;
    } else
      devices =  udev_list_entry_get_next(devices);
  }
  udev_device_unref(dev);
  udev_enumerate_unref(enumerate);
  udev_unref(udev);

  return result;
}

/*Function that show status of device*/
void poll( void )
{
  modbus_t *ctx;
  const char *device = dev_select();
  ctx = modbus_new_rtu(device, 19200, 'N', 8, 1);
  free((void *)device);
  if (ctx == NULL) {
    syslog(LOG_ERR, "Unable to create the libmodbus context\n");
    return ;
  }
  modbus_set_slave(ctx, 32);

  if(modbus_connect(ctx) == -1) {
    syslog(LOG_ERR, "connection failed\n");
    modbus_free(ctx);
  }

  uint16_t tab_reg[18];
  /*uint8_t reg;*/

  int rc;

  rc = modbus_read_registers(ctx, 0, 18, tab_reg);
  if (rc == -1) {
      syslog(LOG_ERR, "%s\n", modbus_strerror(errno));
      return ;
  }


  FILE *f = fopen("/tmp/vsmd.stat", "w");

  fprintf(f, "SYSTEM MONITOR\n");

  time_t rawtime;
  struct tm * timeinfo;
  time ( &rawtime );
  timeinfo = localtime ( &rawtime );

  fprintf(f, "status at %02d-%02d-%d %02d:%02d:%02d\n", timeinfo->tm_mday, 
                                                        timeinfo->tm_mon,
                                                        timeinfo->tm_year+1900, 
                                                        timeinfo->tm_hour, 
                                                        timeinfo->tm_min, 
                                                        timeinfo->tm_sec);
  fprintf(f, "------------------------------------\n");
  fprintf(f, "WDT: \t\t%d\n", tab_reg[0]);
  fprintf(f, "Temperature: \t%d\n", tab_reg[4]/2);
  fprintf(f, "Main voltage: \t%.4f\n", tab_reg[3]/1000.0);
  fprintf(f, "Fan speed: \t%d\n\n", tab_reg[6]);

  fprintf(f, "Variables:\n");
  fprintf(f, "\tac ok\t  = %d\n", tab_reg[1]);
  fprintf(f, "\tbatt low  = %d\n", tab_reg[1] );
  fprintf(f, "\tpower led = %d\n", tab_reg[1] );
  fprintf(f, "\thdd led\t  = %d\n", tab_reg[1] );
  fprintf(f, "\tfan lock  = %d\n\n", tab_reg[1] );

  fprintf(f, "Registers:\n");
  int i;
  for (i=0; i < rc; i++) {
      fprintf(f,"\t[%02X]: %X\n", i, tab_reg[i]);
  }
  fprintf(f, "\n");
  fclose(f);

  modbus_close(ctx);
  modbus_free(ctx);
}
