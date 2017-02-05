#include "types.h"
#include "stat.h"
#include "user.h"

char buf[512];

void tail(int fd)
{
    int n, lnum, start;
    lnum = 10;
    start = 0;
    
    while((n = read(fd, buf, sizeof(buf))) > 0) {
        for (int i = sizeof(buf); i > 0; i--) {
            if (buf[i] == '\n') {
                if (lnum > 1) {
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
    int fd, i;
    
    if(argc <= 1){
        tail(0);
        exit();
    }
    
    for(i = 1; i < argc; i++){
        if((fd = open(argv[i], 0)) < 0){
            printf(1, "tail: cannot open %s\n", argv[i]);
            exit();
        }
        tail(fd);
        close(fd);
    }
    exit();
}
