#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <fcntl.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include<pthread.h> //for threading , link with lpthread
#include "mptcp.h"

#define BACKLOG 10 /* number of pending connections allowed in the queue*/
#define MAXPORTS 100

//#ifdef MUTEX
pthread_mutex_t lock;
//#endif

typedef struct thread_args {
    int conn_sock;
    char ipaddr[100];
    char port[100];
    int conn_num;
} threadArgs;

pthread_mutex_t count_mutex;
pthread_cond_t iam_done;

pthread_cond_t i2am_done;
pthread_mutex_t c2_mutex;

void *conn_handler(void *); 
void *send_thread(void *);
void *recv_thread(void *);

// CHG
char *contents;
long int filelen;
long int getFSize(FILE *); 
int ReadFile(char *);
int ack_num = 0;
int ack_recv = 0;
int seq_num = 1;
int to_close = 0;
int numFlows = 0;
int numtocancel = 0;
int *dupcnt; 
int sleepthreads = 0;
//on the assumption we will not have to handle more than 16 connections...
// CHG


void *send_thread(void *args)
{
    threadArgs *ta = (threadArgs *) args;
    int sock = ta->conn_sock;
    struct packet *pkt;
    int last_type, last_state;

    ssize_t count;
    //char *ptr1 = NULL;
    int numtocopy = 0;
    int numtimes = 0;

    socklen_t tmp = sizeof(struct sockaddr);

    //pthread_detach(pthread_self());
   pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &last_type);	
   pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &last_state);

    while (1)  {
        if (to_close) {
           break;
        }
        if ( ((seq_num - ack_recv) > RWIN)) {
           //printf("Continuing ack %d, seq %d \n", ack_recv, seq_num);
           numtimes++;
           if ((numtimes > 500000) && (ack_recv == 0)) {
              printf("No progress from server for 1/2 million iterations: Ack received is %d from server in flow %d\n", ack_recv, ta->conn_num);
              numtimes = 0;
              pthread_mutex_lock(&lock);
              seq_num = 1;
              printf("Re-transmitting..... \n");
              pthread_mutex_unlock(&lock);
           }
           sleep(0);
           continue;
        }

        if (dupcnt[ta->conn_num] > 0 && dupcnt[ta->conn_num] > (RWIN/numFlows)) {
            printf("Congestion in flow %d--backing off flow %d for now.. \n", ta->conn_num, ta->conn_num);
            if (sleepthreads < (numFlows/2)) {
                sleepthreads++;
                sleep(3);
                //sleepthreads--;
                continue;
            }
            else {
              sleepthreads = 0;
            }
        }
        pkt = (struct packet *)malloc(sizeof(struct packet));
        pkt->header = (struct mptcp_header *)malloc(sizeof(struct mptcp_header));
        pkt->data = (char *)calloc(sizeof(char), MSS+1);
        memset(pkt->data, '\0', MSS+1);

        getsockname(sock, (struct sockaddr *)&(pkt->header->src_addr), &tmp);
        getpeername(sock, (struct sockaddr *)&(pkt->header->dest_addr), &tmp);
        
        //#ifdef MUTEX
        //printf("Send TRY to get lock\n");
        pthread_mutex_lock(&lock);
        //printf("Send GOT lock\n");
        //#endif
        if (seq_num >= filelen) {
           //printf("Continuing ack %d, seq %d \n", ack_recv, seq_num);
           pthread_mutex_unlock(&lock);
           //printf("Send REL lock\n");
           sleep(0);
           continue;
        }

        if ((seq_num + MSS - 2) < filelen) {
            numtocopy = MSS;
        }
        else { 
            numtocopy = filelen - seq_num + 1;
        }
        strncpy(pkt->data, contents+seq_num-1, numtocopy);   
        pkt->header->seq_num = seq_num;
        pkt->header->ack_num = ack_num;        
        seq_num = seq_num + strlen(pkt->data);

        pkt->header->total_bytes = (int)filelen;
        if (!to_close) {
            count = mp_send(sock, pkt, strlen(pkt->data), 0); 
            if (count <= 0) {
               printf("send count is less than zero %d %d\n", to_close, ta->conn_num);
               //to_close = 1;
               //break;
            }
        }
        //#ifdef MUTEX
        dupcnt[ta->conn_num]++;
        pthread_mutex_unlock (&lock);
        //printf("Send REL lock\n");
        //#endif
        free(pkt->data);
        free(pkt->header);
        free(pkt);
        sleep(0);
    }
    printf("Send thread of flow %d done\n", ta->conn_num);
    //printf("Waiting to get cancelled %d\n", ta->conn_num);
    while(1) {sleep(0);}
}

void *recv_thread(void *args)
{
   threadArgs *ta = (threadArgs *) args;
   int sock = ta->conn_sock;
   struct packet pkt;
   int count = 0;
   int last_type, last_state;
   
   //struct timeval read_timeout;
   //read_timeout.tv_sec = 0;
   //read_timeout.tv_usec = 100;
  
   pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &last_type);	
   pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &last_state);

   pkt.header = (struct mptcp_header *)calloc(1, sizeof(struct mptcp_header));
   pkt.data = (char *)calloc(MSS, sizeof(char));
   
   while (1) {
       if (to_close) {
          break;
       }
       if (!to_close) {
           count = mp_recv(sock, &pkt, sizeof(pkt), 0);
       }
       if (count <= 0) {
          printf("recv count less than zero\n");
          //to_close = 1;
          //break;
       }
       //#ifdef MUTEX
       //printf("Recv TRY lock\n");
       pthread_mutex_lock(&lock);
       //printf("Recv GOT lock\n");
       //#endif

       /* dupcnt of a connection cannot be zero. But still, we check it */
       if (dupcnt[ta->conn_num] > 0) {
           dupcnt[ta->conn_num]--;
       }
       if (pkt.header->ack_num < 0) {
          printf("Received ack -1 in flow %d\n", ta->conn_num);
          to_close = 1;

          //#ifdef MUTEX
          pthread_mutex_unlock(&lock);
          //printf("Recv REL lock\n");
          //#endif
          break;
       }
       if (ack_recv < pkt.header->ack_num){
          ack_recv = pkt.header->ack_num;
       }       
       else if (ack_recv == pkt.header->ack_num && ack_recv > 0) {
           //put an if condition that takes tihs into account in the send thread 
           seq_num = pkt.header->ack_num;
       }
       //#ifdef MUTEX
       pthread_mutex_unlock(&lock);
       //printf("Recv REL lock\n");
       //#endif
   }
   printf("Receive thread of flow %d done.\n", ta->conn_num);
   free(pkt.header);
   free(pkt.data);

   //pthread_cond_signal(&(ta->i2am_done));
   pthread_cond_broadcast(&(i2am_done));
   //printf(" recv done %d\n", ta->conn_num);
   //printf(" waiting to get cacelled %d\n", ta->conn_num);
   while(1){ sleep(0);}
}

void *conn_handler(void *t)
{
    threadArgs *recieved = (threadArgs *)t;

    int sockfd;
    struct addrinfo hints, *servinfo, *p;
    int rv;

    threadArgs *ta;

    pthread_t send_handler;
    pthread_t recv_handler;
    int last_type, last_state;
    	
    //printf ("Game over%d\n", to_close);
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC; // use AF_INET6 to force IPv6
    hints.ai_socktype = SOCK_MPTCP;

    if ((rv = getaddrinfo(recieved->ipaddr, recieved->port, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
        exit(1);
    }

// loop through all the results and connect to the first we can
    for(p = servinfo; p != NULL; p = p->ai_next) {
        if ((sockfd = mp_socket(p->ai_family, p->ai_socktype,
              p->ai_protocol)) == -1) {
            perror("socket");
            continue;
        }

        if (mp_connect(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
            perror("connect");
            close(sockfd);
            continue;
        }

        break; // if we get here, we must have connected successfully
    }
    ta = (threadArgs *)calloc(1, sizeof(threadArgs));

    ta->conn_sock = sockfd;
    ta->conn_num = recieved->conn_num;;
    strcpy(ta->ipaddr, recieved->ipaddr);
    strcpy(ta->port, recieved->port);

    if( pthread_create(&recv_handler , NULL ,  recv_thread, (void*) ta) < 0) {
         perror("could not create recv thread");
    }
    //printf("Created recv Thread %lx\n", recv_handler);
    if( pthread_create(&send_handler , NULL ,  send_thread, (void*) ta) < 0) {
         perror("could not create send thread");
    }
    //printf("Created Send Thread %lx\n", send_handler);

    if (to_close == 0) {
        //printf("CONN  TRY c2mutex\n");
        pthread_mutex_lock(&c2_mutex);
        //printf("CONN  GOT c2mutex\n");
        pthread_cond_wait(&i2am_done, &c2_mutex);	
        pthread_mutex_unlock(&c2_mutex);
        //printf("CONN  REL c2mutex\n");
    }

    close(sockfd);
    pthread_cancel(recv_handler);
    pthread_cancel(send_handler);
    printf("Flow Handler %d, is done \n", recieved->conn_num);
    numtocancel--;

    if (numtocancel <= 0) {
       pthread_cond_signal(&iam_done);
       pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &last_type);	
       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &last_state);
    }

    //printf("conn handler waiting to get canceled\n");
    while(1) {sleep(1);} 
}

int ReadFile(char *fname) 
{
    FILE *fp;
    char c;
    long int pos = 0;

    fp = fopen(fname, "r");
    if (fp == NULL)
        return 0;
    filelen = getFSize(fp);
    if (filelen <= 0) 
        return 0;
    contents = (char *)calloc(filelen+1, sizeof(char));
    do {
       c = fgetc(fp);
       if (feof(fp))
           break;
       contents[pos++] = c;
    } while(1);
    contents[pos] = '\0';
    fclose(fp);
    return 1;
}

long int getFSize(FILE *fp) 
{
    long int init_pos;
    long int len = 0;
   
    init_pos = ftell(fp);
    fseek(fp, 0L, SEEK_END);
    len = ftell(fp);
    fseek(fp, init_pos, SEEK_SET);
    return len;
}

int main(int argc, char **argv)
{
    char *servIP;
    char *port;
    char *filename;
    char *num_interfaces;
/***************** Command Line Processing **************************/
    int c;
    extern char *optarg;
    extern int optopt, optind;
    
    while ((c = getopt(argc, argv, "n:h:p:f:")) != -1){
          switch (c)
          {
             case 'n':
               num_interfaces = optarg;
               //printf("%s\n", num_interfaces);
               break;
             case 'h':
               servIP = optarg;
               //printf("%s\n", servIP);
               break;
             case 'p':
               port = optarg;
               //printf("%s\n", port);
               break;
             case 'f':
               filename = optarg;
               //printf("%s\n", filename);
               break;
             case '?':
               if (optopt == 'c'){
                  fprintf(stderr, "Option -%c requires an argument.\n", optopt); 
               }else if (isprint(optopt)) {
                  fprintf(stderr, "Unknown option `-%c'.\n", optopt);
               }else {
                  fprintf(stderr, "Unknown option character `\\x%x'.\n", optopt);
                  return 1;
               }
               break;
             default:
               abort();
          }
    }
/***************** End Command Line Processing **************************/
    
    
    int sockfd;
    struct addrinfo hints, *servinfo, *p;
    int rv;

    struct mptcp_header head;
    struct packet pkt;

    if (ReadFile(filename) == 0) {
        fprintf(stderr, "Error in handling the file\n");
        exit(1);
    }

    //#ifdef MUTEX
    pthread_mutex_init(&lock, NULL);
    //#endif

    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC; // use AF_INET6 to force IPv6
    hints.ai_socktype = SOCK_MPTCP;

    if ((rv = getaddrinfo(servIP, port, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
        exit(1);
    }
// loop through all the results and connect to the first we can
    for(p = servinfo; p != NULL; p = p->ai_next) {
        if ((sockfd = mp_socket(p->ai_family, p->ai_socktype,
              p->ai_protocol)) == -1) {
            perror("socket");
            continue;
        }

        if (mp_connect(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
            perror("connect");
            close(sockfd);
            continue;
        }

        break; // if we get here, we must have connected successfully
    }

    if (p == NULL) {
        // looped off the end of the list with no connection
        fprintf(stderr, "failed to connect\n");
        exit(2);
    }

    memset(&head, 0, sizeof(head));

    socklen_t tmp = sizeof(struct sockaddr);
    //char str[INET_ADDRSTRLEN];

    //head.dest_addr.sin_family = AF_INET;
    //head.dest_addr.sin_port = htons(5233);
    //inet_pton(AF_INET, servIP, &(head.dest_addr.sin_addr.s_addr));

    getsockname(sockfd, (struct sockaddr *)&(head.src_addr), &tmp);
    getpeername(sockfd, (struct sockaddr *)&(head.dest_addr), &tmp);

    //inet_ntop(AF_INET, &(head.src_addr.sin_addr), str, INET_ADDRSTRLEN);

    head.ack_num = head.seq_num = 0;

    pkt.header = &head;
    pkt.data = (char *)malloc(128);
    strcpy(pkt.data, "MPREQ ");
    strcat(pkt.data, num_interfaces);
    //print_pkt(&pkt);

    int bytes_status = -1;
    bytes_status = mp_send(sockfd, &pkt, strlen(pkt.data), 0);
    if (bytes_status < 0){
       fprintf(stderr, "Error in mp_send\n");
       exit(1);
    }
    printf("Waiting for ports to be allocated...\n");

    struct packet pp;
    pp.header = malloc(sizeof(struct mptcp_header));
    // Make the data buffer large enough to receive all the ports
    pp.data = malloc(2*MSS*sizeof(char));
    memset(pp.data, '\0', 2*MSS);

    bytes_status = mp_recv(sockfd, &pp, 2*MSS, 0);
    if (bytes_status <= 0) {
        printf("Error in recieving port numbers\n");
        exit(1);
    }
    //print_pkt(&pp);

    printf("Received ports..\n");
    if (strstr(pp.data, "MPOK") == NULL){
       fprintf(stderr, "ERROR: received garbage from server\n");
       exit(1);
    }
    char *ports[MAXPORTS];
    int i = 0;

    char *portnew; //replace this with an array for multiple ports later
    portnew = pp.data;
    
    /*if (pp.header->ack_num == -1){
         break;
      }*/
      //char *ports[100];
    char *search = " ";
    char *pports;
    char *colon = ":";
    portnew = strtok(portnew, search);
    while (portnew != NULL){
       //printf("%s\n", portnew);
        if (strcmp("MPOK", portnew) == 0){
           portnew = strtok(NULL, search);
           continue;
        }
        pports = portnew;
       //printf("%s\n", ports[i]);
        portnew = strtok(NULL, search);
     }
     char *newptr = strtok(pports, colon);
     while (newptr != NULL){
          ports[i] = newptr;
         //printf("%s\n", ports[i]);
          i = i + 1;
          newptr = strtok(NULL, colon);
     }
    //}
     close(sockfd);

     /*************** connect to ports now ********************/
     printf("Asked for %s, got %d\n", num_interfaces, i);
     int len = i;
     numFlows = len;
     i = 0;

     dupcnt = (int *)calloc(numFlows, sizeof(int));

     pthread_t threadIDs[len];

     pthread_cond_init(&(iam_done), NULL);
     pthread_mutex_init(&(count_mutex), NULL);
     pthread_cond_init(&(i2am_done), NULL);
     pthread_mutex_init(&(c2_mutex), NULL);
         
     numtocancel = numFlows; /* Keep track of threads to cancel */
     for (i = 0; i < len; i++){
         pthread_t conn_thread;
         threadArgs *ta = (threadArgs *)calloc(1, sizeof(threadArgs));
         strcpy(ta->ipaddr, servIP);
         strcpy(ta->port, ports[i]);
         ta->conn_num = i;
         dupcnt[i] = 0;
         if( pthread_create(&conn_thread,NULL,conn_handler,(void*) ta) < 0) {
             perror("creating conn handler\n");
         }
         threadIDs[i] = conn_thread;
     }
    //printf("Main TRY countmutex\n");
    pthread_mutex_lock(&count_mutex);	
    //printf("Main GOT countmutex\n");
    pthread_cond_wait(&iam_done, &count_mutex);	
    pthread_mutex_unlock(&count_mutex);
    //printf("Main REL countmutex\n");
    printf ("Flow handlers completing.....\n");
    //pthread_mutex_unlock(&count_mutex);
    for (i = 0; i < len; i++) {
         pthread_cancel(threadIDs[i]);
     }
    for (i = 0; i < len; i++) {
         pthread_join(threadIDs[i],NULL);
    }
    printf ("Flow Handlers %d done.\n", len); 
    
    //#ifdef MUTEX
    //printf("Main Destroy\n");
    //pthread_mutex_destroy(&lock);
    //thread_mutex_destroy(&count_mutex);
    //thread_mutex_destroy(&c2_mutex);
    //#endif
    //pthread_exit(NULL);
    //exit(0);
    while(numtocancel > 0) {
        sleep(1);
    }
    printf("Main done.\n");
}
