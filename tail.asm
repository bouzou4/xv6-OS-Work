
_tail:     file format elf32-i386


Disassembly of section .text:

00000000 <tail>:
#include "user.h"

char buf[512];

void tail(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
    int n, lnum, start;
    lnum = 10;
   6:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
    start = 0;
   d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    
    while((n = read(fd, buf, sizeof(buf))) > 0) {
  14:	eb 76                	jmp    8c <tail+0x8c>
        for (int i = sizeof(buf); i > 0; i--) {
  16:	c7 45 ec 00 02 00 00 	movl   $0x200,-0x14(%ebp)
  1d:	eb 2a                	jmp    49 <tail+0x49>
            if (buf[i] == '\n') {
  1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  22:	05 e0 0b 00 00       	add    $0xbe0,%eax
  27:	0f b6 00             	movzbl (%eax),%eax
  2a:	3c 0a                	cmp    $0xa,%al
  2c:	75 17                	jne    45 <tail+0x45>
                if (lnum > 1) {
  2e:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  32:	7e 06                	jle    3a <tail+0x3a>
                    lnum--;
  34:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  38:	eb 0b                	jmp    45 <tail+0x45>
                }
                else {
                    start = i + 1;
  3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  3d:	83 c0 01             	add    $0x1,%eax
  40:	89 45 f0             	mov    %eax,-0x10(%ebp)
                    break;
  43:	eb 0a                	jmp    4f <tail+0x4f>
        for (int i = sizeof(buf); i > 0; i--) {
  45:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
  49:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  4d:	7f d0                	jg     1f <tail+0x1f>
                }
            }
        }
        
        while (buf[start] != buf[sizeof(buf)]) {
  4f:	eb 25                	jmp    76 <tail+0x76>
           printf(1, "%c", buf[start]);
  51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  54:	05 e0 0b 00 00       	add    $0xbe0,%eax
  59:	0f b6 00             	movzbl (%eax),%eax
  5c:	0f be c0             	movsbl %al,%eax
  5f:	83 ec 04             	sub    $0x4,%esp
  62:	50                   	push   %eax
  63:	68 08 09 00 00       	push   $0x908
  68:	6a 01                	push   $0x1
  6a:	e8 e3 04 00 00       	call   552 <printf>
  6f:	83 c4 10             	add    $0x10,%esp
            start++;
  72:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        while (buf[start] != buf[sizeof(buf)]) {
  76:	8b 45 f0             	mov    -0x10(%ebp),%eax
  79:	05 e0 0b 00 00       	add    $0xbe0,%eax
  7e:	0f b6 10             	movzbl (%eax),%edx
  81:	0f b6 05 e0 0d 00 00 	movzbl 0xde0,%eax
  88:	38 c2                	cmp    %al,%dl
  8a:	75 c5                	jne    51 <tail+0x51>
    while((n = read(fd, buf, sizeof(buf))) > 0) {
  8c:	83 ec 04             	sub    $0x4,%esp
  8f:	68 00 02 00 00       	push   $0x200
  94:	68 e0 0b 00 00       	push   $0xbe0
  99:	ff 75 08             	pushl  0x8(%ebp)
  9c:	e8 52 03 00 00       	call   3f3 <read>
  a1:	83 c4 10             	add    $0x10,%esp
  a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  a7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  ab:	0f 8f 65 ff ff ff    	jg     16 <tail+0x16>
        }
    }
    
    if(n < 0) {
  b1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  b5:	79 17                	jns    ce <tail+0xce>
        printf(1, "tail: read error\n");
  b7:	83 ec 08             	sub    $0x8,%esp
  ba:	68 0b 09 00 00       	push   $0x90b
  bf:	6a 01                	push   $0x1
  c1:	e8 8c 04 00 00       	call   552 <printf>
  c6:	83 c4 10             	add    $0x10,%esp
        exit();
  c9:	e8 0d 03 00 00       	call   3db <exit>
    }
    
    exit();
  ce:	e8 08 03 00 00       	call   3db <exit>

000000d3 <main>:
}

int main(int argc, char *argv[])
{
  d3:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  d7:	83 e4 f0             	and    $0xfffffff0,%esp
  da:	ff 71 fc             	pushl  -0x4(%ecx)
  dd:	55                   	push   %ebp
  de:	89 e5                	mov    %esp,%ebp
  e0:	53                   	push   %ebx
  e1:	51                   	push   %ecx
  e2:	83 ec 10             	sub    $0x10,%esp
  e5:	89 cb                	mov    %ecx,%ebx
    int fd, i;
    
    if(argc <= 1){
  e7:	83 3b 01             	cmpl   $0x1,(%ebx)
  ea:	7f 12                	jg     fe <main+0x2b>
        tail(0);
  ec:	83 ec 0c             	sub    $0xc,%esp
  ef:	6a 00                	push   $0x0
  f1:	e8 0a ff ff ff       	call   0 <tail>
  f6:	83 c4 10             	add    $0x10,%esp
        exit();
  f9:	e8 dd 02 00 00       	call   3db <exit>
    }
    
    for(i = 1; i < argc; i++){
  fe:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 105:	eb 71                	jmp    178 <main+0xa5>
        if((fd = open(argv[i], 0)) < 0){
 107:	8b 45 f4             	mov    -0xc(%ebp),%eax
 10a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 111:	8b 43 04             	mov    0x4(%ebx),%eax
 114:	01 d0                	add    %edx,%eax
 116:	8b 00                	mov    (%eax),%eax
 118:	83 ec 08             	sub    $0x8,%esp
 11b:	6a 00                	push   $0x0
 11d:	50                   	push   %eax
 11e:	e8 f8 02 00 00       	call   41b <open>
 123:	83 c4 10             	add    $0x10,%esp
 126:	89 45 f0             	mov    %eax,-0x10(%ebp)
 129:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 12d:	79 29                	jns    158 <main+0x85>
            printf(1, "tail: cannot open %s\n", argv[i]);
 12f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 132:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 139:	8b 43 04             	mov    0x4(%ebx),%eax
 13c:	01 d0                	add    %edx,%eax
 13e:	8b 00                	mov    (%eax),%eax
 140:	83 ec 04             	sub    $0x4,%esp
 143:	50                   	push   %eax
 144:	68 1d 09 00 00       	push   $0x91d
 149:	6a 01                	push   $0x1
 14b:	e8 02 04 00 00       	call   552 <printf>
 150:	83 c4 10             	add    $0x10,%esp
            exit();
 153:	e8 83 02 00 00       	call   3db <exit>
        }
        tail(fd);
 158:	83 ec 0c             	sub    $0xc,%esp
 15b:	ff 75 f0             	pushl  -0x10(%ebp)
 15e:	e8 9d fe ff ff       	call   0 <tail>
 163:	83 c4 10             	add    $0x10,%esp
        close(fd);
 166:	83 ec 0c             	sub    $0xc,%esp
 169:	ff 75 f0             	pushl  -0x10(%ebp)
 16c:	e8 92 02 00 00       	call   403 <close>
 171:	83 c4 10             	add    $0x10,%esp
    for(i = 1; i < argc; i++){
 174:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 178:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17b:	3b 03                	cmp    (%ebx),%eax
 17d:	7c 88                	jl     107 <main+0x34>
    }
    exit();
 17f:	e8 57 02 00 00       	call   3db <exit>

00000184 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	57                   	push   %edi
 188:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 189:	8b 4d 08             	mov    0x8(%ebp),%ecx
 18c:	8b 55 10             	mov    0x10(%ebp),%edx
 18f:	8b 45 0c             	mov    0xc(%ebp),%eax
 192:	89 cb                	mov    %ecx,%ebx
 194:	89 df                	mov    %ebx,%edi
 196:	89 d1                	mov    %edx,%ecx
 198:	fc                   	cld    
 199:	f3 aa                	rep stos %al,%es:(%edi)
 19b:	89 ca                	mov    %ecx,%edx
 19d:	89 fb                	mov    %edi,%ebx
 19f:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1a2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1a5:	90                   	nop
 1a6:	5b                   	pop    %ebx
 1a7:	5f                   	pop    %edi
 1a8:	5d                   	pop    %ebp
 1a9:	c3                   	ret    

000001aa <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1aa:	55                   	push   %ebp
 1ab:	89 e5                	mov    %esp,%ebp
 1ad:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1b6:	90                   	nop
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	8d 50 01             	lea    0x1(%eax),%edx
 1bd:	89 55 08             	mov    %edx,0x8(%ebp)
 1c0:	8b 55 0c             	mov    0xc(%ebp),%edx
 1c3:	8d 4a 01             	lea    0x1(%edx),%ecx
 1c6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1c9:	0f b6 12             	movzbl (%edx),%edx
 1cc:	88 10                	mov    %dl,(%eax)
 1ce:	0f b6 00             	movzbl (%eax),%eax
 1d1:	84 c0                	test   %al,%al
 1d3:	75 e2                	jne    1b7 <strcpy+0xd>
    ;
  return os;
 1d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d8:	c9                   	leave  
 1d9:	c3                   	ret    

000001da <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1da:	55                   	push   %ebp
 1db:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1dd:	eb 08                	jmp    1e7 <strcmp+0xd>
    p++, q++;
 1df:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1e3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ea:	0f b6 00             	movzbl (%eax),%eax
 1ed:	84 c0                	test   %al,%al
 1ef:	74 10                	je     201 <strcmp+0x27>
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	0f b6 10             	movzbl (%eax),%edx
 1f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fa:	0f b6 00             	movzbl (%eax),%eax
 1fd:	38 c2                	cmp    %al,%dl
 1ff:	74 de                	je     1df <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	0f b6 00             	movzbl (%eax),%eax
 207:	0f b6 d0             	movzbl %al,%edx
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	0f b6 00             	movzbl (%eax),%eax
 210:	0f b6 c0             	movzbl %al,%eax
 213:	29 c2                	sub    %eax,%edx
 215:	89 d0                	mov    %edx,%eax
}
 217:	5d                   	pop    %ebp
 218:	c3                   	ret    

00000219 <strlen>:

uint
strlen(char *s)
{
 219:	55                   	push   %ebp
 21a:	89 e5                	mov    %esp,%ebp
 21c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 21f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 226:	eb 04                	jmp    22c <strlen+0x13>
 228:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 22c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	01 d0                	add    %edx,%eax
 234:	0f b6 00             	movzbl (%eax),%eax
 237:	84 c0                	test   %al,%al
 239:	75 ed                	jne    228 <strlen+0xf>
    ;
  return n;
 23b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 23e:	c9                   	leave  
 23f:	c3                   	ret    

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 243:	8b 45 10             	mov    0x10(%ebp),%eax
 246:	50                   	push   %eax
 247:	ff 75 0c             	pushl  0xc(%ebp)
 24a:	ff 75 08             	pushl  0x8(%ebp)
 24d:	e8 32 ff ff ff       	call   184 <stosb>
 252:	83 c4 0c             	add    $0xc,%esp
  return dst;
 255:	8b 45 08             	mov    0x8(%ebp),%eax
}
 258:	c9                   	leave  
 259:	c3                   	ret    

0000025a <strchr>:

char*
strchr(const char *s, char c)
{
 25a:	55                   	push   %ebp
 25b:	89 e5                	mov    %esp,%ebp
 25d:	83 ec 04             	sub    $0x4,%esp
 260:	8b 45 0c             	mov    0xc(%ebp),%eax
 263:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 266:	eb 14                	jmp    27c <strchr+0x22>
    if(*s == c)
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	0f b6 00             	movzbl (%eax),%eax
 26e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 271:	75 05                	jne    278 <strchr+0x1e>
      return (char*)s;
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	eb 13                	jmp    28b <strchr+0x31>
  for(; *s; s++)
 278:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
 27f:	0f b6 00             	movzbl (%eax),%eax
 282:	84 c0                	test   %al,%al
 284:	75 e2                	jne    268 <strchr+0xe>
  return 0;
 286:	b8 00 00 00 00       	mov    $0x0,%eax
}
 28b:	c9                   	leave  
 28c:	c3                   	ret    

0000028d <gets>:

char*
gets(char *buf, int max)
{
 28d:	55                   	push   %ebp
 28e:	89 e5                	mov    %esp,%ebp
 290:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 293:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 29a:	eb 42                	jmp    2de <gets+0x51>
    cc = read(0, &c, 1);
 29c:	83 ec 04             	sub    $0x4,%esp
 29f:	6a 01                	push   $0x1
 2a1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2a4:	50                   	push   %eax
 2a5:	6a 00                	push   $0x0
 2a7:	e8 47 01 00 00       	call   3f3 <read>
 2ac:	83 c4 10             	add    $0x10,%esp
 2af:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2b6:	7e 33                	jle    2eb <gets+0x5e>
      break;
    buf[i++] = c;
 2b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2bb:	8d 50 01             	lea    0x1(%eax),%edx
 2be:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2c1:	89 c2                	mov    %eax,%edx
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	01 c2                	add    %eax,%edx
 2c8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2cc:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2ce:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2d2:	3c 0a                	cmp    $0xa,%al
 2d4:	74 16                	je     2ec <gets+0x5f>
 2d6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2da:	3c 0d                	cmp    $0xd,%al
 2dc:	74 0e                	je     2ec <gets+0x5f>
  for(i=0; i+1 < max; ){
 2de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e1:	83 c0 01             	add    $0x1,%eax
 2e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2e7:	7c b3                	jl     29c <gets+0xf>
 2e9:	eb 01                	jmp    2ec <gets+0x5f>
      break;
 2eb:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	01 d0                	add    %edx,%eax
 2f4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2fa:	c9                   	leave  
 2fb:	c3                   	ret    

000002fc <stat>:

int
stat(char *n, struct stat *st)
{
 2fc:	55                   	push   %ebp
 2fd:	89 e5                	mov    %esp,%ebp
 2ff:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 302:	83 ec 08             	sub    $0x8,%esp
 305:	6a 00                	push   $0x0
 307:	ff 75 08             	pushl  0x8(%ebp)
 30a:	e8 0c 01 00 00       	call   41b <open>
 30f:	83 c4 10             	add    $0x10,%esp
 312:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 315:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 319:	79 07                	jns    322 <stat+0x26>
    return -1;
 31b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 320:	eb 25                	jmp    347 <stat+0x4b>
  r = fstat(fd, st);
 322:	83 ec 08             	sub    $0x8,%esp
 325:	ff 75 0c             	pushl  0xc(%ebp)
 328:	ff 75 f4             	pushl  -0xc(%ebp)
 32b:	e8 03 01 00 00       	call   433 <fstat>
 330:	83 c4 10             	add    $0x10,%esp
 333:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 336:	83 ec 0c             	sub    $0xc,%esp
 339:	ff 75 f4             	pushl  -0xc(%ebp)
 33c:	e8 c2 00 00 00       	call   403 <close>
 341:	83 c4 10             	add    $0x10,%esp
  return r;
 344:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 347:	c9                   	leave  
 348:	c3                   	ret    

00000349 <atoi>:

int
atoi(const char *s)
{
 349:	55                   	push   %ebp
 34a:	89 e5                	mov    %esp,%ebp
 34c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 34f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 356:	eb 25                	jmp    37d <atoi+0x34>
    n = n*10 + *s++ - '0';
 358:	8b 55 fc             	mov    -0x4(%ebp),%edx
 35b:	89 d0                	mov    %edx,%eax
 35d:	c1 e0 02             	shl    $0x2,%eax
 360:	01 d0                	add    %edx,%eax
 362:	01 c0                	add    %eax,%eax
 364:	89 c1                	mov    %eax,%ecx
 366:	8b 45 08             	mov    0x8(%ebp),%eax
 369:	8d 50 01             	lea    0x1(%eax),%edx
 36c:	89 55 08             	mov    %edx,0x8(%ebp)
 36f:	0f b6 00             	movzbl (%eax),%eax
 372:	0f be c0             	movsbl %al,%eax
 375:	01 c8                	add    %ecx,%eax
 377:	83 e8 30             	sub    $0x30,%eax
 37a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 37d:	8b 45 08             	mov    0x8(%ebp),%eax
 380:	0f b6 00             	movzbl (%eax),%eax
 383:	3c 2f                	cmp    $0x2f,%al
 385:	7e 0a                	jle    391 <atoi+0x48>
 387:	8b 45 08             	mov    0x8(%ebp),%eax
 38a:	0f b6 00             	movzbl (%eax),%eax
 38d:	3c 39                	cmp    $0x39,%al
 38f:	7e c7                	jle    358 <atoi+0xf>
  return n;
 391:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 394:	c9                   	leave  
 395:	c3                   	ret    

00000396 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 396:	55                   	push   %ebp
 397:	89 e5                	mov    %esp,%ebp
 399:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 39c:	8b 45 08             	mov    0x8(%ebp),%eax
 39f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3a2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3a8:	eb 17                	jmp    3c1 <memmove+0x2b>
    *dst++ = *src++;
 3aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ad:	8d 50 01             	lea    0x1(%eax),%edx
 3b0:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3b6:	8d 4a 01             	lea    0x1(%edx),%ecx
 3b9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3bc:	0f b6 12             	movzbl (%edx),%edx
 3bf:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3c1:	8b 45 10             	mov    0x10(%ebp),%eax
 3c4:	8d 50 ff             	lea    -0x1(%eax),%edx
 3c7:	89 55 10             	mov    %edx,0x10(%ebp)
 3ca:	85 c0                	test   %eax,%eax
 3cc:	7f dc                	jg     3aa <memmove+0x14>
  return vdst;
 3ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3d1:	c9                   	leave  
 3d2:	c3                   	ret    

000003d3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3d3:	b8 01 00 00 00       	mov    $0x1,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <exit>:
SYSCALL(exit)
 3db:	b8 02 00 00 00       	mov    $0x2,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <wait>:
SYSCALL(wait)
 3e3:	b8 03 00 00 00       	mov    $0x3,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <pipe>:
SYSCALL(pipe)
 3eb:	b8 04 00 00 00       	mov    $0x4,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <read>:
SYSCALL(read)
 3f3:	b8 05 00 00 00       	mov    $0x5,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <write>:
SYSCALL(write)
 3fb:	b8 10 00 00 00       	mov    $0x10,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <close>:
SYSCALL(close)
 403:	b8 15 00 00 00       	mov    $0x15,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <kill>:
SYSCALL(kill)
 40b:	b8 06 00 00 00       	mov    $0x6,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <exec>:
SYSCALL(exec)
 413:	b8 07 00 00 00       	mov    $0x7,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <open>:
SYSCALL(open)
 41b:	b8 0f 00 00 00       	mov    $0xf,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <mknod>:
SYSCALL(mknod)
 423:	b8 11 00 00 00       	mov    $0x11,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <unlink>:
SYSCALL(unlink)
 42b:	b8 12 00 00 00       	mov    $0x12,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <fstat>:
SYSCALL(fstat)
 433:	b8 08 00 00 00       	mov    $0x8,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <link>:
SYSCALL(link)
 43b:	b8 13 00 00 00       	mov    $0x13,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <mkdir>:
SYSCALL(mkdir)
 443:	b8 14 00 00 00       	mov    $0x14,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <chdir>:
SYSCALL(chdir)
 44b:	b8 09 00 00 00       	mov    $0x9,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <dup>:
SYSCALL(dup)
 453:	b8 0a 00 00 00       	mov    $0xa,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <getpid>:
SYSCALL(getpid)
 45b:	b8 0b 00 00 00       	mov    $0xb,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <sbrk>:
SYSCALL(sbrk)
 463:	b8 0c 00 00 00       	mov    $0xc,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <sleep>:
SYSCALL(sleep)
 46b:	b8 0d 00 00 00       	mov    $0xd,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <uptime>:
SYSCALL(uptime)
 473:	b8 0e 00 00 00       	mov    $0xe,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 47b:	55                   	push   %ebp
 47c:	89 e5                	mov    %esp,%ebp
 47e:	83 ec 18             	sub    $0x18,%esp
 481:	8b 45 0c             	mov    0xc(%ebp),%eax
 484:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 487:	83 ec 04             	sub    $0x4,%esp
 48a:	6a 01                	push   $0x1
 48c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 48f:	50                   	push   %eax
 490:	ff 75 08             	pushl  0x8(%ebp)
 493:	e8 63 ff ff ff       	call   3fb <write>
 498:	83 c4 10             	add    $0x10,%esp
}
 49b:	90                   	nop
 49c:	c9                   	leave  
 49d:	c3                   	ret    

0000049e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49e:	55                   	push   %ebp
 49f:	89 e5                	mov    %esp,%ebp
 4a1:	53                   	push   %ebx
 4a2:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4ac:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4b0:	74 17                	je     4c9 <printint+0x2b>
 4b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4b6:	79 11                	jns    4c9 <printint+0x2b>
    neg = 1;
 4b8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c2:	f7 d8                	neg    %eax
 4c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c7:	eb 06                	jmp    4cf <printint+0x31>
  } else {
    x = xx;
 4c9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4d6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4d9:	8d 41 01             	lea    0x1(%ecx),%eax
 4dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4df:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4e5:	ba 00 00 00 00       	mov    $0x0,%edx
 4ea:	f7 f3                	div    %ebx
 4ec:	89 d0                	mov    %edx,%eax
 4ee:	0f b6 80 a4 0b 00 00 	movzbl 0xba4(%eax),%eax
 4f5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4f9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4ff:	ba 00 00 00 00       	mov    $0x0,%edx
 504:	f7 f3                	div    %ebx
 506:	89 45 ec             	mov    %eax,-0x14(%ebp)
 509:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 50d:	75 c7                	jne    4d6 <printint+0x38>
  if(neg)
 50f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 513:	74 2d                	je     542 <printint+0xa4>
    buf[i++] = '-';
 515:	8b 45 f4             	mov    -0xc(%ebp),%eax
 518:	8d 50 01             	lea    0x1(%eax),%edx
 51b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 51e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 523:	eb 1d                	jmp    542 <printint+0xa4>
    putc(fd, buf[i]);
 525:	8d 55 dc             	lea    -0x24(%ebp),%edx
 528:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52b:	01 d0                	add    %edx,%eax
 52d:	0f b6 00             	movzbl (%eax),%eax
 530:	0f be c0             	movsbl %al,%eax
 533:	83 ec 08             	sub    $0x8,%esp
 536:	50                   	push   %eax
 537:	ff 75 08             	pushl  0x8(%ebp)
 53a:	e8 3c ff ff ff       	call   47b <putc>
 53f:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 542:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 546:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 54a:	79 d9                	jns    525 <printint+0x87>
}
 54c:	90                   	nop
 54d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 550:	c9                   	leave  
 551:	c3                   	ret    

00000552 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 552:	55                   	push   %ebp
 553:	89 e5                	mov    %esp,%ebp
 555:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 558:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 55f:	8d 45 0c             	lea    0xc(%ebp),%eax
 562:	83 c0 04             	add    $0x4,%eax
 565:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 568:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 56f:	e9 59 01 00 00       	jmp    6cd <printf+0x17b>
    c = fmt[i] & 0xff;
 574:	8b 55 0c             	mov    0xc(%ebp),%edx
 577:	8b 45 f0             	mov    -0x10(%ebp),%eax
 57a:	01 d0                	add    %edx,%eax
 57c:	0f b6 00             	movzbl (%eax),%eax
 57f:	0f be c0             	movsbl %al,%eax
 582:	25 ff 00 00 00       	and    $0xff,%eax
 587:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 58a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 58e:	75 2c                	jne    5bc <printf+0x6a>
      if(c == '%'){
 590:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 594:	75 0c                	jne    5a2 <printf+0x50>
        state = '%';
 596:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 59d:	e9 27 01 00 00       	jmp    6c9 <printf+0x177>
      } else {
        putc(fd, c);
 5a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a5:	0f be c0             	movsbl %al,%eax
 5a8:	83 ec 08             	sub    $0x8,%esp
 5ab:	50                   	push   %eax
 5ac:	ff 75 08             	pushl  0x8(%ebp)
 5af:	e8 c7 fe ff ff       	call   47b <putc>
 5b4:	83 c4 10             	add    $0x10,%esp
 5b7:	e9 0d 01 00 00       	jmp    6c9 <printf+0x177>
      }
    } else if(state == '%'){
 5bc:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5c0:	0f 85 03 01 00 00    	jne    6c9 <printf+0x177>
      if(c == 'd'){
 5c6:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5ca:	75 1e                	jne    5ea <printf+0x98>
        printint(fd, *ap, 10, 1);
 5cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cf:	8b 00                	mov    (%eax),%eax
 5d1:	6a 01                	push   $0x1
 5d3:	6a 0a                	push   $0xa
 5d5:	50                   	push   %eax
 5d6:	ff 75 08             	pushl  0x8(%ebp)
 5d9:	e8 c0 fe ff ff       	call   49e <printint>
 5de:	83 c4 10             	add    $0x10,%esp
        ap++;
 5e1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e5:	e9 d8 00 00 00       	jmp    6c2 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5ea:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5ee:	74 06                	je     5f6 <printf+0xa4>
 5f0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5f4:	75 1e                	jne    614 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f9:	8b 00                	mov    (%eax),%eax
 5fb:	6a 00                	push   $0x0
 5fd:	6a 10                	push   $0x10
 5ff:	50                   	push   %eax
 600:	ff 75 08             	pushl  0x8(%ebp)
 603:	e8 96 fe ff ff       	call   49e <printint>
 608:	83 c4 10             	add    $0x10,%esp
        ap++;
 60b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 60f:	e9 ae 00 00 00       	jmp    6c2 <printf+0x170>
      } else if(c == 's'){
 614:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 618:	75 43                	jne    65d <printf+0x10b>
        s = (char*)*ap;
 61a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 61d:	8b 00                	mov    (%eax),%eax
 61f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 622:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 626:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 62a:	75 25                	jne    651 <printf+0xff>
          s = "(null)";
 62c:	c7 45 f4 33 09 00 00 	movl   $0x933,-0xc(%ebp)
        while(*s != 0){
 633:	eb 1c                	jmp    651 <printf+0xff>
          putc(fd, *s);
 635:	8b 45 f4             	mov    -0xc(%ebp),%eax
 638:	0f b6 00             	movzbl (%eax),%eax
 63b:	0f be c0             	movsbl %al,%eax
 63e:	83 ec 08             	sub    $0x8,%esp
 641:	50                   	push   %eax
 642:	ff 75 08             	pushl  0x8(%ebp)
 645:	e8 31 fe ff ff       	call   47b <putc>
 64a:	83 c4 10             	add    $0x10,%esp
          s++;
 64d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 651:	8b 45 f4             	mov    -0xc(%ebp),%eax
 654:	0f b6 00             	movzbl (%eax),%eax
 657:	84 c0                	test   %al,%al
 659:	75 da                	jne    635 <printf+0xe3>
 65b:	eb 65                	jmp    6c2 <printf+0x170>
        }
      } else if(c == 'c'){
 65d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 661:	75 1d                	jne    680 <printf+0x12e>
        putc(fd, *ap);
 663:	8b 45 e8             	mov    -0x18(%ebp),%eax
 666:	8b 00                	mov    (%eax),%eax
 668:	0f be c0             	movsbl %al,%eax
 66b:	83 ec 08             	sub    $0x8,%esp
 66e:	50                   	push   %eax
 66f:	ff 75 08             	pushl  0x8(%ebp)
 672:	e8 04 fe ff ff       	call   47b <putc>
 677:	83 c4 10             	add    $0x10,%esp
        ap++;
 67a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 67e:	eb 42                	jmp    6c2 <printf+0x170>
      } else if(c == '%'){
 680:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 684:	75 17                	jne    69d <printf+0x14b>
        putc(fd, c);
 686:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 689:	0f be c0             	movsbl %al,%eax
 68c:	83 ec 08             	sub    $0x8,%esp
 68f:	50                   	push   %eax
 690:	ff 75 08             	pushl  0x8(%ebp)
 693:	e8 e3 fd ff ff       	call   47b <putc>
 698:	83 c4 10             	add    $0x10,%esp
 69b:	eb 25                	jmp    6c2 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 69d:	83 ec 08             	sub    $0x8,%esp
 6a0:	6a 25                	push   $0x25
 6a2:	ff 75 08             	pushl  0x8(%ebp)
 6a5:	e8 d1 fd ff ff       	call   47b <putc>
 6aa:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b0:	0f be c0             	movsbl %al,%eax
 6b3:	83 ec 08             	sub    $0x8,%esp
 6b6:	50                   	push   %eax
 6b7:	ff 75 08             	pushl  0x8(%ebp)
 6ba:	e8 bc fd ff ff       	call   47b <putc>
 6bf:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6c2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 6c9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6cd:	8b 55 0c             	mov    0xc(%ebp),%edx
 6d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d3:	01 d0                	add    %edx,%eax
 6d5:	0f b6 00             	movzbl (%eax),%eax
 6d8:	84 c0                	test   %al,%al
 6da:	0f 85 94 fe ff ff    	jne    574 <printf+0x22>
    }
  }
}
 6e0:	90                   	nop
 6e1:	c9                   	leave  
 6e2:	c3                   	ret    

000006e3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e3:	55                   	push   %ebp
 6e4:	89 e5                	mov    %esp,%ebp
 6e6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ec:	83 e8 08             	sub    $0x8,%eax
 6ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f2:	a1 c8 0b 00 00       	mov    0xbc8,%eax
 6f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6fa:	eb 24                	jmp    720 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ff:	8b 00                	mov    (%eax),%eax
 701:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 704:	77 12                	ja     718 <free+0x35>
 706:	8b 45 f8             	mov    -0x8(%ebp),%eax
 709:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 70c:	77 24                	ja     732 <free+0x4f>
 70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 711:	8b 00                	mov    (%eax),%eax
 713:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 716:	77 1a                	ja     732 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 718:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71b:	8b 00                	mov    (%eax),%eax
 71d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 720:	8b 45 f8             	mov    -0x8(%ebp),%eax
 723:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 726:	76 d4                	jbe    6fc <free+0x19>
 728:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72b:	8b 00                	mov    (%eax),%eax
 72d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 730:	76 ca                	jbe    6fc <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 732:	8b 45 f8             	mov    -0x8(%ebp),%eax
 735:	8b 40 04             	mov    0x4(%eax),%eax
 738:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 73f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 742:	01 c2                	add    %eax,%edx
 744:	8b 45 fc             	mov    -0x4(%ebp),%eax
 747:	8b 00                	mov    (%eax),%eax
 749:	39 c2                	cmp    %eax,%edx
 74b:	75 24                	jne    771 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 74d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 750:	8b 50 04             	mov    0x4(%eax),%edx
 753:	8b 45 fc             	mov    -0x4(%ebp),%eax
 756:	8b 00                	mov    (%eax),%eax
 758:	8b 40 04             	mov    0x4(%eax),%eax
 75b:	01 c2                	add    %eax,%edx
 75d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 760:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 763:	8b 45 fc             	mov    -0x4(%ebp),%eax
 766:	8b 00                	mov    (%eax),%eax
 768:	8b 10                	mov    (%eax),%edx
 76a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76d:	89 10                	mov    %edx,(%eax)
 76f:	eb 0a                	jmp    77b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 771:	8b 45 fc             	mov    -0x4(%ebp),%eax
 774:	8b 10                	mov    (%eax),%edx
 776:	8b 45 f8             	mov    -0x8(%ebp),%eax
 779:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 77b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77e:	8b 40 04             	mov    0x4(%eax),%eax
 781:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 788:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78b:	01 d0                	add    %edx,%eax
 78d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 790:	75 20                	jne    7b2 <free+0xcf>
    p->s.size += bp->s.size;
 792:	8b 45 fc             	mov    -0x4(%ebp),%eax
 795:	8b 50 04             	mov    0x4(%eax),%edx
 798:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79b:	8b 40 04             	mov    0x4(%eax),%eax
 79e:	01 c2                	add    %eax,%edx
 7a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a9:	8b 10                	mov    (%eax),%edx
 7ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ae:	89 10                	mov    %edx,(%eax)
 7b0:	eb 08                	jmp    7ba <free+0xd7>
  } else
    p->s.ptr = bp;
 7b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7b8:	89 10                	mov    %edx,(%eax)
  freep = p;
 7ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bd:	a3 c8 0b 00 00       	mov    %eax,0xbc8
}
 7c2:	90                   	nop
 7c3:	c9                   	leave  
 7c4:	c3                   	ret    

000007c5 <morecore>:

static Header*
morecore(uint nu)
{
 7c5:	55                   	push   %ebp
 7c6:	89 e5                	mov    %esp,%ebp
 7c8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7cb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7d2:	77 07                	ja     7db <morecore+0x16>
    nu = 4096;
 7d4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7db:	8b 45 08             	mov    0x8(%ebp),%eax
 7de:	c1 e0 03             	shl    $0x3,%eax
 7e1:	83 ec 0c             	sub    $0xc,%esp
 7e4:	50                   	push   %eax
 7e5:	e8 79 fc ff ff       	call   463 <sbrk>
 7ea:	83 c4 10             	add    $0x10,%esp
 7ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7f0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7f4:	75 07                	jne    7fd <morecore+0x38>
    return 0;
 7f6:	b8 00 00 00 00       	mov    $0x0,%eax
 7fb:	eb 26                	jmp    823 <morecore+0x5e>
  hp = (Header*)p;
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 803:	8b 45 f0             	mov    -0x10(%ebp),%eax
 806:	8b 55 08             	mov    0x8(%ebp),%edx
 809:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 80c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80f:	83 c0 08             	add    $0x8,%eax
 812:	83 ec 0c             	sub    $0xc,%esp
 815:	50                   	push   %eax
 816:	e8 c8 fe ff ff       	call   6e3 <free>
 81b:	83 c4 10             	add    $0x10,%esp
  return freep;
 81e:	a1 c8 0b 00 00       	mov    0xbc8,%eax
}
 823:	c9                   	leave  
 824:	c3                   	ret    

00000825 <malloc>:

void*
malloc(uint nbytes)
{
 825:	55                   	push   %ebp
 826:	89 e5                	mov    %esp,%ebp
 828:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82b:	8b 45 08             	mov    0x8(%ebp),%eax
 82e:	83 c0 07             	add    $0x7,%eax
 831:	c1 e8 03             	shr    $0x3,%eax
 834:	83 c0 01             	add    $0x1,%eax
 837:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 83a:	a1 c8 0b 00 00       	mov    0xbc8,%eax
 83f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 842:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 846:	75 23                	jne    86b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 848:	c7 45 f0 c0 0b 00 00 	movl   $0xbc0,-0x10(%ebp)
 84f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 852:	a3 c8 0b 00 00       	mov    %eax,0xbc8
 857:	a1 c8 0b 00 00       	mov    0xbc8,%eax
 85c:	a3 c0 0b 00 00       	mov    %eax,0xbc0
    base.s.size = 0;
 861:	c7 05 c4 0b 00 00 00 	movl   $0x0,0xbc4
 868:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86e:	8b 00                	mov    (%eax),%eax
 870:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 873:	8b 45 f4             	mov    -0xc(%ebp),%eax
 876:	8b 40 04             	mov    0x4(%eax),%eax
 879:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 87c:	72 4d                	jb     8cb <malloc+0xa6>
      if(p->s.size == nunits)
 87e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 881:	8b 40 04             	mov    0x4(%eax),%eax
 884:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 887:	75 0c                	jne    895 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 889:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88c:	8b 10                	mov    (%eax),%edx
 88e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 891:	89 10                	mov    %edx,(%eax)
 893:	eb 26                	jmp    8bb <malloc+0x96>
      else {
        p->s.size -= nunits;
 895:	8b 45 f4             	mov    -0xc(%ebp),%eax
 898:	8b 40 04             	mov    0x4(%eax),%eax
 89b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 89e:	89 c2                	mov    %eax,%edx
 8a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a9:	8b 40 04             	mov    0x4(%eax),%eax
 8ac:	c1 e0 03             	shl    $0x3,%eax
 8af:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8b8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8be:	a3 c8 0b 00 00       	mov    %eax,0xbc8
      return (void*)(p + 1);
 8c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c6:	83 c0 08             	add    $0x8,%eax
 8c9:	eb 3b                	jmp    906 <malloc+0xe1>
    }
    if(p == freep)
 8cb:	a1 c8 0b 00 00       	mov    0xbc8,%eax
 8d0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8d3:	75 1e                	jne    8f3 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8d5:	83 ec 0c             	sub    $0xc,%esp
 8d8:	ff 75 ec             	pushl  -0x14(%ebp)
 8db:	e8 e5 fe ff ff       	call   7c5 <morecore>
 8e0:	83 c4 10             	add    $0x10,%esp
 8e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8ea:	75 07                	jne    8f3 <malloc+0xce>
        return 0;
 8ec:	b8 00 00 00 00       	mov    $0x0,%eax
 8f1:	eb 13                	jmp    906 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fc:	8b 00                	mov    (%eax),%eax
 8fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 901:	e9 6d ff ff ff       	jmp    873 <malloc+0x4e>
  }
}
 906:	c9                   	leave  
 907:	c3                   	ret    
