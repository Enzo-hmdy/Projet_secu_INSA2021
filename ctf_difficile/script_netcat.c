#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int copy_buf(char *str, int sock)
{
    register int i asm("rsp");
    char rsp[19];
    snprintf(rsp, 19, "%#018x", i);
    write(sock, "\n!!!!admin test!!! $rsp = ", 27);
    write(sock, rsp, sizeof(rsp));
    char buffer[1024];
    strcpy(buffer, str);
}
void error(const char *msg)
{
    perror(msg);
    exit(1);
}

int main(int argc, char *argv[])
{
    
    int sockfd, newsockfd, portno;
    socklen_t clilen;
    char buffer[4096], reply[5100];
    struct sockaddr_in serv_addr, cli_addr;
    int n;
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
        error("ERROR opening socket");
    bzero((char *)&serv_addr, sizeof(serv_addr));
    portno = 7777;
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);
    int tr = 1;
    if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &tr, sizeof(int)) == -1)
    {
        perror("setsockopt");
        exit(1);
    }

    if (bind(sockfd, (struct sockaddr *)&serv_addr,
             sizeof(serv_addr)) < 0)
        error("ERROR on binding");
    listen(sockfd, 5);
    clilen = sizeof(cli_addr);
    newsockfd = accept(sockfd,
                       (struct sockaddr *)&cli_addr,
                       &clilen);
    if (newsockfd < 0)
        error("ERROR on accept");

    write(newsockfd, "Welcome to NOM_ENTREPRISE's server!\n", 37);
    write(newsockfd, "The programm will run every 10 seconds.\nDon't hesitate to visit our github for more informations about our software.\n", 118);
   
    while (1)
    {
        write(newsockfd, "\nEnter some text:\n", 19);
        bzero(buffer, 4096);
        n = read(newsockfd, buffer, 4095);
        if (n < 0)
            error("ERROR reading from socket");

        copy_buf(buffer, newsockfd);

        printf("Here is the message: %s\n", buffer);
        strcpy(reply, "\nI got this message: ");
        strcat(reply, buffer);
        n = write(newsockfd, reply, strlen(reply));
        if (n < 0)
            error("ERROR writing to socket");
    }
    close(newsockfd);
    close(sockfd);
    return 0;
}
