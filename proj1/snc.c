#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#define BACKLOG 10 /* for use in listen-this is the number of pending connections
allowed in the queue*/ 
#define BUFF_SIZE 2049 

//the client sithread function
void *cstdin_handler(void *);

//the server sothread function
void *sstdout_handler(void *);

int main(int argc, char *argv[])
{
    int server; //if 1, indicates that netcat should listen rather than initiate
    int udp; //if 1, indicates that UDP should be used
    char *hostname; //hostname, varies depending on server and udp
    char *port; //port number, varies depending on server and udp

    /************************Command Line Processing **********************/
    if (argc < 3 || argc > 5){
        fprintf(stderr, "invalid or missing options\nusage: snc [-l] [-u] [hostname] port\n");
        exit(1);
    }

    if (argc == 3){
        if (strcmp(argv[1], "-l") == 0){
            server = 1;
            udp = 0;
            port = argv[2];
            hostname = "";
        } else {
            if (strcmp(argv[1], "-u") == 0){
               fprintf(stderr, "invalid or missing options\nusage: snc [-l] [-u] [hostname] port\n");
               exit(1);
            }
            hostname = argv[1];
            server = 0;
            udp = 0;
            port = argv[2];
        }
    }

    if (argc == 4) {
        if (strcmp(argv[1], "-l") == 0){
            if (strcmp(argv[2], "-u") == 0){
                server = 1;
                udp = 1;
                port = argv[3];
                hostname = "";
            } else { 
                hostname = argv[2];
                server = 1;
                udp = 0;
                port = argv[3];
            }
        } else if (strcmp(argv[1], "-u") == 0) {
            server = 0;
            udp = 1;
            hostname = argv[2];
            port = argv[3];
        } else {
             fprintf(stderr, "invalid or missing options\nusage: snc [-l] [-u] [hostname] port\n");
             exit(1);
        }
    }

    if (argc == 5) {
        if (strcmp(argv[1], "-l") != 0){
            fprintf(stderr, "invalid or missing options\nusage: snc [-l] [-u] [hostname] port\n");
            exit(1);
        } else {
            server = 1;
        }
        if (strcmp(argv[2], "-u") != 0){
            fprintf(stderr, "invalid or missing options\nusage: snc [-l] [-u] [hostname] port\n");
            exit(1);
        } else {
            udp = 1;
        } 
        hostname = argv[3];
        port = argv[4];
    }
    //Before proceeding, make sure the user picked a good port number
    int portint = atoi(port);
    if (portint <= 1024){
        fprintf(stderr, "internal error: port already in use\n");  
        exit(1);
    }

    /************************Initial Setup**********************/
    int sockfd;
    struct addrinfo hints, *servinfo, *i;
    int gairet;

    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_INET;
    if (udp == 0){
        hints.ai_socktype = SOCK_STREAM;
    } else if (udp == 1) {
        hints.ai_socktype = SOCK_DGRAM;
    } else {
        fprintf(stderr, "udp is garbage\n");
        exit(1);
    }
    if (strcmp(hostname, "") == 0){
        hints.ai_flags = AI_PASSIVE;
        gairet = getaddrinfo(NULL, port, &hints, &servinfo);
    } else {
        gairet = getaddrinfo(hostname, port, &hints, &servinfo);
    }
    if (gairet != 0){
        fprintf(stderr, "internal error: getaddrinfo: %s\n", gai_strerror(gairet));  
        exit(1);
    }
  /************************TCP Client**********************/
  //connect to first valid result we find
  if (server == 0 && udp == 0){
     for (i = servinfo; i != NULL; i = i->ai_next){
        sockfd = socket(i->ai_family, i->ai_socktype, i->ai_protocol);
        if (sockfd == -1){
           //perror("client: socket");
           continue;
        } 
        if (connect(sockfd, i->ai_addr, i->ai_addrlen) == -1){
           close(sockfd);
           //perror("client: connect");
           continue;
        } 
        //if we get here, it means connect worked-so stop!
        break;
     }
     //if loop reached the very end without finding anything...
     if (i == NULL){
        fprintf(stderr, "internal error: client failed to connect\n");
        exit(1);
     }
     freeaddrinfo(servinfo); //servinfo not needed anymore
     cstdin_handler((void*) &sockfd);
     return 0; 
  }   
  /************************TCP Server**********************/
  //Do the same thing as for client, except using bind, accept, etc.
  if (server == 1 && udp == 0){
     for (i = servinfo; i != NULL; i = i->ai_next){
        sockfd = socket(i->ai_family, i->ai_socktype, i->ai_protocol);
        if (sockfd == -1){
           //perror("server: socket");
           continue;
        } 
        if (bind(sockfd, i->ai_addr, i->ai_addrlen) == -1){
           close(sockfd);
           //perror("server: bind");
           continue;
        } 
        //if we get here, it means bind worked-so stop!
        break;
     }
     //if loop reached the very end without finding anything...
     if (i == NULL){
        fprintf(stderr, "internal error: server failed to bind\n");
        exit(1);
     }

     freeaddrinfo(servinfo); //servinfo not needed anymore

     while (1){
        listen(sockfd, BACKLOG);
        struct sockaddr_storage their_addr;
        socklen_t addr_size;
        int new_fd;
        addr_size = sizeof their_addr;
        new_fd = accept(sockfd, (struct sockaddr *)&their_addr, &addr_size);
     
        sstdout_handler((void*) &new_fd);
        break;
     }
  }   
  /************************UDP Client**********************/
  //get the first valid result we find
  if (server == 0 && udp == 1){
     for (i = servinfo; i != NULL; i = i->ai_next){
        sockfd = socket(i->ai_family, i->ai_socktype, i->ai_protocol);
        if (sockfd == -1){
           //perror("client: socket");
           continue;
        } 
        //if we get here, it means connect worked-so stop!
        break;
     }
     //if loop reached the very end without finding anything...
     if (i == NULL){
        fprintf(stderr, "internal error: client socket failure\n");
        exit(1);
     }
     ssize_t count;
     char *buff = NULL; 

     buff = malloc(BUFF_SIZE);
     while (fgets(buff, BUFF_SIZE, stdin) > 0) {
         count = sendto(sockfd, buff, strlen(buff), 0, i->ai_addr, i->ai_addrlen);
         if (count < strlen(buff)){
             perror("internal error: Error in send\n");
         }
     }
     close (sockfd);
     freeaddrinfo(servinfo); //servinfo not needed anymore
     free(buff);
     return 0;
  }

  /************************UDP Server**********************/
  if (server == 1 && udp == 1){
     for (i = servinfo; i != NULL; i = i->ai_next){
        sockfd = socket(i->ai_family, i->ai_socktype, i->ai_protocol);
        if (sockfd == -1){
           //perror("server: socket");
           continue;
        } 
        if (bind(sockfd, i->ai_addr, i->ai_addrlen) == -1){
           close(sockfd);
           //perror("server: bind");
           continue;
        } 
        //if we get here, it means bind worked-so stop!
        break;
     }
     //if loop reached the very end without finding anything...
     if (i == NULL){
        fprintf(stderr, "internal error: server failed to bind\n");
        exit(1);
     }

     freeaddrinfo(servinfo); //servinfo not needed anymore

     while (1){
     /****************read***********************/
        struct sockaddr_storage their_addr;
        socklen_t addr_size;
        addr_size = sizeof their_addr;
        ssize_t red, count;
        char *buff = NULL; 
        buff = malloc(BUFF_SIZE);
        memset(buff, 0, BUFF_SIZE);
        count = recvfrom(sockfd, buff, BUFF_SIZE-1, 0, (struct sockaddr *)&their_addr, &addr_size);
        if (count == -1){
           fprintf(stderr, "internal error: problem with recv\n");
           exit(1);
        }
        if (count == 0){ //connection has been closed
           close(sockfd);
           free(buff);
           break;
        }
        if (count > 0){
           red = write(STDOUT_FILENO, buff, count);
           if (red < count){
              perror("internal error: Error in write\n");
           }
        }
     }
  }   
}

void *cstdin_handler(void *socket_desc)
{
   int sock = *(int*)socket_desc;
   ssize_t count;
   char *buff = NULL; 

   buff = malloc(BUFF_SIZE);
   while (fgets(buff, BUFF_SIZE, stdin) > 0) {
       count = send(sock, buff, strlen(buff), 0);
       if (count < strlen(buff)){
           perror("internal error: Error in send\n");
       }
   }
   close (sock);
   free(buff);
   return 0;
}

void *sstdout_handler(void *socket_desc)
{
  int sock = *(int*)socket_desc;
  ssize_t red, count;
  char *buff = NULL; 
  buff = malloc(BUFF_SIZE);
  memset(buff, 0, BUFF_SIZE);
  while (1){
     memset(buff, 0, BUFF_SIZE);
     count = recv(sock, buff, BUFF_SIZE, 0);
     
     if (count == -1){
        fprintf(stderr, "internal error: problem with recv\n");
        exit(1);
     }
     if (count == 0){ //connection has been closed
        close(sock);
        return 0;
     }
     if (count > 0){
        red = write(STDOUT_FILENO, buff, count);
        if (red < count){
           perror("Error in write\n");
        }
    }
  }
  close(sock);
  free(buff);
  return 0;
}
