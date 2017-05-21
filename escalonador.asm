
_RODtests:     file format elf32-i386


Disassembly of section .text:

00000000 <testedosbilhetes>:

#define VALOR 1       //valor definido em printf(inteiro fixo)  
#define FILHOS 10	//numero de filhos a serem criados para teste
#define NUMEROGRANDE 11234567 //um numero grande o suficiente para que as iterações acabem em ordem diferente, dependendo do tempo de acesso por bilhetes

void testedosbilhetes(){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
    int i=NUMEROGRANDE;
   6:	c7 45 fc 07 6d ab 00 	movl   $0xab6d07,-0x4(%ebp)
    while(i--){}
   d:	90                   	nop
   e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  11:	8d 50 ff             	lea    -0x1(%eax),%edx
  14:	89 55 fc             	mov    %edx,-0x4(%ebp)
  17:	85 c0                	test   %eax,%eax
  19:	75 f3                	jne    e <testedosbilhetes+0xe>
    i=NUMEROGRANDE; //repeti aqui para que nao precisasse incluir outra biblioteca para bigints;
  1b:	c7 45 fc 07 6d ab 00 	movl   $0xab6d07,-0x4(%ebp)
    while(i--){}
  22:	90                   	nop
  23:	8b 45 fc             	mov    -0x4(%ebp),%eax
  26:	8d 50 ff             	lea    -0x1(%eax),%edx
  29:	89 55 fc             	mov    %edx,-0x4(%ebp)
  2c:	85 c0                	test   %eax,%eax
  2e:	75 f3                	jne    23 <testedosbilhetes+0x23>
}
  30:	90                   	nop
  31:	c9                   	leave  
  32:	c3                   	ret    

00000033 <main>:

int main(){
  33:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  37:	83 e4 f0             	and    $0xfffffff0,%esp
  3a:	ff 71 fc             	pushl  -0x4(%ecx)
  3d:	55                   	push   %ebp
  3e:	89 e5                	mov    %esp,%ebp
  40:	51                   	push   %ecx
  41:	83 ec 14             	sub    $0x14,%esp
    int pid; //cria-se o pai, que dara origem a todos os outros filhos. OBS: esse processo será criado com o numero default de tickets, porem nuna ira terminar, ao contrario de seus filhos.
    int i;
    for (i=0;i<FILHOS;i++){
  44:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  4b:	eb 5d                	jmp    aa <main+0x77>
        if(i<(FILHOS/3)){
  4d:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  51:	7f 12                	jg     65 <main+0x32>
            pid=fork(1);
  53:	83 ec 0c             	sub    $0xc,%esp
  56:	6a 01                	push   $0x1
  58:	e8 cd 02 00 00       	call   32a <fork>
  5d:	83 c4 10             	add    $0x10,%esp
  60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  63:	eb 31                	jmp    96 <main+0x63>
        }else if(i>=(FILHOS/3) &&  i<(2*(FILHOS/3))    ){
  65:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  69:	7e 18                	jle    83 <main+0x50>
  6b:	83 7d f0 05          	cmpl   $0x5,-0x10(%ebp)
  6f:	7f 12                	jg     83 <main+0x50>
            pid=fork(30);
  71:	83 ec 0c             	sub    $0xc,%esp
  74:	6a 1e                	push   $0x1e
  76:	e8 af 02 00 00       	call   32a <fork>
  7b:	83 c4 10             	add    $0x10,%esp
  7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  81:	eb 13                	jmp    96 <main+0x63>
        }else{
            pid=fork(150);
  83:	83 ec 0c             	sub    $0xc,%esp
  86:	68 96 00 00 00       	push   $0x96
  8b:	e8 9a 02 00 00       	call   32a <fork>
  90:	83 c4 10             	add    $0x10,%esp
  93:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }if(pid == 0){
  96:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  9a:	75 0a                	jne    a6 <main+0x73>
            testedosbilhetes();
  9c:	e8 5f ff ff ff       	call   0 <testedosbilhetes>
            exit();
  a1:	e8 8c 02 00 00       	call   332 <exit>
}

int main(){
    int pid; //cria-se o pai, que dara origem a todos os outros filhos. OBS: esse processo será criado com o numero default de tickets, porem nuna ira terminar, ao contrario de seus filhos.
    int i;
    for (i=0;i<FILHOS;i++){
  a6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  aa:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
  ae:	7e 9d                	jle    4d <main+0x1a>
        }
        
    }
    //while (wait() != -1);
    while(1){
        pid=wait();
  b0:	e8 85 02 00 00       	call   33a <wait>
  b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if(pid<0)break;
  b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  bc:	78 17                	js     d5 <main+0xa2>
        printf(VALOR,"Filho %d Terminou!\n",pid );
  be:	83 ec 04             	sub    $0x4,%esp
  c1:	ff 75 f4             	pushl  -0xc(%ebp)
  c4:	68 5f 08 00 00       	push   $0x85f
  c9:	6a 01                	push   $0x1
  cb:	e8 d9 03 00 00       	call   4a9 <printf>
  d0:	83 c4 10             	add    $0x10,%esp
        
    }
  d3:	eb db                	jmp    b0 <main+0x7d>
        
    }
    //while (wait() != -1);
    while(1){
        pid=wait();
        if(pid<0)break;
  d5:	90                   	nop
        printf(VALOR,"Filho %d Terminou!\n",pid );
        
    }
    
    
    exit();
  d6:	e8 57 02 00 00       	call   332 <exit>

000000db <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  db:	55                   	push   %ebp
  dc:	89 e5                	mov    %esp,%ebp
  de:	57                   	push   %edi
  df:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  e3:	8b 55 10             	mov    0x10(%ebp),%edx
  e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  e9:	89 cb                	mov    %ecx,%ebx
  eb:	89 df                	mov    %ebx,%edi
  ed:	89 d1                	mov    %edx,%ecx
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  f2:	89 ca                	mov    %ecx,%edx
  f4:	89 fb                	mov    %edi,%ebx
  f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
  f9:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  fc:	90                   	nop
  fd:	5b                   	pop    %ebx
  fe:	5f                   	pop    %edi
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    

00000101 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 107:	8b 45 08             	mov    0x8(%ebp),%eax
 10a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 10d:	90                   	nop
 10e:	8b 45 08             	mov    0x8(%ebp),%eax
 111:	8d 50 01             	lea    0x1(%eax),%edx
 114:	89 55 08             	mov    %edx,0x8(%ebp)
 117:	8b 55 0c             	mov    0xc(%ebp),%edx
 11a:	8d 4a 01             	lea    0x1(%edx),%ecx
 11d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 120:	0f b6 12             	movzbl (%edx),%edx
 123:	88 10                	mov    %dl,(%eax)
 125:	0f b6 00             	movzbl (%eax),%eax
 128:	84 c0                	test   %al,%al
 12a:	75 e2                	jne    10e <strcpy+0xd>
    ;
  return os;
 12c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12f:	c9                   	leave  
 130:	c3                   	ret    

00000131 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 131:	55                   	push   %ebp
 132:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 134:	eb 08                	jmp    13e <strcmp+0xd>
    p++, q++;
 136:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 13a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 13e:	8b 45 08             	mov    0x8(%ebp),%eax
 141:	0f b6 00             	movzbl (%eax),%eax
 144:	84 c0                	test   %al,%al
 146:	74 10                	je     158 <strcmp+0x27>
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	0f b6 10             	movzbl (%eax),%edx
 14e:	8b 45 0c             	mov    0xc(%ebp),%eax
 151:	0f b6 00             	movzbl (%eax),%eax
 154:	38 c2                	cmp    %al,%dl
 156:	74 de                	je     136 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	0f b6 d0             	movzbl %al,%edx
 161:	8b 45 0c             	mov    0xc(%ebp),%eax
 164:	0f b6 00             	movzbl (%eax),%eax
 167:	0f b6 c0             	movzbl %al,%eax
 16a:	29 c2                	sub    %eax,%edx
 16c:	89 d0                	mov    %edx,%eax
}
 16e:	5d                   	pop    %ebp
 16f:	c3                   	ret    

00000170 <strlen>:

uint
strlen(char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 176:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 17d:	eb 04                	jmp    183 <strlen+0x13>
 17f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 183:	8b 55 fc             	mov    -0x4(%ebp),%edx
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	01 d0                	add    %edx,%eax
 18b:	0f b6 00             	movzbl (%eax),%eax
 18e:	84 c0                	test   %al,%al
 190:	75 ed                	jne    17f <strlen+0xf>
    ;
  return n;
 192:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 195:	c9                   	leave  
 196:	c3                   	ret    

00000197 <memset>:

void*
memset(void *dst, int c, uint n)
{
 197:	55                   	push   %ebp
 198:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 19a:	8b 45 10             	mov    0x10(%ebp),%eax
 19d:	50                   	push   %eax
 19e:	ff 75 0c             	pushl  0xc(%ebp)
 1a1:	ff 75 08             	pushl  0x8(%ebp)
 1a4:	e8 32 ff ff ff       	call   db <stosb>
 1a9:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1af:	c9                   	leave  
 1b0:	c3                   	ret    

000001b1 <strchr>:

char*
strchr(const char *s, char c)
{
 1b1:	55                   	push   %ebp
 1b2:	89 e5                	mov    %esp,%ebp
 1b4:	83 ec 04             	sub    $0x4,%esp
 1b7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ba:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1bd:	eb 14                	jmp    1d3 <strchr+0x22>
    if(*s == c)
 1bf:	8b 45 08             	mov    0x8(%ebp),%eax
 1c2:	0f b6 00             	movzbl (%eax),%eax
 1c5:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1c8:	75 05                	jne    1cf <strchr+0x1e>
      return (char*)s;
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	eb 13                	jmp    1e2 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	0f b6 00             	movzbl (%eax),%eax
 1d9:	84 c0                	test   %al,%al
 1db:	75 e2                	jne    1bf <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1e2:	c9                   	leave  
 1e3:	c3                   	ret    

000001e4 <gets>:

char*
gets(char *buf, int max)
{
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1f1:	eb 42                	jmp    235 <gets+0x51>
    cc = read(0, &c, 1);
 1f3:	83 ec 04             	sub    $0x4,%esp
 1f6:	6a 01                	push   $0x1
 1f8:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1fb:	50                   	push   %eax
 1fc:	6a 00                	push   $0x0
 1fe:	e8 47 01 00 00       	call   34a <read>
 203:	83 c4 10             	add    $0x10,%esp
 206:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 209:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 20d:	7e 33                	jle    242 <gets+0x5e>
      break;
    buf[i++] = c;
 20f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 212:	8d 50 01             	lea    0x1(%eax),%edx
 215:	89 55 f4             	mov    %edx,-0xc(%ebp)
 218:	89 c2                	mov    %eax,%edx
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	01 c2                	add    %eax,%edx
 21f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 223:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 225:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 229:	3c 0a                	cmp    $0xa,%al
 22b:	74 16                	je     243 <gets+0x5f>
 22d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 231:	3c 0d                	cmp    $0xd,%al
 233:	74 0e                	je     243 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 235:	8b 45 f4             	mov    -0xc(%ebp),%eax
 238:	83 c0 01             	add    $0x1,%eax
 23b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 23e:	7c b3                	jl     1f3 <gets+0xf>
 240:	eb 01                	jmp    243 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 242:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 243:	8b 55 f4             	mov    -0xc(%ebp),%edx
 246:	8b 45 08             	mov    0x8(%ebp),%eax
 249:	01 d0                	add    %edx,%eax
 24b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 251:	c9                   	leave  
 252:	c3                   	ret    

00000253 <stat>:

int
stat(char *n, struct stat *st)
{
 253:	55                   	push   %ebp
 254:	89 e5                	mov    %esp,%ebp
 256:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 259:	83 ec 08             	sub    $0x8,%esp
 25c:	6a 00                	push   $0x0
 25e:	ff 75 08             	pushl  0x8(%ebp)
 261:	e8 0c 01 00 00       	call   372 <open>
 266:	83 c4 10             	add    $0x10,%esp
 269:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 26c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 270:	79 07                	jns    279 <stat+0x26>
    return -1;
 272:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 277:	eb 25                	jmp    29e <stat+0x4b>
  r = fstat(fd, st);
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	ff 75 0c             	pushl  0xc(%ebp)
 27f:	ff 75 f4             	pushl  -0xc(%ebp)
 282:	e8 03 01 00 00       	call   38a <fstat>
 287:	83 c4 10             	add    $0x10,%esp
 28a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 28d:	83 ec 0c             	sub    $0xc,%esp
 290:	ff 75 f4             	pushl  -0xc(%ebp)
 293:	e8 c2 00 00 00       	call   35a <close>
 298:	83 c4 10             	add    $0x10,%esp
  return r;
 29b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 29e:	c9                   	leave  
 29f:	c3                   	ret    

000002a0 <atoi>:

int
atoi(const char *s)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2ad:	eb 25                	jmp    2d4 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2af:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2b2:	89 d0                	mov    %edx,%eax
 2b4:	c1 e0 02             	shl    $0x2,%eax
 2b7:	01 d0                	add    %edx,%eax
 2b9:	01 c0                	add    %eax,%eax
 2bb:	89 c1                	mov    %eax,%ecx
 2bd:	8b 45 08             	mov    0x8(%ebp),%eax
 2c0:	8d 50 01             	lea    0x1(%eax),%edx
 2c3:	89 55 08             	mov    %edx,0x8(%ebp)
 2c6:	0f b6 00             	movzbl (%eax),%eax
 2c9:	0f be c0             	movsbl %al,%eax
 2cc:	01 c8                	add    %ecx,%eax
 2ce:	83 e8 30             	sub    $0x30,%eax
 2d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	0f b6 00             	movzbl (%eax),%eax
 2da:	3c 2f                	cmp    $0x2f,%al
 2dc:	7e 0a                	jle    2e8 <atoi+0x48>
 2de:	8b 45 08             	mov    0x8(%ebp),%eax
 2e1:	0f b6 00             	movzbl (%eax),%eax
 2e4:	3c 39                	cmp    $0x39,%al
 2e6:	7e c7                	jle    2af <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2eb:	c9                   	leave  
 2ec:	c3                   	ret    

000002ed <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2ed:	55                   	push   %ebp
 2ee:	89 e5                	mov    %esp,%ebp
 2f0:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 2fc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2ff:	eb 17                	jmp    318 <memmove+0x2b>
    *dst++ = *src++;
 301:	8b 45 fc             	mov    -0x4(%ebp),%eax
 304:	8d 50 01             	lea    0x1(%eax),%edx
 307:	89 55 fc             	mov    %edx,-0x4(%ebp)
 30a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 30d:	8d 4a 01             	lea    0x1(%edx),%ecx
 310:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 313:	0f b6 12             	movzbl (%edx),%edx
 316:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 318:	8b 45 10             	mov    0x10(%ebp),%eax
 31b:	8d 50 ff             	lea    -0x1(%eax),%edx
 31e:	89 55 10             	mov    %edx,0x10(%ebp)
 321:	85 c0                	test   %eax,%eax
 323:	7f dc                	jg     301 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 325:	8b 45 08             	mov    0x8(%ebp),%eax
}
 328:	c9                   	leave  
 329:	c3                   	ret    

0000032a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32a:	b8 01 00 00 00       	mov    $0x1,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <exit>:
SYSCALL(exit)
 332:	b8 02 00 00 00       	mov    $0x2,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <wait>:
SYSCALL(wait)
 33a:	b8 03 00 00 00       	mov    $0x3,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <pipe>:
SYSCALL(pipe)
 342:	b8 04 00 00 00       	mov    $0x4,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <read>:
SYSCALL(read)
 34a:	b8 05 00 00 00       	mov    $0x5,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <write>:
SYSCALL(write)
 352:	b8 10 00 00 00       	mov    $0x10,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <close>:
SYSCALL(close)
 35a:	b8 15 00 00 00       	mov    $0x15,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kill>:
SYSCALL(kill)
 362:	b8 06 00 00 00       	mov    $0x6,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <exec>:
SYSCALL(exec)
 36a:	b8 07 00 00 00       	mov    $0x7,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <open>:
SYSCALL(open)
 372:	b8 0f 00 00 00       	mov    $0xf,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <mknod>:
SYSCALL(mknod)
 37a:	b8 11 00 00 00       	mov    $0x11,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <unlink>:
SYSCALL(unlink)
 382:	b8 12 00 00 00       	mov    $0x12,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <fstat>:
SYSCALL(fstat)
 38a:	b8 08 00 00 00       	mov    $0x8,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <link>:
SYSCALL(link)
 392:	b8 13 00 00 00       	mov    $0x13,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <mkdir>:
SYSCALL(mkdir)
 39a:	b8 14 00 00 00       	mov    $0x14,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <chdir>:
SYSCALL(chdir)
 3a2:	b8 09 00 00 00       	mov    $0x9,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <dup>:
SYSCALL(dup)
 3aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <getpid>:
SYSCALL(getpid)
 3b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <sbrk>:
SYSCALL(sbrk)
 3ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <sleep>:
SYSCALL(sleep)
 3c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <uptime>:
SYSCALL(uptime)
 3ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d2:	55                   	push   %ebp
 3d3:	89 e5                	mov    %esp,%ebp
 3d5:	83 ec 18             	sub    $0x18,%esp
 3d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3db:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3de:	83 ec 04             	sub    $0x4,%esp
 3e1:	6a 01                	push   $0x1
 3e3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e6:	50                   	push   %eax
 3e7:	ff 75 08             	pushl  0x8(%ebp)
 3ea:	e8 63 ff ff ff       	call   352 <write>
 3ef:	83 c4 10             	add    $0x10,%esp
}
 3f2:	90                   	nop
 3f3:	c9                   	leave  
 3f4:	c3                   	ret    

000003f5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f5:	55                   	push   %ebp
 3f6:	89 e5                	mov    %esp,%ebp
 3f8:	53                   	push   %ebx
 3f9:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 403:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 407:	74 17                	je     420 <printint+0x2b>
 409:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40d:	79 11                	jns    420 <printint+0x2b>
    neg = 1;
 40f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 416:	8b 45 0c             	mov    0xc(%ebp),%eax
 419:	f7 d8                	neg    %eax
 41b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41e:	eb 06                	jmp    426 <printint+0x31>
  } else {
    x = xx;
 420:	8b 45 0c             	mov    0xc(%ebp),%eax
 423:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 426:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 430:	8d 41 01             	lea    0x1(%ecx),%eax
 433:	89 45 f4             	mov    %eax,-0xc(%ebp)
 436:	8b 5d 10             	mov    0x10(%ebp),%ebx
 439:	8b 45 ec             	mov    -0x14(%ebp),%eax
 43c:	ba 00 00 00 00       	mov    $0x0,%edx
 441:	f7 f3                	div    %ebx
 443:	89 d0                	mov    %edx,%eax
 445:	0f b6 80 e4 0a 00 00 	movzbl 0xae4(%eax),%eax
 44c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 450:	8b 5d 10             	mov    0x10(%ebp),%ebx
 453:	8b 45 ec             	mov    -0x14(%ebp),%eax
 456:	ba 00 00 00 00       	mov    $0x0,%edx
 45b:	f7 f3                	div    %ebx
 45d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 460:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 464:	75 c7                	jne    42d <printint+0x38>
  if(neg)
 466:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46a:	74 2d                	je     499 <printint+0xa4>
    buf[i++] = '-';
 46c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46f:	8d 50 01             	lea    0x1(%eax),%edx
 472:	89 55 f4             	mov    %edx,-0xc(%ebp)
 475:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 47a:	eb 1d                	jmp    499 <printint+0xa4>
    putc(fd, buf[i]);
 47c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 47f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 482:	01 d0                	add    %edx,%eax
 484:	0f b6 00             	movzbl (%eax),%eax
 487:	0f be c0             	movsbl %al,%eax
 48a:	83 ec 08             	sub    $0x8,%esp
 48d:	50                   	push   %eax
 48e:	ff 75 08             	pushl  0x8(%ebp)
 491:	e8 3c ff ff ff       	call   3d2 <putc>
 496:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 499:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a1:	79 d9                	jns    47c <printint+0x87>
    putc(fd, buf[i]);
}
 4a3:	90                   	nop
 4a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4a7:	c9                   	leave  
 4a8:	c3                   	ret    

000004a9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a9:	55                   	push   %ebp
 4aa:	89 e5                	mov    %esp,%ebp
 4ac:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b6:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b9:	83 c0 04             	add    $0x4,%eax
 4bc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c6:	e9 59 01 00 00       	jmp    624 <printf+0x17b>
    c = fmt[i] & 0xff;
 4cb:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d1:	01 d0                	add    %edx,%eax
 4d3:	0f b6 00             	movzbl (%eax),%eax
 4d6:	0f be c0             	movsbl %al,%eax
 4d9:	25 ff 00 00 00       	and    $0xff,%eax
 4de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e5:	75 2c                	jne    513 <printf+0x6a>
      if(c == '%'){
 4e7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4eb:	75 0c                	jne    4f9 <printf+0x50>
        state = '%';
 4ed:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f4:	e9 27 01 00 00       	jmp    620 <printf+0x177>
      } else {
        putc(fd, c);
 4f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4fc:	0f be c0             	movsbl %al,%eax
 4ff:	83 ec 08             	sub    $0x8,%esp
 502:	50                   	push   %eax
 503:	ff 75 08             	pushl  0x8(%ebp)
 506:	e8 c7 fe ff ff       	call   3d2 <putc>
 50b:	83 c4 10             	add    $0x10,%esp
 50e:	e9 0d 01 00 00       	jmp    620 <printf+0x177>
      }
    } else if(state == '%'){
 513:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 517:	0f 85 03 01 00 00    	jne    620 <printf+0x177>
      if(c == 'd'){
 51d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 521:	75 1e                	jne    541 <printf+0x98>
        printint(fd, *ap, 10, 1);
 523:	8b 45 e8             	mov    -0x18(%ebp),%eax
 526:	8b 00                	mov    (%eax),%eax
 528:	6a 01                	push   $0x1
 52a:	6a 0a                	push   $0xa
 52c:	50                   	push   %eax
 52d:	ff 75 08             	pushl  0x8(%ebp)
 530:	e8 c0 fe ff ff       	call   3f5 <printint>
 535:	83 c4 10             	add    $0x10,%esp
        ap++;
 538:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53c:	e9 d8 00 00 00       	jmp    619 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 541:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 545:	74 06                	je     54d <printf+0xa4>
 547:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 54b:	75 1e                	jne    56b <printf+0xc2>
        printint(fd, *ap, 16, 0);
 54d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 550:	8b 00                	mov    (%eax),%eax
 552:	6a 00                	push   $0x0
 554:	6a 10                	push   $0x10
 556:	50                   	push   %eax
 557:	ff 75 08             	pushl  0x8(%ebp)
 55a:	e8 96 fe ff ff       	call   3f5 <printint>
 55f:	83 c4 10             	add    $0x10,%esp
        ap++;
 562:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 566:	e9 ae 00 00 00       	jmp    619 <printf+0x170>
      } else if(c == 's'){
 56b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 56f:	75 43                	jne    5b4 <printf+0x10b>
        s = (char*)*ap;
 571:	8b 45 e8             	mov    -0x18(%ebp),%eax
 574:	8b 00                	mov    (%eax),%eax
 576:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 579:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 57d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 581:	75 25                	jne    5a8 <printf+0xff>
          s = "(null)";
 583:	c7 45 f4 73 08 00 00 	movl   $0x873,-0xc(%ebp)
        while(*s != 0){
 58a:	eb 1c                	jmp    5a8 <printf+0xff>
          putc(fd, *s);
 58c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58f:	0f b6 00             	movzbl (%eax),%eax
 592:	0f be c0             	movsbl %al,%eax
 595:	83 ec 08             	sub    $0x8,%esp
 598:	50                   	push   %eax
 599:	ff 75 08             	pushl  0x8(%ebp)
 59c:	e8 31 fe ff ff       	call   3d2 <putc>
 5a1:	83 c4 10             	add    $0x10,%esp
          s++;
 5a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ab:	0f b6 00             	movzbl (%eax),%eax
 5ae:	84 c0                	test   %al,%al
 5b0:	75 da                	jne    58c <printf+0xe3>
 5b2:	eb 65                	jmp    619 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5b8:	75 1d                	jne    5d7 <printf+0x12e>
        putc(fd, *ap);
 5ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bd:	8b 00                	mov    (%eax),%eax
 5bf:	0f be c0             	movsbl %al,%eax
 5c2:	83 ec 08             	sub    $0x8,%esp
 5c5:	50                   	push   %eax
 5c6:	ff 75 08             	pushl  0x8(%ebp)
 5c9:	e8 04 fe ff ff       	call   3d2 <putc>
 5ce:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d5:	eb 42                	jmp    619 <printf+0x170>
      } else if(c == '%'){
 5d7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5db:	75 17                	jne    5f4 <printf+0x14b>
        putc(fd, c);
 5dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e0:	0f be c0             	movsbl %al,%eax
 5e3:	83 ec 08             	sub    $0x8,%esp
 5e6:	50                   	push   %eax
 5e7:	ff 75 08             	pushl  0x8(%ebp)
 5ea:	e8 e3 fd ff ff       	call   3d2 <putc>
 5ef:	83 c4 10             	add    $0x10,%esp
 5f2:	eb 25                	jmp    619 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f4:	83 ec 08             	sub    $0x8,%esp
 5f7:	6a 25                	push   $0x25
 5f9:	ff 75 08             	pushl  0x8(%ebp)
 5fc:	e8 d1 fd ff ff       	call   3d2 <putc>
 601:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 604:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 607:	0f be c0             	movsbl %al,%eax
 60a:	83 ec 08             	sub    $0x8,%esp
 60d:	50                   	push   %eax
 60e:	ff 75 08             	pushl  0x8(%ebp)
 611:	e8 bc fd ff ff       	call   3d2 <putc>
 616:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 619:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 620:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 624:	8b 55 0c             	mov    0xc(%ebp),%edx
 627:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62a:	01 d0                	add    %edx,%eax
 62c:	0f b6 00             	movzbl (%eax),%eax
 62f:	84 c0                	test   %al,%al
 631:	0f 85 94 fe ff ff    	jne    4cb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 637:	90                   	nop
 638:	c9                   	leave  
 639:	c3                   	ret    

0000063a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 63a:	55                   	push   %ebp
 63b:	89 e5                	mov    %esp,%ebp
 63d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 640:	8b 45 08             	mov    0x8(%ebp),%eax
 643:	83 e8 08             	sub    $0x8,%eax
 646:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 649:	a1 00 0b 00 00       	mov    0xb00,%eax
 64e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 651:	eb 24                	jmp    677 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	8b 00                	mov    (%eax),%eax
 658:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 65b:	77 12                	ja     66f <free+0x35>
 65d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 660:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 663:	77 24                	ja     689 <free+0x4f>
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 66d:	77 1a                	ja     689 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 00                	mov    (%eax),%eax
 674:	89 45 fc             	mov    %eax,-0x4(%ebp)
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	76 d4                	jbe    653 <free+0x19>
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 687:	76 ca                	jbe    653 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	8b 40 04             	mov    0x4(%eax),%eax
 68f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 696:	8b 45 f8             	mov    -0x8(%ebp),%eax
 699:	01 c2                	add    %eax,%edx
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	39 c2                	cmp    %eax,%edx
 6a2:	75 24                	jne    6c8 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a7:	8b 50 04             	mov    0x4(%eax),%edx
 6aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ad:	8b 00                	mov    (%eax),%eax
 6af:	8b 40 04             	mov    0x4(%eax),%eax
 6b2:	01 c2                	add    %eax,%edx
 6b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b7:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bd:	8b 00                	mov    (%eax),%eax
 6bf:	8b 10                	mov    (%eax),%edx
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	89 10                	mov    %edx,(%eax)
 6c6:	eb 0a                	jmp    6d2 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 10                	mov    (%eax),%edx
 6cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	8b 40 04             	mov    0x4(%eax),%eax
 6d8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	01 d0                	add    %edx,%eax
 6e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e7:	75 20                	jne    709 <free+0xcf>
    p->s.size += bp->s.size;
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	8b 50 04             	mov    0x4(%eax),%edx
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	8b 40 04             	mov    0x4(%eax),%eax
 6f5:	01 c2                	add    %eax,%edx
 6f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 700:	8b 10                	mov    (%eax),%edx
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	89 10                	mov    %edx,(%eax)
 707:	eb 08                	jmp    711 <free+0xd7>
  } else
    p->s.ptr = bp;
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70f:	89 10                	mov    %edx,(%eax)
  freep = p;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	a3 00 0b 00 00       	mov    %eax,0xb00
}
 719:	90                   	nop
 71a:	c9                   	leave  
 71b:	c3                   	ret    

0000071c <morecore>:

static Header*
morecore(uint nu)
{
 71c:	55                   	push   %ebp
 71d:	89 e5                	mov    %esp,%ebp
 71f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 722:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 729:	77 07                	ja     732 <morecore+0x16>
    nu = 4096;
 72b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 732:	8b 45 08             	mov    0x8(%ebp),%eax
 735:	c1 e0 03             	shl    $0x3,%eax
 738:	83 ec 0c             	sub    $0xc,%esp
 73b:	50                   	push   %eax
 73c:	e8 79 fc ff ff       	call   3ba <sbrk>
 741:	83 c4 10             	add    $0x10,%esp
 744:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 747:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 74b:	75 07                	jne    754 <morecore+0x38>
    return 0;
 74d:	b8 00 00 00 00       	mov    $0x0,%eax
 752:	eb 26                	jmp    77a <morecore+0x5e>
  hp = (Header*)p;
 754:	8b 45 f4             	mov    -0xc(%ebp),%eax
 757:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75d:	8b 55 08             	mov    0x8(%ebp),%edx
 760:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 763:	8b 45 f0             	mov    -0x10(%ebp),%eax
 766:	83 c0 08             	add    $0x8,%eax
 769:	83 ec 0c             	sub    $0xc,%esp
 76c:	50                   	push   %eax
 76d:	e8 c8 fe ff ff       	call   63a <free>
 772:	83 c4 10             	add    $0x10,%esp
  return freep;
 775:	a1 00 0b 00 00       	mov    0xb00,%eax
}
 77a:	c9                   	leave  
 77b:	c3                   	ret    

0000077c <malloc>:

void*
malloc(uint nbytes)
{
 77c:	55                   	push   %ebp
 77d:	89 e5                	mov    %esp,%ebp
 77f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 782:	8b 45 08             	mov    0x8(%ebp),%eax
 785:	83 c0 07             	add    $0x7,%eax
 788:	c1 e8 03             	shr    $0x3,%eax
 78b:	83 c0 01             	add    $0x1,%eax
 78e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 791:	a1 00 0b 00 00       	mov    0xb00,%eax
 796:	89 45 f0             	mov    %eax,-0x10(%ebp)
 799:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79d:	75 23                	jne    7c2 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 79f:	c7 45 f0 f8 0a 00 00 	movl   $0xaf8,-0x10(%ebp)
 7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a9:	a3 00 0b 00 00       	mov    %eax,0xb00
 7ae:	a1 00 0b 00 00       	mov    0xb00,%eax
 7b3:	a3 f8 0a 00 00       	mov    %eax,0xaf8
    base.s.size = 0;
 7b8:	c7 05 fc 0a 00 00 00 	movl   $0x0,0xafc
 7bf:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cd:	8b 40 04             	mov    0x4(%eax),%eax
 7d0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d3:	72 4d                	jb     822 <malloc+0xa6>
      if(p->s.size == nunits)
 7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d8:	8b 40 04             	mov    0x4(%eax),%eax
 7db:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7de:	75 0c                	jne    7ec <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 10                	mov    (%eax),%edx
 7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e8:	89 10                	mov    %edx,(%eax)
 7ea:	eb 26                	jmp    812 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	8b 40 04             	mov    0x4(%eax),%eax
 7f2:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f5:	89 c2                	mov    %eax,%edx
 7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fa:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	8b 40 04             	mov    0x4(%eax),%eax
 803:	c1 e0 03             	shl    $0x3,%eax
 806:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 80f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 812:	8b 45 f0             	mov    -0x10(%ebp),%eax
 815:	a3 00 0b 00 00       	mov    %eax,0xb00
      return (void*)(p + 1);
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	83 c0 08             	add    $0x8,%eax
 820:	eb 3b                	jmp    85d <malloc+0xe1>
    }
    if(p == freep)
 822:	a1 00 0b 00 00       	mov    0xb00,%eax
 827:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 82a:	75 1e                	jne    84a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 82c:	83 ec 0c             	sub    $0xc,%esp
 82f:	ff 75 ec             	pushl  -0x14(%ebp)
 832:	e8 e5 fe ff ff       	call   71c <morecore>
 837:	83 c4 10             	add    $0x10,%esp
 83a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 841:	75 07                	jne    84a <malloc+0xce>
        return 0;
 843:	b8 00 00 00 00       	mov    $0x0,%eax
 848:	eb 13                	jmp    85d <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 00                	mov    (%eax),%eax
 855:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 858:	e9 6d ff ff ff       	jmp    7ca <malloc+0x4e>
}
 85d:	c9                   	leave  
 85e:	c3                   	ret    
