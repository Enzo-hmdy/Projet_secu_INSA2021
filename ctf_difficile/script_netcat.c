/* A simple server listening on TCP port 7777 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

void error(const char *msg)
{
    perror(msg);
    exit(1);
}

int main(int argc, char *argv[])
{
    int sockfd, newsockfd, portno;
    socklen_t clilen;
    char buffer[400], reply[400];
    struct sockaddr_in serv_addr, cli_addr;
    int status;
    register int i asm("rsp");
    char rsp[19];
    
    bzero((char *)&serv_addr, sizeof(serv_addr));
    portno = 7777;
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
        error("ERROR opening socket");
    int tr = 1;

    // kill "Address already in use" error message
    if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &tr, sizeof(int)) == -1)
    {
        perror("setsockopt");
        exit(1);
    }

    if (bind(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
        error("ERROR on binding");

    listen(sockfd, 10);
    clilen = sizeof(cli_addr);
    newsockfd = accept(sockfd, (struct sockaddr *)&cli_addr, &clilen);

    if (newsockfd < 0)
        error("ERROR on accept");
       
    snprintf(rsp,19,"%#018x", i);
    write(newsockfd, "Welcome to NOM_ENTREPRISE's server!\n", 37);
    write(newsockfd, "The programm will run every 10 seconds.\nDon't hesitate to visit our github for more informations about our software.\n\n!!!!admin test!!! $rsp = ", 144);
    write(newsockfd, rsp, sizeof(rsp));

   
   
    

    while (1)
    {

        status = write(newsockfd, "\nEnter some text:\n", 19);
        bzero(buffer, 400);
        status = read(newsockfd, buffer, 800);
       
        strcpy(reply, "I got this message: ");
        strcat(reply, buffer);
        status = write(newsockfd, reply, strlen(reply));
    
    }
    status = write(newsockfd, "Bye!", 5);
    close(newsockfd);
    close(sockfd);
    return 0;
}