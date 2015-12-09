#ifndef _VSMD_H_
#define _VSMD_H_

/* need to read from config */
#define RUNNING_DIR "/tmp"
#define LOCK_FILE "vsmd.lock"
#define LOG_FILE "vsmd.log"

#define DEVICE_NAME "System_Monitor"


/* global lock file descriptor */
int LFP;
/* all daemonizing stuff goes here */
int daemonize ( char * );
/* start daemon */
void start ( void );
/* correct daemon finilizing */
void stop ( void );
/* deleting lock file */
void dellock ( void );
/* error handling */
void error ( const char * );
/* signal handler */
void signal_handler ( int );

/* serching device address by device_name*/
const char* dev_select( void );
/* poll */
void poll( void );

#endif
