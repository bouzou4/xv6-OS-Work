
_tail:     file format elf32-i386


Disassembly of section .text:

00000000 <tail>:
#include "user.h"

char buf[4096];

void tail(int fd, int lines)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
    int n, lnum, start;
    lnum = lines;
   6:	8b 45 0c             	mov    0xc(%ebp),%eax
   9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    start = 0;
   c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    
    while((n = read(fd, buf, sizeof(buf))) > 0) {
  13:	eb 76                	jmp    8b <tail+0x8b>
        for (int i = sizeof(buf); i > 0; i--) {
  15:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  1c:	eb 2a                	jmp    48 <tail+0x48>
            if (buf[i] == '\n') {
  1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  21:	05 40 0c 00 00       	add    $0xc40,%eax
  26:	0f b6 00             	movzbl (%eax),%eax
  29:	3c 0a                	cmp    $0xa,%al
  2b:	75 17                	jne    44 <tail+0x44>
                if (lnum > 0) {
  2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  31:	7e 06                	jle    39 <tail+0x39>
                    lnum--;
  33:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  37:	eb 0b                	jmp    44 <tail+0x44>
                }
                else {
                    start = i + 1;
  39:	8b 45 ec             	mov    -0x14(%ebp),%eax
  3c:	83 c0 01             	add    $0x1,%eax
  3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
                    break;
  42:	eb 0a                	jmp    4e <tail+0x4e>
        for (int i = sizeof(buf); i > 0; i--) {
  44:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
  48:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  4c:	7f d0                	jg     1e <tail+0x1e>
                }
            }
        }
        
        while (buf[start] != buf[sizeof(buf)]) {
  4e:	eb 25                	jmp    75 <tail+0x75>
           printf(1, "%c", buf[start]);
  50:	8b 45 f0             	mov    -0x10(%ebp),%eax
  53:	05 40 0c 00 00       	add    $0xc40,%eax
  58:	0f b6 00             	movzbl (%eax),%eax
  5b:	0f be c0             	movsbl %al,%eax
  5e:	83 ec 04             	sub    $0x4,%esp
  61:	50                   	push   %eax
  62:	68 60 09 00 00       	push   $0x960
  67:	6a 01                	push   $0x1
  69:	e8 3c 05 00 00       	call   5aa <printf>
  6e:	83 c4 10             	add    $0x10,%esp
            start++;
  71:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        while (buf[start] != buf[sizeof(buf)]) {
  75:	8b 45 f0             	mov    -0x10(%ebp),%eax
  78:	05 40 0c 00 00       	add    $0xc40,%eax
  7d:	0f b6 10             	movzbl (%eax),%edx
  80:	0f b6 05 40 1c 00 00 	movzbl 0x1c40,%eax
  87:	38 c2                	cmp    %al,%dl
  89:	75 c5                	jne    50 <tail+0x50>
    while((n = read(fd, buf, sizeof(buf))) > 0) {
  8b:	83 ec 04             	sub    $0x4,%esp
  8e:	68 00 10 00 00       	push   $0x1000
  93:	68 40 0c 00 00       	push   $0xc40
  98:	ff 75 08             	pushl  0x8(%ebp)
  9b:	e8 ab 03 00 00       	call   44b <read>
  a0:	83 c4 10             	add    $0x10,%esp
  a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  a6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  aa:	0f 8f 65 ff ff ff    	jg     15 <tail+0x15>
        }
    }
    
    if(n < 0) {
  b0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  b4:	79 17                	jns    cd <tail+0xcd>
        printf(1, "tail: read error\n");
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 63 09 00 00       	push   $0x963
  be:	6a 01                	push   $0x1
  c0:	e8 e5 04 00 00       	call   5aa <printf>
  c5:	83 c4 10             	add    $0x10,%esp
        exit();
  c8:	e8 66 03 00 00       	call   433 <exit>
    }
    
    exit();
  cd:	e8 61 03 00 00       	call   433 <exit>

000000d2 <main>:
}

int main(int argc, char *argv[])
{
  d2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  d6:	83 e4 f0             	and    $0xfffffff0,%esp
  d9:	ff 71 fc             	pushl  -0x4(%ecx)
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  df:	53                   	push   %ebx
  e0:	51                   	push   %ecx
  e1:	83 ec 10             	sub    $0x10,%esp
  e4:	89 cb                	mov    %ecx,%ebx
    int fd;
    
    if(argc <= 1){
  e6:	83 3b 01             	cmpl   $0x1,(%ebx)
  e9:	7f 14                	jg     ff <main+0x2d>
        tail(0, 0);
  eb:	83 ec 08             	sub    $0x8,%esp
  ee:	6a 00                	push   $0x0
  f0:	6a 00                	push   $0x0
  f2:	e8 09 ff ff ff       	call   0 <tail>
  f7:	83 c4 10             	add    $0x10,%esp
        exit();
  fa:	e8 34 03 00 00       	call   433 <exit>
    }
    
    if (argc == 2) {
  ff:	83 3b 02             	cmpl   $0x2,(%ebx)
 102:	75 51                	jne    155 <main+0x83>
        if((fd = open(argv[1], 0)) < 0){
 104:	8b 43 04             	mov    0x4(%ebx),%eax
 107:	83 c0 04             	add    $0x4,%eax
 10a:	8b 00                	mov    (%eax),%eax
 10c:	83 ec 08             	sub    $0x8,%esp
 10f:	6a 00                	push   $0x0
 111:	50                   	push   %eax
 112:	e8 5c 03 00 00       	call   473 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 11d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 121:	79 20                	jns    143 <main+0x71>
            printf(1, "tail: cannot open %s\n", argv[1]);
 123:	8b 43 04             	mov    0x4(%ebx),%eax
 126:	83 c0 04             	add    $0x4,%eax
 129:	8b 00                	mov    (%eax),%eax
 12b:	83 ec 04             	sub    $0x4,%esp
 12e:	50                   	push   %eax
 12f:	68 75 09 00 00       	push   $0x975
 134:	6a 01                	push   $0x1
 136:	e8 6f 04 00 00       	call   5aa <printf>
 13b:	83 c4 10             	add    $0x10,%esp
            exit();
 13e:	e8 f0 02 00 00       	call   433 <exit>
        }
        tail(fd, 10);
 143:	83 ec 08             	sub    $0x8,%esp
 146:	6a 0a                	push   $0xa
 148:	ff 75 f4             	pushl  -0xc(%ebp)
 14b:	e8 b0 fe ff ff       	call   0 <tail>
 150:	83 c4 10             	add    $0x10,%esp
 153:	eb 74                	jmp    1c9 <main+0xf7>
    }
    
    else if (argc == 3) {
 155:	83 3b 03             	cmpl   $0x3,(%ebx)
 158:	75 6f                	jne    1c9 <main+0xf7>
        if((fd = open(argv[2], 0)) < 0){
 15a:	8b 43 04             	mov    0x4(%ebx),%eax
 15d:	83 c0 08             	add    $0x8,%eax
 160:	8b 00                	mov    (%eax),%eax
 162:	83 ec 08             	sub    $0x8,%esp
 165:	6a 00                	push   $0x0
 167:	50                   	push   %eax
 168:	e8 06 03 00 00       	call   473 <open>
 16d:	83 c4 10             	add    $0x10,%esp
 170:	89 45 f4             	mov    %eax,-0xc(%ebp)
 173:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 177:	79 20                	jns    199 <main+0xc7>
            printf(1, "tail: cannot open %s\n", argv[2]);
 179:	8b 43 04             	mov    0x4(%ebx),%eax
 17c:	83 c0 08             	add    $0x8,%eax
 17f:	8b 00                	mov    (%eax),%eax
 181:	83 ec 04             	sub    $0x4,%esp
 184:	50                   	push   %eax
 185:	68 75 09 00 00       	push   $0x975
 18a:	6a 01                	push   $0x1
 18c:	e8 19 04 00 00       	call   5aa <printf>
 191:	83 c4 10             	add    $0x10,%esp
            exit();
 194:	e8 9a 02 00 00       	call   433 <exit>
        }
        argv[1]++;
 199:	8b 43 04             	mov    0x4(%ebx),%eax
 19c:	83 c0 04             	add    $0x4,%eax
 19f:	8b 10                	mov    (%eax),%edx
 1a1:	83 c2 01             	add    $0x1,%edx
 1a4:	89 10                	mov    %edx,(%eax)
        tail(fd, atoi(argv[1]));
 1a6:	8b 43 04             	mov    0x4(%ebx),%eax
 1a9:	83 c0 04             	add    $0x4,%eax
 1ac:	8b 00                	mov    (%eax),%eax
 1ae:	83 ec 0c             	sub    $0xc,%esp
 1b1:	50                   	push   %eax
 1b2:	e8 ea 01 00 00       	call   3a1 <atoi>
 1b7:	83 c4 10             	add    $0x10,%esp
 1ba:	83 ec 08             	sub    $0x8,%esp
 1bd:	50                   	push   %eax
 1be:	ff 75 f4             	pushl  -0xc(%ebp)
 1c1:	e8 3a fe ff ff       	call   0 <tail>
 1c6:	83 c4 10             	add    $0x10,%esp
    }
    close(fd);
 1c9:	83 ec 0c             	sub    $0xc,%esp
 1cc:	ff 75 f4             	pushl  -0xc(%ebp)
 1cf:	e8 87 02 00 00       	call   45b <close>
 1d4:	83 c4 10             	add    $0x10,%esp
    exit();
 1d7:	e8 57 02 00 00       	call   433 <exit>

000001dc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	57                   	push   %edi
 1e0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e4:	8b 55 10             	mov    0x10(%ebp),%edx
 1e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ea:	89 cb                	mov    %ecx,%ebx
 1ec:	89 df                	mov    %ebx,%edi
 1ee:	89 d1                	mov    %edx,%ecx
 1f0:	fc                   	cld    
 1f1:	f3 aa                	rep stos %al,%es:(%edi)
 1f3:	89 ca                	mov    %ecx,%edx
 1f5:	89 fb                	mov    %edi,%ebx
 1f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1fa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1fd:	90                   	nop
 1fe:	5b                   	pop    %ebx
 1ff:	5f                   	pop    %edi
 200:	5d                   	pop    %ebp
 201:	c3                   	ret    

00000202 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 202:	55                   	push   %ebp
 203:	89 e5                	mov    %esp,%ebp
 205:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 208:	8b 45 08             	mov    0x8(%ebp),%eax
 20b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 20e:	90                   	nop
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	8d 50 01             	lea    0x1(%eax),%edx
 215:	89 55 08             	mov    %edx,0x8(%ebp)
 218:	8b 55 0c             	mov    0xc(%ebp),%edx
 21b:	8d 4a 01             	lea    0x1(%edx),%ecx
 21e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 221:	0f b6 12             	movzbl (%edx),%edx
 224:	88 10                	mov    %dl,(%eax)
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	84 c0                	test   %al,%al
 22b:	75 e2                	jne    20f <strcpy+0xd>
    ;
  return os;
 22d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 230:	c9                   	leave  
 231:	c3                   	ret    

00000232 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 232:	55                   	push   %ebp
 233:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 235:	eb 08                	jmp    23f <strcmp+0xd>
    p++, q++;
 237:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 23b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 23f:	8b 45 08             	mov    0x8(%ebp),%eax
 242:	0f b6 00             	movzbl (%eax),%eax
 245:	84 c0                	test   %al,%al
 247:	74 10                	je     259 <strcmp+0x27>
 249:	8b 45 08             	mov    0x8(%ebp),%eax
 24c:	0f b6 10             	movzbl (%eax),%edx
 24f:	8b 45 0c             	mov    0xc(%ebp),%eax
 252:	0f b6 00             	movzbl (%eax),%eax
 255:	38 c2                	cmp    %al,%dl
 257:	74 de                	je     237 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 259:	8b 45 08             	mov    0x8(%ebp),%eax
 25c:	0f b6 00             	movzbl (%eax),%eax
 25f:	0f b6 d0             	movzbl %al,%edx
 262:	8b 45 0c             	mov    0xc(%ebp),%eax
 265:	0f b6 00             	movzbl (%eax),%eax
 268:	0f b6 c0             	movzbl %al,%eax
 26b:	29 c2                	sub    %eax,%edx
 26d:	89 d0                	mov    %edx,%eax
}
 26f:	5d                   	pop    %ebp
 270:	c3                   	ret    

00000271 <strlen>:

uint
strlen(char *s)
{
 271:	55                   	push   %ebp
 272:	89 e5                	mov    %esp,%ebp
 274:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 277:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 27e:	eb 04                	jmp    284 <strlen+0x13>
 280:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 284:	8b 55 fc             	mov    -0x4(%ebp),%edx
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	01 d0                	add    %edx,%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	84 c0                	test   %al,%al
 291:	75 ed                	jne    280 <strlen+0xf>
    ;
  return n;
 293:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 296:	c9                   	leave  
 297:	c3                   	ret    

00000298 <memset>:

void*
memset(void *dst, int c, uint n)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 29b:	8b 45 10             	mov    0x10(%ebp),%eax
 29e:	50                   	push   %eax
 29f:	ff 75 0c             	pushl  0xc(%ebp)
 2a2:	ff 75 08             	pushl  0x8(%ebp)
 2a5:	e8 32 ff ff ff       	call   1dc <stosb>
 2aa:	83 c4 0c             	add    $0xc,%esp
  return dst;
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b0:	c9                   	leave  
 2b1:	c3                   	ret    

000002b2 <strchr>:

char*
strchr(const char *s, char c)
{
 2b2:	55                   	push   %ebp
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	83 ec 04             	sub    $0x4,%esp
 2b8:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bb:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2be:	eb 14                	jmp    2d4 <strchr+0x22>
    if(*s == c)
 2c0:	8b 45 08             	mov    0x8(%ebp),%eax
 2c3:	0f b6 00             	movzbl (%eax),%eax
 2c6:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2c9:	75 05                	jne    2d0 <strchr+0x1e>
      return (char*)s;
 2cb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ce:	eb 13                	jmp    2e3 <strchr+0x31>
  for(; *s; s++)
 2d0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	0f b6 00             	movzbl (%eax),%eax
 2da:	84 c0                	test   %al,%al
 2dc:	75 e2                	jne    2c0 <strchr+0xe>
  return 0;
 2de:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2e3:	c9                   	leave  
 2e4:	c3                   	ret    

000002e5 <gets>:

char*
gets(char *buf, int max)
{
 2e5:	55                   	push   %ebp
 2e6:	89 e5                	mov    %esp,%ebp
 2e8:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2f2:	eb 42                	jmp    336 <gets+0x51>
    cc = read(0, &c, 1);
 2f4:	83 ec 04             	sub    $0x4,%esp
 2f7:	6a 01                	push   $0x1
 2f9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2fc:	50                   	push   %eax
 2fd:	6a 00                	push   $0x0
 2ff:	e8 47 01 00 00       	call   44b <read>
 304:	83 c4 10             	add    $0x10,%esp
 307:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 30a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 30e:	7e 33                	jle    343 <gets+0x5e>
      break;
    buf[i++] = c;
 310:	8b 45 f4             	mov    -0xc(%ebp),%eax
 313:	8d 50 01             	lea    0x1(%eax),%edx
 316:	89 55 f4             	mov    %edx,-0xc(%ebp)
 319:	89 c2                	mov    %eax,%edx
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	01 c2                	add    %eax,%edx
 320:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 324:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 326:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 32a:	3c 0a                	cmp    $0xa,%al
 32c:	74 16                	je     344 <gets+0x5f>
 32e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 332:	3c 0d                	cmp    $0xd,%al
 334:	74 0e                	je     344 <gets+0x5f>
  for(i=0; i+1 < max; ){
 336:	8b 45 f4             	mov    -0xc(%ebp),%eax
 339:	83 c0 01             	add    $0x1,%eax
 33c:	3b 45 0c             	cmp    0xc(%ebp),%eax
 33f:	7c b3                	jl     2f4 <gets+0xf>
 341:	eb 01                	jmp    344 <gets+0x5f>
      break;
 343:	90                   	nop
      break;
  }
  buf[i] = '\0';
 344:	8b 55 f4             	mov    -0xc(%ebp),%edx
 347:	8b 45 08             	mov    0x8(%ebp),%eax
 34a:	01 d0                	add    %edx,%eax
 34c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 34f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 352:	c9                   	leave  
 353:	c3                   	ret    

00000354 <stat>:

int
stat(char *n, struct stat *st)
{
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 35a:	83 ec 08             	sub    $0x8,%esp
 35d:	6a 00                	push   $0x0
 35f:	ff 75 08             	pushl  0x8(%ebp)
 362:	e8 0c 01 00 00       	call   473 <open>
 367:	83 c4 10             	add    $0x10,%esp
 36a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 36d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 371:	79 07                	jns    37a <stat+0x26>
    return -1;
 373:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 378:	eb 25                	jmp    39f <stat+0x4b>
  r = fstat(fd, st);
 37a:	83 ec 08             	sub    $0x8,%esp
 37d:	ff 75 0c             	pushl  0xc(%ebp)
 380:	ff 75 f4             	pushl  -0xc(%ebp)
 383:	e8 03 01 00 00       	call   48b <fstat>
 388:	83 c4 10             	add    $0x10,%esp
 38b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 38e:	83 ec 0c             	sub    $0xc,%esp
 391:	ff 75 f4             	pushl  -0xc(%ebp)
 394:	e8 c2 00 00 00       	call   45b <close>
 399:	83 c4 10             	add    $0x10,%esp
  return r;
 39c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 39f:	c9                   	leave  
 3a0:	c3                   	ret    

000003a1 <atoi>:

int
atoi(const char *s)
{
 3a1:	55                   	push   %ebp
 3a2:	89 e5                	mov    %esp,%ebp
 3a4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 3a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3ae:	eb 25                	jmp    3d5 <atoi+0x34>
    n = n*10 + *s++ - '0';
 3b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3b3:	89 d0                	mov    %edx,%eax
 3b5:	c1 e0 02             	shl    $0x2,%eax
 3b8:	01 d0                	add    %edx,%eax
 3ba:	01 c0                	add    %eax,%eax
 3bc:	89 c1                	mov    %eax,%ecx
 3be:	8b 45 08             	mov    0x8(%ebp),%eax
 3c1:	8d 50 01             	lea    0x1(%eax),%edx
 3c4:	89 55 08             	mov    %edx,0x8(%ebp)
 3c7:	0f b6 00             	movzbl (%eax),%eax
 3ca:	0f be c0             	movsbl %al,%eax
 3cd:	01 c8                	add    %ecx,%eax
 3cf:	83 e8 30             	sub    $0x30,%eax
 3d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3d5:	8b 45 08             	mov    0x8(%ebp),%eax
 3d8:	0f b6 00             	movzbl (%eax),%eax
 3db:	3c 2f                	cmp    $0x2f,%al
 3dd:	7e 0a                	jle    3e9 <atoi+0x48>
 3df:	8b 45 08             	mov    0x8(%ebp),%eax
 3e2:	0f b6 00             	movzbl (%eax),%eax
 3e5:	3c 39                	cmp    $0x39,%al
 3e7:	7e c7                	jle    3b0 <atoi+0xf>
  return n;
 3e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3ec:	c9                   	leave  
 3ed:	c3                   	ret    

000003ee <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3ee:	55                   	push   %ebp
 3ef:	89 e5                	mov    %esp,%ebp
 3f1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 400:	eb 17                	jmp    419 <memmove+0x2b>
    *dst++ = *src++;
 402:	8b 45 fc             	mov    -0x4(%ebp),%eax
 405:	8d 50 01             	lea    0x1(%eax),%edx
 408:	89 55 fc             	mov    %edx,-0x4(%ebp)
 40b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 40e:	8d 4a 01             	lea    0x1(%edx),%ecx
 411:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 414:	0f b6 12             	movzbl (%edx),%edx
 417:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 419:	8b 45 10             	mov    0x10(%ebp),%eax
 41c:	8d 50 ff             	lea    -0x1(%eax),%edx
 41f:	89 55 10             	mov    %edx,0x10(%ebp)
 422:	85 c0                	test   %eax,%eax
 424:	7f dc                	jg     402 <memmove+0x14>
  return vdst;
 426:	8b 45 08             	mov    0x8(%ebp),%eax
}
 429:	c9                   	leave  
 42a:	c3                   	ret    

0000042b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 42b:	b8 01 00 00 00       	mov    $0x1,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <exit>:
SYSCALL(exit)
 433:	b8 02 00 00 00       	mov    $0x2,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <wait>:
SYSCALL(wait)
 43b:	b8 03 00 00 00       	mov    $0x3,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <pipe>:
SYSCALL(pipe)
 443:	b8 04 00 00 00       	mov    $0x4,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <read>:
SYSCALL(read)
 44b:	b8 05 00 00 00       	mov    $0x5,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <write>:
SYSCALL(write)
 453:	b8 10 00 00 00       	mov    $0x10,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <close>:
SYSCALL(close)
 45b:	b8 15 00 00 00       	mov    $0x15,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <kill>:
SYSCALL(kill)
 463:	b8 06 00 00 00       	mov    $0x6,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <exec>:
SYSCALL(exec)
 46b:	b8 07 00 00 00       	mov    $0x7,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <open>:
SYSCALL(open)
 473:	b8 0f 00 00 00       	mov    $0xf,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <mknod>:
SYSCALL(mknod)
 47b:	b8 11 00 00 00       	mov    $0x11,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <unlink>:
SYSCALL(unlink)
 483:	b8 12 00 00 00       	mov    $0x12,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <fstat>:
SYSCALL(fstat)
 48b:	b8 08 00 00 00       	mov    $0x8,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <link>:
SYSCALL(link)
 493:	b8 13 00 00 00       	mov    $0x13,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <mkdir>:
SYSCALL(mkdir)
 49b:	b8 14 00 00 00       	mov    $0x14,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <chdir>:
SYSCALL(chdir)
 4a3:	b8 09 00 00 00       	mov    $0x9,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <dup>:
SYSCALL(dup)
 4ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <getpid>:
SYSCALL(getpid)
 4b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <sbrk>:
SYSCALL(sbrk)
 4bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <sleep>:
SYSCALL(sleep)
 4c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <uptime>:
SYSCALL(uptime)
 4cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4d3:	55                   	push   %ebp
 4d4:	89 e5                	mov    %esp,%ebp
 4d6:	83 ec 18             	sub    $0x18,%esp
 4d9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4dc:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4df:	83 ec 04             	sub    $0x4,%esp
 4e2:	6a 01                	push   $0x1
 4e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4e7:	50                   	push   %eax
 4e8:	ff 75 08             	pushl  0x8(%ebp)
 4eb:	e8 63 ff ff ff       	call   453 <write>
 4f0:	83 c4 10             	add    $0x10,%esp
}
 4f3:	90                   	nop
 4f4:	c9                   	leave  
 4f5:	c3                   	ret    

000004f6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f6:	55                   	push   %ebp
 4f7:	89 e5                	mov    %esp,%ebp
 4f9:	53                   	push   %ebx
 4fa:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 504:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 508:	74 17                	je     521 <printint+0x2b>
 50a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 50e:	79 11                	jns    521 <printint+0x2b>
    neg = 1;
 510:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 517:	8b 45 0c             	mov    0xc(%ebp),%eax
 51a:	f7 d8                	neg    %eax
 51c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 51f:	eb 06                	jmp    527 <printint+0x31>
  } else {
    x = xx;
 521:	8b 45 0c             	mov    0xc(%ebp),%eax
 524:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 527:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 52e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 531:	8d 41 01             	lea    0x1(%ecx),%eax
 534:	89 45 f4             	mov    %eax,-0xc(%ebp)
 537:	8b 5d 10             	mov    0x10(%ebp),%ebx
 53a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 53d:	ba 00 00 00 00       	mov    $0x0,%edx
 542:	f7 f3                	div    %ebx
 544:	89 d0                	mov    %edx,%eax
 546:	0f b6 80 fc 0b 00 00 	movzbl 0xbfc(%eax),%eax
 54d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 551:	8b 5d 10             	mov    0x10(%ebp),%ebx
 554:	8b 45 ec             	mov    -0x14(%ebp),%eax
 557:	ba 00 00 00 00       	mov    $0x0,%edx
 55c:	f7 f3                	div    %ebx
 55e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 561:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 565:	75 c7                	jne    52e <printint+0x38>
  if(neg)
 567:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 56b:	74 2d                	je     59a <printint+0xa4>
    buf[i++] = '-';
 56d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 570:	8d 50 01             	lea    0x1(%eax),%edx
 573:	89 55 f4             	mov    %edx,-0xc(%ebp)
 576:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 57b:	eb 1d                	jmp    59a <printint+0xa4>
    putc(fd, buf[i]);
 57d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 580:	8b 45 f4             	mov    -0xc(%ebp),%eax
 583:	01 d0                	add    %edx,%eax
 585:	0f b6 00             	movzbl (%eax),%eax
 588:	0f be c0             	movsbl %al,%eax
 58b:	83 ec 08             	sub    $0x8,%esp
 58e:	50                   	push   %eax
 58f:	ff 75 08             	pushl  0x8(%ebp)
 592:	e8 3c ff ff ff       	call   4d3 <putc>
 597:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 59a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 59e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a2:	79 d9                	jns    57d <printint+0x87>
}
 5a4:	90                   	nop
 5a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5a8:	c9                   	leave  
 5a9:	c3                   	ret    

000005aa <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5aa:	55                   	push   %ebp
 5ab:	89 e5                	mov    %esp,%ebp
 5ad:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5b7:	8d 45 0c             	lea    0xc(%ebp),%eax
 5ba:	83 c0 04             	add    $0x4,%eax
 5bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5c7:	e9 59 01 00 00       	jmp    725 <printf+0x17b>
    c = fmt[i] & 0xff;
 5cc:	8b 55 0c             	mov    0xc(%ebp),%edx
 5cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d2:	01 d0                	add    %edx,%eax
 5d4:	0f b6 00             	movzbl (%eax),%eax
 5d7:	0f be c0             	movsbl %al,%eax
 5da:	25 ff 00 00 00       	and    $0xff,%eax
 5df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5e6:	75 2c                	jne    614 <printf+0x6a>
      if(c == '%'){
 5e8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ec:	75 0c                	jne    5fa <printf+0x50>
        state = '%';
 5ee:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5f5:	e9 27 01 00 00       	jmp    721 <printf+0x177>
      } else {
        putc(fd, c);
 5fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fd:	0f be c0             	movsbl %al,%eax
 600:	83 ec 08             	sub    $0x8,%esp
 603:	50                   	push   %eax
 604:	ff 75 08             	pushl  0x8(%ebp)
 607:	e8 c7 fe ff ff       	call   4d3 <putc>
 60c:	83 c4 10             	add    $0x10,%esp
 60f:	e9 0d 01 00 00       	jmp    721 <printf+0x177>
      }
    } else if(state == '%'){
 614:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 618:	0f 85 03 01 00 00    	jne    721 <printf+0x177>
      if(c == 'd'){
 61e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 622:	75 1e                	jne    642 <printf+0x98>
        printint(fd, *ap, 10, 1);
 624:	8b 45 e8             	mov    -0x18(%ebp),%eax
 627:	8b 00                	mov    (%eax),%eax
 629:	6a 01                	push   $0x1
 62b:	6a 0a                	push   $0xa
 62d:	50                   	push   %eax
 62e:	ff 75 08             	pushl  0x8(%ebp)
 631:	e8 c0 fe ff ff       	call   4f6 <printint>
 636:	83 c4 10             	add    $0x10,%esp
        ap++;
 639:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 63d:	e9 d8 00 00 00       	jmp    71a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 642:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 646:	74 06                	je     64e <printf+0xa4>
 648:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 64c:	75 1e                	jne    66c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 64e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 651:	8b 00                	mov    (%eax),%eax
 653:	6a 00                	push   $0x0
 655:	6a 10                	push   $0x10
 657:	50                   	push   %eax
 658:	ff 75 08             	pushl  0x8(%ebp)
 65b:	e8 96 fe ff ff       	call   4f6 <printint>
 660:	83 c4 10             	add    $0x10,%esp
        ap++;
 663:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 667:	e9 ae 00 00 00       	jmp    71a <printf+0x170>
      } else if(c == 's'){
 66c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 670:	75 43                	jne    6b5 <printf+0x10b>
        s = (char*)*ap;
 672:	8b 45 e8             	mov    -0x18(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 67a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 67e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 682:	75 25                	jne    6a9 <printf+0xff>
          s = "(null)";
 684:	c7 45 f4 8b 09 00 00 	movl   $0x98b,-0xc(%ebp)
        while(*s != 0){
 68b:	eb 1c                	jmp    6a9 <printf+0xff>
          putc(fd, *s);
 68d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 690:	0f b6 00             	movzbl (%eax),%eax
 693:	0f be c0             	movsbl %al,%eax
 696:	83 ec 08             	sub    $0x8,%esp
 699:	50                   	push   %eax
 69a:	ff 75 08             	pushl  0x8(%ebp)
 69d:	e8 31 fe ff ff       	call   4d3 <putc>
 6a2:	83 c4 10             	add    $0x10,%esp
          s++;
 6a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ac:	0f b6 00             	movzbl (%eax),%eax
 6af:	84 c0                	test   %al,%al
 6b1:	75 da                	jne    68d <printf+0xe3>
 6b3:	eb 65                	jmp    71a <printf+0x170>
        }
      } else if(c == 'c'){
 6b5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6b9:	75 1d                	jne    6d8 <printf+0x12e>
        putc(fd, *ap);
 6bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6be:	8b 00                	mov    (%eax),%eax
 6c0:	0f be c0             	movsbl %al,%eax
 6c3:	83 ec 08             	sub    $0x8,%esp
 6c6:	50                   	push   %eax
 6c7:	ff 75 08             	pushl  0x8(%ebp)
 6ca:	e8 04 fe ff ff       	call   4d3 <putc>
 6cf:	83 c4 10             	add    $0x10,%esp
        ap++;
 6d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6d6:	eb 42                	jmp    71a <printf+0x170>
      } else if(c == '%'){
 6d8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6dc:	75 17                	jne    6f5 <printf+0x14b>
        putc(fd, c);
 6de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e1:	0f be c0             	movsbl %al,%eax
 6e4:	83 ec 08             	sub    $0x8,%esp
 6e7:	50                   	push   %eax
 6e8:	ff 75 08             	pushl  0x8(%ebp)
 6eb:	e8 e3 fd ff ff       	call   4d3 <putc>
 6f0:	83 c4 10             	add    $0x10,%esp
 6f3:	eb 25                	jmp    71a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6f5:	83 ec 08             	sub    $0x8,%esp
 6f8:	6a 25                	push   $0x25
 6fa:	ff 75 08             	pushl  0x8(%ebp)
 6fd:	e8 d1 fd ff ff       	call   4d3 <putc>
 702:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 705:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 708:	0f be c0             	movsbl %al,%eax
 70b:	83 ec 08             	sub    $0x8,%esp
 70e:	50                   	push   %eax
 70f:	ff 75 08             	pushl  0x8(%ebp)
 712:	e8 bc fd ff ff       	call   4d3 <putc>
 717:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 71a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 721:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 725:	8b 55 0c             	mov    0xc(%ebp),%edx
 728:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72b:	01 d0                	add    %edx,%eax
 72d:	0f b6 00             	movzbl (%eax),%eax
 730:	84 c0                	test   %al,%al
 732:	0f 85 94 fe ff ff    	jne    5cc <printf+0x22>
    }
  }
}
 738:	90                   	nop
 739:	c9                   	leave  
 73a:	c3                   	ret    

0000073b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 73b:	55                   	push   %ebp
 73c:	89 e5                	mov    %esp,%ebp
 73e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 741:	8b 45 08             	mov    0x8(%ebp),%eax
 744:	83 e8 08             	sub    $0x8,%eax
 747:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	a1 28 0c 00 00       	mov    0xc28,%eax
 74f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 752:	eb 24                	jmp    778 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	8b 00                	mov    (%eax),%eax
 759:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 75c:	77 12                	ja     770 <free+0x35>
 75e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 761:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 764:	77 24                	ja     78a <free+0x4f>
 766:	8b 45 fc             	mov    -0x4(%ebp),%eax
 769:	8b 00                	mov    (%eax),%eax
 76b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 76e:	77 1a                	ja     78a <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	8b 45 fc             	mov    -0x4(%ebp),%eax
 773:	8b 00                	mov    (%eax),%eax
 775:	89 45 fc             	mov    %eax,-0x4(%ebp)
 778:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 77e:	76 d4                	jbe    754 <free+0x19>
 780:	8b 45 fc             	mov    -0x4(%ebp),%eax
 783:	8b 00                	mov    (%eax),%eax
 785:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 788:	76 ca                	jbe    754 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 78a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78d:	8b 40 04             	mov    0x4(%eax),%eax
 790:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 797:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79a:	01 c2                	add    %eax,%edx
 79c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79f:	8b 00                	mov    (%eax),%eax
 7a1:	39 c2                	cmp    %eax,%edx
 7a3:	75 24                	jne    7c9 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a8:	8b 50 04             	mov    0x4(%eax),%edx
 7ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ae:	8b 00                	mov    (%eax),%eax
 7b0:	8b 40 04             	mov    0x4(%eax),%eax
 7b3:	01 c2                	add    %eax,%edx
 7b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b8:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7be:	8b 00                	mov    (%eax),%eax
 7c0:	8b 10                	mov    (%eax),%edx
 7c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c5:	89 10                	mov    %edx,(%eax)
 7c7:	eb 0a                	jmp    7d3 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cc:	8b 10                	mov    (%eax),%edx
 7ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d1:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d6:	8b 40 04             	mov    0x4(%eax),%eax
 7d9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e3:	01 d0                	add    %edx,%eax
 7e5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7e8:	75 20                	jne    80a <free+0xcf>
    p->s.size += bp->s.size;
 7ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ed:	8b 50 04             	mov    0x4(%eax),%edx
 7f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f3:	8b 40 04             	mov    0x4(%eax),%eax
 7f6:	01 c2                	add    %eax,%edx
 7f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 801:	8b 10                	mov    (%eax),%edx
 803:	8b 45 fc             	mov    -0x4(%ebp),%eax
 806:	89 10                	mov    %edx,(%eax)
 808:	eb 08                	jmp    812 <free+0xd7>
  } else
    p->s.ptr = bp;
 80a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 810:	89 10                	mov    %edx,(%eax)
  freep = p;
 812:	8b 45 fc             	mov    -0x4(%ebp),%eax
 815:	a3 28 0c 00 00       	mov    %eax,0xc28
}
 81a:	90                   	nop
 81b:	c9                   	leave  
 81c:	c3                   	ret    

0000081d <morecore>:

static Header*
morecore(uint nu)
{
 81d:	55                   	push   %ebp
 81e:	89 e5                	mov    %esp,%ebp
 820:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 823:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 82a:	77 07                	ja     833 <morecore+0x16>
    nu = 4096;
 82c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 833:	8b 45 08             	mov    0x8(%ebp),%eax
 836:	c1 e0 03             	shl    $0x3,%eax
 839:	83 ec 0c             	sub    $0xc,%esp
 83c:	50                   	push   %eax
 83d:	e8 79 fc ff ff       	call   4bb <sbrk>
 842:	83 c4 10             	add    $0x10,%esp
 845:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 848:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 84c:	75 07                	jne    855 <morecore+0x38>
    return 0;
 84e:	b8 00 00 00 00       	mov    $0x0,%eax
 853:	eb 26                	jmp    87b <morecore+0x5e>
  hp = (Header*)p;
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 85b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85e:	8b 55 08             	mov    0x8(%ebp),%edx
 861:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 864:	8b 45 f0             	mov    -0x10(%ebp),%eax
 867:	83 c0 08             	add    $0x8,%eax
 86a:	83 ec 0c             	sub    $0xc,%esp
 86d:	50                   	push   %eax
 86e:	e8 c8 fe ff ff       	call   73b <free>
 873:	83 c4 10             	add    $0x10,%esp
  return freep;
 876:	a1 28 0c 00 00       	mov    0xc28,%eax
}
 87b:	c9                   	leave  
 87c:	c3                   	ret    

0000087d <malloc>:

void*
malloc(uint nbytes)
{
 87d:	55                   	push   %ebp
 87e:	89 e5                	mov    %esp,%ebp
 880:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 883:	8b 45 08             	mov    0x8(%ebp),%eax
 886:	83 c0 07             	add    $0x7,%eax
 889:	c1 e8 03             	shr    $0x3,%eax
 88c:	83 c0 01             	add    $0x1,%eax
 88f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 892:	a1 28 0c 00 00       	mov    0xc28,%eax
 897:	89 45 f0             	mov    %eax,-0x10(%ebp)
 89a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 89e:	75 23                	jne    8c3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8a0:	c7 45 f0 20 0c 00 00 	movl   $0xc20,-0x10(%ebp)
 8a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8aa:	a3 28 0c 00 00       	mov    %eax,0xc28
 8af:	a1 28 0c 00 00       	mov    0xc28,%eax
 8b4:	a3 20 0c 00 00       	mov    %eax,0xc20
    base.s.size = 0;
 8b9:	c7 05 24 0c 00 00 00 	movl   $0x0,0xc24
 8c0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c6:	8b 00                	mov    (%eax),%eax
 8c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ce:	8b 40 04             	mov    0x4(%eax),%eax
 8d1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8d4:	72 4d                	jb     923 <malloc+0xa6>
      if(p->s.size == nunits)
 8d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d9:	8b 40 04             	mov    0x4(%eax),%eax
 8dc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8df:	75 0c                	jne    8ed <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e4:	8b 10                	mov    (%eax),%edx
 8e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e9:	89 10                	mov    %edx,(%eax)
 8eb:	eb 26                	jmp    913 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f0:	8b 40 04             	mov    0x4(%eax),%eax
 8f3:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8f6:	89 c2                	mov    %eax,%edx
 8f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 901:	8b 40 04             	mov    0x4(%eax),%eax
 904:	c1 e0 03             	shl    $0x3,%eax
 907:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 910:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 913:	8b 45 f0             	mov    -0x10(%ebp),%eax
 916:	a3 28 0c 00 00       	mov    %eax,0xc28
      return (void*)(p + 1);
 91b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91e:	83 c0 08             	add    $0x8,%eax
 921:	eb 3b                	jmp    95e <malloc+0xe1>
    }
    if(p == freep)
 923:	a1 28 0c 00 00       	mov    0xc28,%eax
 928:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 92b:	75 1e                	jne    94b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 92d:	83 ec 0c             	sub    $0xc,%esp
 930:	ff 75 ec             	pushl  -0x14(%ebp)
 933:	e8 e5 fe ff ff       	call   81d <morecore>
 938:	83 c4 10             	add    $0x10,%esp
 93b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 93e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 942:	75 07                	jne    94b <malloc+0xce>
        return 0;
 944:	b8 00 00 00 00       	mov    $0x0,%eax
 949:	eb 13                	jmp    95e <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 94b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 951:	8b 45 f4             	mov    -0xc(%ebp),%eax
 954:	8b 00                	mov    (%eax),%eax
 956:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 959:	e9 6d ff ff ff       	jmp    8cb <malloc+0x4e>
  }
}
 95e:	c9                   	leave  
 95f:	c3                   	ret    
