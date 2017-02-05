#include "types.h"
#include "stat.h"
#include "user.h"

char buf[4096];

void tail(int fd, int lines)
{
    int n, lnum, start;
    lnum = lines;
    start = 0;
    
    while((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = sizeof(buf); i > 0; i--) {
            if (buf[i] == '\n') {
                if (lnum > 0) {
                    lnum--;
                }
                else {
                    start = i + 1;
                    break;
                }
            }
        }
        
        while (buf[start] != buf[sizeof(buf)]) {
           printf(1, "%c", buf[start]);
            start++;
        }
    }
    
    if(n < 0) {
        printf(1, "tail: read error\n");
        exit();
    }
    
    exit();
}

int main(int argc, char *argv[])
{
    int fd;
    
    if(argc <= 1){
        tail(0, 0);
        exit();
    }
    
    if (argc == 2) {
        if((fd = open(argv[1], 0)) < 0){
            printf(1, "tail: cannot open %s\n", argv[1]);
            exit();
        }
        tail(fd, 10);
    }
    
    else if (argc == 3) {
        if((fd = open(argv[2], 0)) < 0){
            printf(1, "tail: cannot open %s\n", argv[2]);
            exit();
        }
        argv[1]++;
        tail(fd, atoi(argv[1]));
    }
    close(fd);
    exit();
}
