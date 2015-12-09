#ifndef _VSMCTL_H_
#define _VSMCTL_H_

#define RUNNING_DIR "/tmp"
#define LOCK_FILE "vsmd.lock"

int readpid ( void );
void print_usage ( char *);
void startd ( int );
void stopd ( int );

#endif
