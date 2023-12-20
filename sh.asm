
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      17:	90                   	nop
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f b7 01 00 00    	jg     1d8 <main+0x1d8>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 22 15 00 00       	push   $0x1522
      2b:	e8 e3 0f 00 00       	call   1013 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      3e:	66 90                	xchg   %ax,%ax
  printf(2, "$ ");
      40:	83 ec 08             	sub    $0x8,%esp
      43:	68 81 14 00 00       	push   $0x1481
      48:	6a 02                	push   $0x2
      4a:	e8 01 11 00 00       	call   1150 <printf>
  memset(buf, 0, nbuf);
      4f:	83 c4 0c             	add    $0xc,%esp
      52:	6a 64                	push   $0x64
      54:	6a 00                	push   $0x0
      56:	68 c0 1c 00 00       	push   $0x1cc0
      5b:	e8 e0 0d 00 00       	call   e40 <memset>
  gets(buf, nbuf);
      60:	58                   	pop    %eax
      61:	5a                   	pop    %edx
      62:	6a 64                	push   $0x64
      64:	68 c0 1c 00 00       	push   $0x1cc0
      69:	e8 32 0e 00 00       	call   ea0 <gets>
  if(buf[0] == 0) // EOF
      6e:	0f b6 0d c0 1c 00 00 	movzbl 0x1cc0,%ecx
      75:	83 c4 10             	add    $0x10,%esp
      78:	84 c9                	test   %cl,%cl
      7a:	0f 84 88 01 00 00    	je     208 <main+0x208>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0) {
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      80:	80 f9 63             	cmp    $0x63,%cl
      83:	0f 84 d7 00 00 00    	je     160 <main+0x160>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(buf[0] == 'h' && buf[1] == 'i' && buf[2] == 's' && buf[3] == 't'
      89:	80 f9 68             	cmp    $0x68,%cl
      8c:	75 4a                	jne    d8 <main+0xd8>
      8e:	80 3d c1 1c 00 00 69 	cmpb   $0x69,0x1cc1
      95:	75 41                	jne    d8 <main+0xd8>
      97:	80 3d c2 1c 00 00 73 	cmpb   $0x73,0x1cc2
      9e:	75 38                	jne    d8 <main+0xd8>
      a0:	80 3d c3 1c 00 00 74 	cmpb   $0x74,0x1cc3
      a7:	75 2f                	jne    d8 <main+0xd8>
        && buf[4] == 'o' && buf[5] == 'r' && buf[6] == 'y' && buf[7] == '\n') {
      a9:	80 3d c4 1c 00 00 6f 	cmpb   $0x6f,0x1cc4
      b0:	75 26                	jne    d8 <main+0xd8>
      b2:	80 3d c5 1c 00 00 72 	cmpb   $0x72,0x1cc5
      b9:	75 1d                	jne    d8 <main+0xd8>
      bb:	80 3d c6 1c 00 00 79 	cmpb   $0x79,0x1cc6
      c2:	75 14                	jne    d8 <main+0xd8>
      c4:	80 3d c7 1c 00 00 0a 	cmpb   $0xa,0x1cc7
      cb:	0f 84 18 01 00 00    	je     1e9 <main+0x1e9>
      d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (*a != *b) {
      d8:	3a 0d 0c 1c 00 00    	cmp    0x1c0c,%cl
      de:	75 40                	jne    120 <main+0x120>
      e0:	89 ca                	mov    %ecx,%edx
      e2:	b8 01 00 00 00       	mov    $0x1,%eax
      e7:	eb 19                	jmp    102 <main+0x102>
      e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      f0:	0f b6 90 c0 1c 00 00 	movzbl 0x1cc0(%eax),%edx
      f7:	83 c0 01             	add    $0x1,%eax
      fa:	3a 90 0b 1c 00 00    	cmp    0x1c0b(%eax),%dl
     100:	75 1e                	jne    120 <main+0x120>
    if (*a == '\n') return 1;
     102:	80 fa 0a             	cmp    $0xa,%dl
     105:	75 e9                	jne    f0 <main+0xf0>
      printHistory();
      continue;
    }
    if (streq(buf, trace_cmd)) {
      tracing = 1; // tracing is set to 1 when "trace" is written on shell
     107:	c7 05 a0 1c 00 00 01 	movl   $0x1,0x1ca0
     10e:	00 00 00 
      continue;
     111:	e9 2a ff ff ff       	jmp    40 <main+0x40>
     116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     11d:	8d 76 00             	lea    0x0(%esi),%esi
    if (*a != *b) {
     120:	3a 0d 00 1c 00 00    	cmp    0x1c00,%cl
     126:	0f 85 94 00 00 00    	jne    1c0 <main+0x1c0>
     12c:	b8 01 00 00 00       	mov    $0x1,%eax
     131:	eb 17                	jmp    14a <main+0x14a>
     133:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     137:	90                   	nop
     138:	0f b6 88 c0 1c 00 00 	movzbl 0x1cc0(%eax),%ecx
     13f:	83 c0 01             	add    $0x1,%eax
     142:	3a 88 ff 1b 00 00    	cmp    0x1bff(%eax),%cl
     148:	75 76                	jne    1c0 <main+0x1c0>
    if (*a == '\n') return 1;
     14a:	80 f9 0a             	cmp    $0xa,%cl
     14d:	75 e9                	jne    138 <main+0x138>
    }
    if (streq(buf, untrace_cmd)) {
      tracing = 0; // tracing is set to 0 when "untrace" is written on shell
     14f:	c7 05 a0 1c 00 00 00 	movl   $0x0,0x1ca0
     156:	00 00 00 
      continue;
     159:	e9 e2 fe ff ff       	jmp    40 <main+0x40>
     15e:	66 90                	xchg   %ax,%ax
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     160:	80 3d c1 1c 00 00 64 	cmpb   $0x64,0x1cc1
     167:	0f 85 6b ff ff ff    	jne    d8 <main+0xd8>
     16d:	80 3d c2 1c 00 00 20 	cmpb   $0x20,0x1cc2
     174:	0f 85 5e ff ff ff    	jne    d8 <main+0xd8>
      buf[strlen(buf)-1] = 0;  // chop \n
     17a:	83 ec 0c             	sub    $0xc,%esp
     17d:	68 c0 1c 00 00       	push   $0x1cc0
     182:	e8 89 0c 00 00       	call   e10 <strlen>
      if(chdir(buf+3) < 0)
     187:	c7 04 24 c3 1c 00 00 	movl   $0x1cc3,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
     18e:	c6 80 bf 1c 00 00 00 	movb   $0x0,0x1cbf(%eax)
      if(chdir(buf+3) < 0)
     195:	e8 a9 0e 00 00       	call   1043 <chdir>
     19a:	83 c4 10             	add    $0x10,%esp
     19d:	85 c0                	test   %eax,%eax
     19f:	0f 89 9b fe ff ff    	jns    40 <main+0x40>
        printf(2, "cannot cd %s\n", buf+3);
     1a5:	51                   	push   %ecx
     1a6:	68 c3 1c 00 00       	push   $0x1cc3
     1ab:	68 2a 15 00 00       	push   $0x152a
     1b0:	6a 02                	push   $0x2
     1b2:	e8 99 0f 00 00       	call   1150 <printf>
     1b7:	83 c4 10             	add    $0x10,%esp
     1ba:	e9 81 fe ff ff       	jmp    40 <main+0x40>
     1bf:	90                   	nop
int
fork1(void)
{
  int pid;

  pid = fork();
     1c0:	e8 06 0e 00 00       	call   fcb <fork>
  if(pid == -1)
     1c5:	83 f8 ff             	cmp    $0xffffffff,%eax
     1c8:	74 43                	je     20d <main+0x20d>
    if(fork1() == 0) {
     1ca:	85 c0                	test   %eax,%eax
     1cc:	74 25                	je     1f3 <main+0x1f3>
    wait();
     1ce:	e8 08 0e 00 00       	call   fdb <wait>
     1d3:	e9 68 fe ff ff       	jmp    40 <main+0x40>
      close(fd);
     1d8:	83 ec 0c             	sub    $0xc,%esp
     1db:	50                   	push   %eax
     1dc:	e8 1a 0e 00 00       	call   ffb <close>
      break;
     1e1:	83 c4 10             	add    $0x10,%esp
     1e4:	e9 57 fe ff ff       	jmp    40 <main+0x40>
      printHistory();
     1e9:	e8 72 00 00 00       	call   260 <printHistory>
      continue;
     1ee:	e9 4d fe ff ff       	jmp    40 <main+0x40>
      runcmd(parsecmd(buf));
     1f3:	83 ec 0c             	sub    $0xc,%esp
     1f6:	68 c0 1c 00 00       	push   $0x1cc0
     1fb:	e8 10 0b 00 00       	call   d10 <parsecmd>
     200:	89 04 24             	mov    %eax,(%esp)
     203:	e8 48 01 00 00       	call   350 <runcmd>
  exit();
     208:	e8 c6 0d 00 00       	call   fd3 <exit>
    panic("fork");
     20d:	83 ec 0c             	sub    $0xc,%esp
     210:	68 84 14 00 00       	push   $0x1484
     215:	e8 f6 00 00 00       	call   310 <panic>
     21a:	66 90                	xchg   %ax,%ax
     21c:	66 90                	xchg   %ax,%ax
     21e:	66 90                	xchg   %ax,%ax

00000220 <streq>:
int streq(char *a, char *b) {
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	8b 4d 08             	mov    0x8(%ebp),%ecx
     226:	8b 55 0c             	mov    0xc(%ebp),%edx
    if (*a != *b) {
     229:	0f b6 01             	movzbl (%ecx),%eax
     22c:	3a 02                	cmp    (%edx),%al
     22e:	74 15                	je     245 <streq+0x25>
     230:	eb 1e                	jmp    250 <streq+0x30>
     232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    b++;
     238:	83 c2 01             	add    $0x1,%edx
    a++;
     23b:	83 c1 01             	add    $0x1,%ecx
    if (*a != *b) {
     23e:	0f b6 01             	movzbl (%ecx),%eax
     241:	3a 02                	cmp    (%edx),%al
     243:	75 0b                	jne    250 <streq+0x30>
    if (*a == '\n') return 1;
     245:	3c 0a                	cmp    $0xa,%al
     247:	75 ef                	jne    238 <streq+0x18>
     249:	b8 01 00 00 00       	mov    $0x1,%eax
}
     24e:	5d                   	pop    %ebp
     24f:	c3                   	ret    
      return 0;
     250:	31 c0                	xor    %eax,%eax
}
     252:	5d                   	pop    %ebp
     253:	c3                   	ret    
     254:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     25b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     25f:	90                   	nop

00000260 <printHistory>:
void printHistory() {
     260:	55                   	push   %ebp
     261:	89 e5                	mov    %esp,%ebp
     263:	56                   	push   %esi
  int i, count = 0;
     264:	31 f6                	xor    %esi,%esi
void printHistory() {
     266:	53                   	push   %ebx
     267:	bb 0f 00 00 00       	mov    $0xf,%ebx
     26c:	eb 1c                	jmp    28a <printHistory+0x2a>
     26e:	66 90                	xchg   %ax,%ax
        printf(1, " %d: %s\n", count, cmdFromHistory);
     270:	68 20 1c 00 00       	push   $0x1c20
     275:	56                   	push   %esi
     276:	68 78 14 00 00       	push   $0x1478
     27b:	6a 01                	push   $0x1
     27d:	e8 ce 0e 00 00       	call   1150 <printf>
     282:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < MAX_HISTORY; i++) {
     285:	83 eb 01             	sub    $0x1,%ebx
     288:	72 37                	jb     2c1 <printHistory+0x61>
    if (history(cmdFromHistory, MAX_HISTORY - i - 1) == 0) { // this is the sys call
     28a:	83 ec 08             	sub    $0x8,%esp
     28d:	53                   	push   %ebx
     28e:	68 20 1c 00 00       	push   $0x1c20
     293:	e8 eb 0d 00 00       	call   1083 <history>
     298:	83 c4 10             	add    $0x10,%esp
     29b:	85 c0                	test   %eax,%eax
     29d:	75 e6                	jne    285 <printHistory+0x25>
      count++;
     29f:	83 c6 01             	add    $0x1,%esi
      if (count < 10)
     2a2:	83 fe 09             	cmp    $0x9,%esi
     2a5:	7e c9                	jle    270 <printHistory+0x10>
        printf(1, "%d: %s\n", count, cmdFromHistory);
     2a7:	68 20 1c 00 00       	push   $0x1c20
     2ac:	56                   	push   %esi
     2ad:	68 79 14 00 00       	push   $0x1479
     2b2:	6a 01                	push   $0x1
     2b4:	e8 97 0e 00 00       	call   1150 <printf>
     2b9:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < MAX_HISTORY; i++) {
     2bc:	83 eb 01             	sub    $0x1,%ebx
     2bf:	73 c9                	jae    28a <printHistory+0x2a>
}
     2c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
     2c4:	5b                   	pop    %ebx
     2c5:	5e                   	pop    %esi
     2c6:	5d                   	pop    %ebp
     2c7:	c3                   	ret    
     2c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2cf:	90                   	nop

000002d0 <getcmd>:
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	56                   	push   %esi
     2d4:	53                   	push   %ebx
     2d5:	8b 75 0c             	mov    0xc(%ebp),%esi
     2d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     2db:	83 ec 08             	sub    $0x8,%esp
     2de:	68 81 14 00 00       	push   $0x1481
     2e3:	6a 02                	push   $0x2
     2e5:	e8 66 0e 00 00       	call   1150 <printf>
  memset(buf, 0, nbuf);
     2ea:	83 c4 0c             	add    $0xc,%esp
     2ed:	56                   	push   %esi
     2ee:	6a 00                	push   $0x0
     2f0:	53                   	push   %ebx
     2f1:	e8 4a 0b 00 00       	call   e40 <memset>
  gets(buf, nbuf);
     2f6:	58                   	pop    %eax
     2f7:	5a                   	pop    %edx
     2f8:	56                   	push   %esi
     2f9:	53                   	push   %ebx
     2fa:	e8 a1 0b 00 00       	call   ea0 <gets>
  if(buf[0] == 0) // EOF
     2ff:	83 c4 10             	add    $0x10,%esp
     302:	80 3b 01             	cmpb   $0x1,(%ebx)
     305:	19 c0                	sbb    %eax,%eax
}
     307:	8d 65 f8             	lea    -0x8(%ebp),%esp
     30a:	5b                   	pop    %ebx
     30b:	5e                   	pop    %esi
     30c:	5d                   	pop    %ebp
     30d:	c3                   	ret    
     30e:	66 90                	xchg   %ax,%ax

00000310 <panic>:
{
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     316:	ff 75 08             	push   0x8(%ebp)
     319:	68 7d 14 00 00       	push   $0x147d
     31e:	6a 02                	push   $0x2
     320:	e8 2b 0e 00 00       	call   1150 <printf>
  exit();
     325:	e8 a9 0c 00 00       	call   fd3 <exit>
     32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000330 <fork1>:
{
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     336:	e8 90 0c 00 00       	call   fcb <fork>
  if(pid == -1)
     33b:	83 f8 ff             	cmp    $0xffffffff,%eax
     33e:	74 02                	je     342 <fork1+0x12>
  return pid;
}
     340:	c9                   	leave  
     341:	c3                   	ret    
    panic("fork");
     342:	83 ec 0c             	sub    $0xc,%esp
     345:	68 84 14 00 00       	push   $0x1484
     34a:	e8 c1 ff ff ff       	call   310 <panic>
     34f:	90                   	nop

00000350 <runcmd>:
{
     350:	55                   	push   %ebp
     351:	89 e5                	mov    %esp,%ebp
     353:	53                   	push   %ebx
     354:	83 ec 14             	sub    $0x14,%esp
     357:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     35a:	85 db                	test   %ebx,%ebx
     35c:	74 48                	je     3a6 <runcmd+0x56>
  switch(cmd->type){
     35e:	83 3b 05             	cmpl   $0x5,(%ebx)
     361:	0f 87 e9 00 00 00    	ja     450 <runcmd+0x100>
     367:	8b 03                	mov    (%ebx),%eax
     369:	ff 24 85 38 15 00 00 	jmp    *0x1538(,%eax,4)
    if(ecmd->argv[0] == 0)
     370:	83 7b 04 00          	cmpl   $0x0,0x4(%ebx)
     374:	74 30                	je     3a6 <runcmd+0x56>
    if (tracing) trace(SYSCALL_TRACE | SYSCALL_ONFORK); // set tracing on
     376:	83 3d a0 1c 00 00 00 	cmpl   $0x0,0x1ca0
     37d:	0f 85 fc 00 00 00    	jne    47f <runcmd+0x12f>
    exec(ecmd->argv[0], ecmd->argv);
     383:	8d 43 04             	lea    0x4(%ebx),%eax
     386:	51                   	push   %ecx
     387:	51                   	push   %ecx
     388:	50                   	push   %eax
     389:	ff 73 04             	push   0x4(%ebx)
     38c:	e8 7a 0c 00 00       	call   100b <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     391:	83 c4 0c             	add    $0xc,%esp
     394:	ff 73 04             	push   0x4(%ebx)
     397:	68 90 14 00 00       	push   $0x1490
     39c:	6a 02                	push   $0x2
     39e:	e8 ad 0d 00 00       	call   1150 <printf>
    break;
     3a3:	83 c4 10             	add    $0x10,%esp
    exit();
     3a6:	e8 28 0c 00 00       	call   fd3 <exit>
    if(fork1() == 0)
     3ab:	e8 80 ff ff ff       	call   330 <fork1>
     3b0:	85 c0                	test   %eax,%eax
     3b2:	75 f2                	jne    3a6 <runcmd+0x56>
     3b4:	e9 8c 00 00 00       	jmp    445 <runcmd+0xf5>
    if(pipe(p) < 0)
     3b9:	83 ec 0c             	sub    $0xc,%esp
     3bc:	8d 45 f0             	lea    -0x10(%ebp),%eax
     3bf:	50                   	push   %eax
     3c0:	e8 1e 0c 00 00       	call   fe3 <pipe>
     3c5:	83 c4 10             	add    $0x10,%esp
     3c8:	85 c0                	test   %eax,%eax
     3ca:	0f 88 a2 00 00 00    	js     472 <runcmd+0x122>
    if(fork1() == 0){
     3d0:	e8 5b ff ff ff       	call   330 <fork1>
     3d5:	85 c0                	test   %eax,%eax
     3d7:	0f 84 e2 00 00 00    	je     4bf <runcmd+0x16f>
    if(fork1() == 0){
     3dd:	e8 4e ff ff ff       	call   330 <fork1>
     3e2:	85 c0                	test   %eax,%eax
     3e4:	0f 84 a7 00 00 00    	je     491 <runcmd+0x141>
    close(p[0]);
     3ea:	83 ec 0c             	sub    $0xc,%esp
     3ed:	ff 75 f0             	push   -0x10(%ebp)
     3f0:	e8 06 0c 00 00       	call   ffb <close>
    close(p[1]);
     3f5:	58                   	pop    %eax
     3f6:	ff 75 f4             	push   -0xc(%ebp)
     3f9:	e8 fd 0b 00 00       	call   ffb <close>
    wait();
     3fe:	e8 d8 0b 00 00       	call   fdb <wait>
    wait();
     403:	e8 d3 0b 00 00       	call   fdb <wait>
    break;
     408:	83 c4 10             	add    $0x10,%esp
     40b:	eb 99                	jmp    3a6 <runcmd+0x56>
    if(fork1() == 0)
     40d:	e8 1e ff ff ff       	call   330 <fork1>
     412:	85 c0                	test   %eax,%eax
     414:	74 2f                	je     445 <runcmd+0xf5>
    wait();
     416:	e8 c0 0b 00 00       	call   fdb <wait>
    runcmd(lcmd->right);
     41b:	83 ec 0c             	sub    $0xc,%esp
     41e:	ff 73 08             	push   0x8(%ebx)
     421:	e8 2a ff ff ff       	call   350 <runcmd>
    close(rcmd->fd);
     426:	83 ec 0c             	sub    $0xc,%esp
     429:	ff 73 14             	push   0x14(%ebx)
     42c:	e8 ca 0b 00 00       	call   ffb <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     431:	58                   	pop    %eax
     432:	5a                   	pop    %edx
     433:	ff 73 10             	push   0x10(%ebx)
     436:	ff 73 08             	push   0x8(%ebx)
     439:	e8 d5 0b 00 00       	call   1013 <open>
     43e:	83 c4 10             	add    $0x10,%esp
     441:	85 c0                	test   %eax,%eax
     443:	78 18                	js     45d <runcmd+0x10d>
      runcmd(bcmd->cmd);
     445:	83 ec 0c             	sub    $0xc,%esp
     448:	ff 73 04             	push   0x4(%ebx)
     44b:	e8 00 ff ff ff       	call   350 <runcmd>
    panic("runcmd");
     450:	83 ec 0c             	sub    $0xc,%esp
     453:	68 89 14 00 00       	push   $0x1489
     458:	e8 b3 fe ff ff       	call   310 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     45d:	51                   	push   %ecx
     45e:	ff 73 08             	push   0x8(%ebx)
     461:	68 a0 14 00 00       	push   $0x14a0
     466:	6a 02                	push   $0x2
     468:	e8 e3 0c 00 00       	call   1150 <printf>
      exit();
     46d:	e8 61 0b 00 00       	call   fd3 <exit>
      panic("pipe");
     472:	83 ec 0c             	sub    $0xc,%esp
     475:	68 b0 14 00 00       	push   $0x14b0
     47a:	e8 91 fe ff ff       	call   310 <panic>
    if (tracing) trace(SYSCALL_TRACE | SYSCALL_ONFORK); // set tracing on
     47f:	83 ec 0c             	sub    $0xc,%esp
     482:	6a 03                	push   $0x3
     484:	e8 ea 0b 00 00       	call   1073 <trace>
     489:	83 c4 10             	add    $0x10,%esp
     48c:	e9 f2 fe ff ff       	jmp    383 <runcmd+0x33>
      close(0);
     491:	83 ec 0c             	sub    $0xc,%esp
     494:	6a 00                	push   $0x0
     496:	e8 60 0b 00 00       	call   ffb <close>
      dup(p[0]);
     49b:	5a                   	pop    %edx
     49c:	ff 75 f0             	push   -0x10(%ebp)
     49f:	e8 a7 0b 00 00       	call   104b <dup>
      close(p[0]);
     4a4:	59                   	pop    %ecx
     4a5:	ff 75 f0             	push   -0x10(%ebp)
     4a8:	e8 4e 0b 00 00       	call   ffb <close>
      close(p[1]);
     4ad:	58                   	pop    %eax
     4ae:	ff 75 f4             	push   -0xc(%ebp)
     4b1:	e8 45 0b 00 00       	call   ffb <close>
      runcmd(pcmd->right);
     4b6:	58                   	pop    %eax
     4b7:	ff 73 08             	push   0x8(%ebx)
     4ba:	e8 91 fe ff ff       	call   350 <runcmd>
      close(1);
     4bf:	83 ec 0c             	sub    $0xc,%esp
     4c2:	6a 01                	push   $0x1
     4c4:	e8 32 0b 00 00       	call   ffb <close>
      dup(p[1]);
     4c9:	58                   	pop    %eax
     4ca:	ff 75 f4             	push   -0xc(%ebp)
     4cd:	e8 79 0b 00 00       	call   104b <dup>
      close(p[0]);
     4d2:	58                   	pop    %eax
     4d3:	ff 75 f0             	push   -0x10(%ebp)
     4d6:	e8 20 0b 00 00       	call   ffb <close>
      close(p[1]);
     4db:	58                   	pop    %eax
     4dc:	ff 75 f4             	push   -0xc(%ebp)
     4df:	e8 17 0b 00 00       	call   ffb <close>
      runcmd(pcmd->left);
     4e4:	5a                   	pop    %edx
     4e5:	ff 73 04             	push   0x4(%ebx)
     4e8:	e8 63 fe ff ff       	call   350 <runcmd>
     4ed:	8d 76 00             	lea    0x0(%esi),%esi

000004f0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	53                   	push   %ebx
     4f4:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4f7:	6a 54                	push   $0x54
     4f9:	e8 82 0e 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4fe:	83 c4 0c             	add    $0xc,%esp
     501:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     503:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     505:	6a 00                	push   $0x0
     507:	50                   	push   %eax
     508:	e8 33 09 00 00       	call   e40 <memset>
  cmd->type = EXEC;
     50d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     513:	89 d8                	mov    %ebx,%eax
     515:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     518:	c9                   	leave  
     519:	c3                   	ret    
     51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000520 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	53                   	push   %ebx
     524:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     527:	6a 18                	push   $0x18
     529:	e8 52 0e 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     52e:	83 c4 0c             	add    $0xc,%esp
     531:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     533:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     535:	6a 00                	push   $0x0
     537:	50                   	push   %eax
     538:	e8 03 09 00 00       	call   e40 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     53d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     540:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     546:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     549:	8b 45 0c             	mov    0xc(%ebp),%eax
     54c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     54f:	8b 45 10             	mov    0x10(%ebp),%eax
     552:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     555:	8b 45 14             	mov    0x14(%ebp),%eax
     558:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     55b:	8b 45 18             	mov    0x18(%ebp),%eax
     55e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     561:	89 d8                	mov    %ebx,%eax
     563:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     566:	c9                   	leave  
     567:	c3                   	ret    
     568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     56f:	90                   	nop

00000570 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     570:	55                   	push   %ebp
     571:	89 e5                	mov    %esp,%ebp
     573:	53                   	push   %ebx
     574:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     577:	6a 0c                	push   $0xc
     579:	e8 02 0e 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     57e:	83 c4 0c             	add    $0xc,%esp
     581:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     583:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     585:	6a 00                	push   $0x0
     587:	50                   	push   %eax
     588:	e8 b3 08 00 00       	call   e40 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     58d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     590:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     596:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     599:	8b 45 0c             	mov    0xc(%ebp),%eax
     59c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     59f:	89 d8                	mov    %ebx,%eax
     5a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5a4:	c9                   	leave  
     5a5:	c3                   	ret    
     5a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5ad:	8d 76 00             	lea    0x0(%esi),%esi

000005b0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
     5b3:	53                   	push   %ebx
     5b4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5b7:	6a 0c                	push   $0xc
     5b9:	e8 c2 0d 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     5be:	83 c4 0c             	add    $0xc,%esp
     5c1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     5c3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     5c5:	6a 00                	push   $0x0
     5c7:	50                   	push   %eax
     5c8:	e8 73 08 00 00       	call   e40 <memset>
  cmd->type = LIST;
  cmd->left = left;
     5cd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     5d0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     5d6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     5d9:	8b 45 0c             	mov    0xc(%ebp),%eax
     5dc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     5df:	89 d8                	mov    %ebx,%eax
     5e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5e4:	c9                   	leave  
     5e5:	c3                   	ret    
     5e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5ed:	8d 76 00             	lea    0x0(%esi),%esi

000005f0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	53                   	push   %ebx
     5f4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5f7:	6a 08                	push   $0x8
     5f9:	e8 82 0d 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     5fe:	83 c4 0c             	add    $0xc,%esp
     601:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     603:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     605:	6a 00                	push   $0x0
     607:	50                   	push   %eax
     608:	e8 33 08 00 00       	call   e40 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     60d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     610:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     616:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     619:	89 d8                	mov    %ebx,%eax
     61b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     61e:	c9                   	leave  
     61f:	c3                   	ret    

00000620 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	57                   	push   %edi
     624:	56                   	push   %esi
     625:	53                   	push   %ebx
     626:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     629:	8b 45 08             	mov    0x8(%ebp),%eax
{
     62c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     62f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     632:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     634:	39 df                	cmp    %ebx,%edi
     636:	72 0f                	jb     647 <gettoken+0x27>
     638:	eb 25                	jmp    65f <gettoken+0x3f>
     63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     640:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     643:	39 fb                	cmp    %edi,%ebx
     645:	74 18                	je     65f <gettoken+0x3f>
     647:	0f be 07             	movsbl (%edi),%eax
     64a:	83 ec 08             	sub    $0x8,%esp
     64d:	50                   	push   %eax
     64e:	68 f8 1b 00 00       	push   $0x1bf8
     653:	e8 08 08 00 00       	call   e60 <strchr>
     658:	83 c4 10             	add    $0x10,%esp
     65b:	85 c0                	test   %eax,%eax
     65d:	75 e1                	jne    640 <gettoken+0x20>
  if(q)
     65f:	85 f6                	test   %esi,%esi
     661:	74 02                	je     665 <gettoken+0x45>
    *q = s;
     663:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     665:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     668:	3c 3c                	cmp    $0x3c,%al
     66a:	0f 8f d0 00 00 00    	jg     740 <gettoken+0x120>
     670:	3c 3a                	cmp    $0x3a,%al
     672:	0f 8f b4 00 00 00    	jg     72c <gettoken+0x10c>
     678:	84 c0                	test   %al,%al
     67a:	75 44                	jne    6c0 <gettoken+0xa0>
     67c:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     67e:	8b 55 14             	mov    0x14(%ebp),%edx
     681:	85 d2                	test   %edx,%edx
     683:	74 05                	je     68a <gettoken+0x6a>
    *eq = s;
     685:	8b 45 14             	mov    0x14(%ebp),%eax
     688:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     68a:	39 df                	cmp    %ebx,%edi
     68c:	72 09                	jb     697 <gettoken+0x77>
     68e:	eb 1f                	jmp    6af <gettoken+0x8f>
    s++;
     690:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     693:	39 fb                	cmp    %edi,%ebx
     695:	74 18                	je     6af <gettoken+0x8f>
     697:	0f be 07             	movsbl (%edi),%eax
     69a:	83 ec 08             	sub    $0x8,%esp
     69d:	50                   	push   %eax
     69e:	68 f8 1b 00 00       	push   $0x1bf8
     6a3:	e8 b8 07 00 00       	call   e60 <strchr>
     6a8:	83 c4 10             	add    $0x10,%esp
     6ab:	85 c0                	test   %eax,%eax
     6ad:	75 e1                	jne    690 <gettoken+0x70>
  *ps = s;
     6af:	8b 45 08             	mov    0x8(%ebp),%eax
     6b2:	89 38                	mov    %edi,(%eax)
  return ret;
}
     6b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6b7:	89 f0                	mov    %esi,%eax
     6b9:	5b                   	pop    %ebx
     6ba:	5e                   	pop    %esi
     6bb:	5f                   	pop    %edi
     6bc:	5d                   	pop    %ebp
     6bd:	c3                   	ret    
     6be:	66 90                	xchg   %ax,%ax
  switch(*s){
     6c0:	79 5e                	jns    720 <gettoken+0x100>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     6c2:	39 fb                	cmp    %edi,%ebx
     6c4:	77 34                	ja     6fa <gettoken+0xda>
  if(eq)
     6c6:	8b 45 14             	mov    0x14(%ebp),%eax
     6c9:	be 61 00 00 00       	mov    $0x61,%esi
     6ce:	85 c0                	test   %eax,%eax
     6d0:	75 b3                	jne    685 <gettoken+0x65>
     6d2:	eb db                	jmp    6af <gettoken+0x8f>
     6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     6d8:	0f be 07             	movsbl (%edi),%eax
     6db:	83 ec 08             	sub    $0x8,%esp
     6de:	50                   	push   %eax
     6df:	68 f0 1b 00 00       	push   $0x1bf0
     6e4:	e8 77 07 00 00       	call   e60 <strchr>
     6e9:	83 c4 10             	add    $0x10,%esp
     6ec:	85 c0                	test   %eax,%eax
     6ee:	75 22                	jne    712 <gettoken+0xf2>
      s++;
     6f0:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     6f3:	39 fb                	cmp    %edi,%ebx
     6f5:	74 cf                	je     6c6 <gettoken+0xa6>
     6f7:	0f b6 07             	movzbl (%edi),%eax
     6fa:	83 ec 08             	sub    $0x8,%esp
     6fd:	0f be f0             	movsbl %al,%esi
     700:	56                   	push   %esi
     701:	68 f8 1b 00 00       	push   $0x1bf8
     706:	e8 55 07 00 00       	call   e60 <strchr>
     70b:	83 c4 10             	add    $0x10,%esp
     70e:	85 c0                	test   %eax,%eax
     710:	74 c6                	je     6d8 <gettoken+0xb8>
    ret = 'a';
     712:	be 61 00 00 00       	mov    $0x61,%esi
     717:	e9 62 ff ff ff       	jmp    67e <gettoken+0x5e>
     71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     720:	3c 26                	cmp    $0x26,%al
     722:	74 08                	je     72c <gettoken+0x10c>
     724:	8d 48 d8             	lea    -0x28(%eax),%ecx
     727:	80 f9 01             	cmp    $0x1,%cl
     72a:	77 96                	ja     6c2 <gettoken+0xa2>
  ret = *s;
     72c:	0f be f0             	movsbl %al,%esi
    s++;
     72f:	83 c7 01             	add    $0x1,%edi
    break;
     732:	e9 47 ff ff ff       	jmp    67e <gettoken+0x5e>
     737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     73e:	66 90                	xchg   %ax,%ax
  switch(*s){
     740:	3c 3e                	cmp    $0x3e,%al
     742:	75 1c                	jne    760 <gettoken+0x140>
    if(*s == '>'){
     744:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
    s++;
     748:	8d 47 01             	lea    0x1(%edi),%eax
    if(*s == '>'){
     74b:	74 1c                	je     769 <gettoken+0x149>
    s++;
     74d:	89 c7                	mov    %eax,%edi
     74f:	be 3e 00 00 00       	mov    $0x3e,%esi
     754:	e9 25 ff ff ff       	jmp    67e <gettoken+0x5e>
     759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     760:	3c 7c                	cmp    $0x7c,%al
     762:	74 c8                	je     72c <gettoken+0x10c>
     764:	e9 59 ff ff ff       	jmp    6c2 <gettoken+0xa2>
      s++;
     769:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     76c:	be 2b 00 00 00       	mov    $0x2b,%esi
     771:	e9 08 ff ff ff       	jmp    67e <gettoken+0x5e>
     776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     77d:	8d 76 00             	lea    0x0(%esi),%esi

00000780 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     780:	55                   	push   %ebp
     781:	89 e5                	mov    %esp,%ebp
     783:	57                   	push   %edi
     784:	56                   	push   %esi
     785:	53                   	push   %ebx
     786:	83 ec 0c             	sub    $0xc,%esp
     789:	8b 7d 08             	mov    0x8(%ebp),%edi
     78c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     78f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     791:	39 f3                	cmp    %esi,%ebx
     793:	72 12                	jb     7a7 <peek+0x27>
     795:	eb 28                	jmp    7bf <peek+0x3f>
     797:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     79e:	66 90                	xchg   %ax,%ax
    s++;
     7a0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     7a3:	39 de                	cmp    %ebx,%esi
     7a5:	74 18                	je     7bf <peek+0x3f>
     7a7:	0f be 03             	movsbl (%ebx),%eax
     7aa:	83 ec 08             	sub    $0x8,%esp
     7ad:	50                   	push   %eax
     7ae:	68 f8 1b 00 00       	push   $0x1bf8
     7b3:	e8 a8 06 00 00       	call   e60 <strchr>
     7b8:	83 c4 10             	add    $0x10,%esp
     7bb:	85 c0                	test   %eax,%eax
     7bd:	75 e1                	jne    7a0 <peek+0x20>
  *ps = s;
     7bf:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     7c1:	0f be 03             	movsbl (%ebx),%eax
     7c4:	31 d2                	xor    %edx,%edx
     7c6:	84 c0                	test   %al,%al
     7c8:	75 0e                	jne    7d8 <peek+0x58>
}
     7ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7cd:	89 d0                	mov    %edx,%eax
     7cf:	5b                   	pop    %ebx
     7d0:	5e                   	pop    %esi
     7d1:	5f                   	pop    %edi
     7d2:	5d                   	pop    %ebp
     7d3:	c3                   	ret    
     7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     7d8:	83 ec 08             	sub    $0x8,%esp
     7db:	50                   	push   %eax
     7dc:	ff 75 10             	push   0x10(%ebp)
     7df:	e8 7c 06 00 00       	call   e60 <strchr>
     7e4:	83 c4 10             	add    $0x10,%esp
     7e7:	31 d2                	xor    %edx,%edx
     7e9:	85 c0                	test   %eax,%eax
     7eb:	0f 95 c2             	setne  %dl
}
     7ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7f1:	5b                   	pop    %ebx
     7f2:	89 d0                	mov    %edx,%eax
     7f4:	5e                   	pop    %esi
     7f5:	5f                   	pop    %edi
     7f6:	5d                   	pop    %ebp
     7f7:	c3                   	ret    
     7f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7ff:	90                   	nop

00000800 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 2c             	sub    $0x2c,%esp
     809:	8b 75 0c             	mov    0xc(%ebp),%esi
     80c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     80f:	90                   	nop
     810:	83 ec 04             	sub    $0x4,%esp
     813:	68 d2 14 00 00       	push   $0x14d2
     818:	53                   	push   %ebx
     819:	56                   	push   %esi
     81a:	e8 61 ff ff ff       	call   780 <peek>
     81f:	83 c4 10             	add    $0x10,%esp
     822:	85 c0                	test   %eax,%eax
     824:	0f 84 f6 00 00 00    	je     920 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     82a:	6a 00                	push   $0x0
     82c:	6a 00                	push   $0x0
     82e:	53                   	push   %ebx
     82f:	56                   	push   %esi
     830:	e8 eb fd ff ff       	call   620 <gettoken>
     835:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     837:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     83a:	50                   	push   %eax
     83b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     83e:	50                   	push   %eax
     83f:	53                   	push   %ebx
     840:	56                   	push   %esi
     841:	e8 da fd ff ff       	call   620 <gettoken>
     846:	83 c4 20             	add    $0x20,%esp
     849:	83 f8 61             	cmp    $0x61,%eax
     84c:	0f 85 d9 00 00 00    	jne    92b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     852:	83 ff 3c             	cmp    $0x3c,%edi
     855:	74 69                	je     8c0 <parseredirs+0xc0>
     857:	83 ff 3e             	cmp    $0x3e,%edi
     85a:	74 05                	je     861 <parseredirs+0x61>
     85c:	83 ff 2b             	cmp    $0x2b,%edi
     85f:	75 af                	jne    810 <parseredirs+0x10>
  cmd = malloc(sizeof(*cmd));
     861:	83 ec 0c             	sub    $0xc,%esp
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     864:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     867:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     86a:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     86c:	89 55 d0             	mov    %edx,-0x30(%ebp)
     86f:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     872:	e8 09 0b 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     877:	83 c4 0c             	add    $0xc,%esp
     87a:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     87c:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     87e:	6a 00                	push   $0x0
     880:	50                   	push   %eax
     881:	e8 ba 05 00 00       	call   e40 <memset>
  cmd->type = REDIR;
     886:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     88c:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     88f:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     892:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     895:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     898:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     89b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     89e:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     8a5:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     8a8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     8af:	89 7d 08             	mov    %edi,0x8(%ebp)
     8b2:	e9 59 ff ff ff       	jmp    810 <parseredirs+0x10>
     8b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8be:	66 90                	xchg   %ax,%ax
  cmd = malloc(sizeof(*cmd));
     8c0:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     8c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     8c6:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     8c9:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     8cb:	89 55 d0             	mov    %edx,-0x30(%ebp)
     8ce:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     8d1:	e8 aa 0a 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     8d6:	83 c4 0c             	add    $0xc,%esp
     8d9:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     8db:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     8dd:	6a 00                	push   $0x0
     8df:	50                   	push   %eax
     8e0:	e8 5b 05 00 00       	call   e40 <memset>
  cmd->cmd = subcmd;
     8e5:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     8e8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     8eb:	89 7d 08             	mov    %edi,0x8(%ebp)
  cmd->efile = efile;
     8ee:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     8f1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
      break;
     8f7:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     8fa:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     8fd:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     900:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     903:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     90a:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     911:	e9 fa fe ff ff       	jmp    810 <parseredirs+0x10>
     916:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     91d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
     920:	8b 45 08             	mov    0x8(%ebp),%eax
     923:	8d 65 f4             	lea    -0xc(%ebp),%esp
     926:	5b                   	pop    %ebx
     927:	5e                   	pop    %esi
     928:	5f                   	pop    %edi
     929:	5d                   	pop    %ebp
     92a:	c3                   	ret    
      panic("missing file for redirection");
     92b:	83 ec 0c             	sub    $0xc,%esp
     92e:	68 b5 14 00 00       	push   $0x14b5
     933:	e8 d8 f9 ff ff       	call   310 <panic>
     938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     93f:	90                   	nop

00000940 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	57                   	push   %edi
     944:	56                   	push   %esi
     945:	53                   	push   %ebx
     946:	83 ec 30             	sub    $0x30,%esp
     949:	8b 75 08             	mov    0x8(%ebp),%esi
     94c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     94f:	68 d5 14 00 00       	push   $0x14d5
     954:	57                   	push   %edi
     955:	56                   	push   %esi
     956:	e8 25 fe ff ff       	call   780 <peek>
     95b:	83 c4 10             	add    $0x10,%esp
     95e:	85 c0                	test   %eax,%eax
     960:	0f 85 aa 00 00 00    	jne    a10 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     966:	83 ec 0c             	sub    $0xc,%esp
     969:	89 c3                	mov    %eax,%ebx
     96b:	6a 54                	push   $0x54
     96d:	e8 0e 0a 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     972:	83 c4 0c             	add    $0xc,%esp
     975:	6a 54                	push   $0x54
     977:	6a 00                	push   $0x0
     979:	50                   	push   %eax
     97a:	89 45 d0             	mov    %eax,-0x30(%ebp)
     97d:	e8 be 04 00 00       	call   e40 <memset>
  cmd->type = EXEC;
     982:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     985:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     988:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     98e:	57                   	push   %edi
     98f:	56                   	push   %esi
     990:	50                   	push   %eax
     991:	e8 6a fe ff ff       	call   800 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     996:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     999:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     99c:	eb 15                	jmp    9b3 <parseexec+0x73>
     99e:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     9a0:	83 ec 04             	sub    $0x4,%esp
     9a3:	57                   	push   %edi
     9a4:	56                   	push   %esi
     9a5:	ff 75 d4             	push   -0x2c(%ebp)
     9a8:	e8 53 fe ff ff       	call   800 <parseredirs>
     9ad:	83 c4 10             	add    $0x10,%esp
     9b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     9b3:	83 ec 04             	sub    $0x4,%esp
     9b6:	68 ec 14 00 00       	push   $0x14ec
     9bb:	57                   	push   %edi
     9bc:	56                   	push   %esi
     9bd:	e8 be fd ff ff       	call   780 <peek>
     9c2:	83 c4 10             	add    $0x10,%esp
     9c5:	85 c0                	test   %eax,%eax
     9c7:	75 5f                	jne    a28 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     9c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     9cc:	50                   	push   %eax
     9cd:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9d0:	50                   	push   %eax
     9d1:	57                   	push   %edi
     9d2:	56                   	push   %esi
     9d3:	e8 48 fc ff ff       	call   620 <gettoken>
     9d8:	83 c4 10             	add    $0x10,%esp
     9db:	85 c0                	test   %eax,%eax
     9dd:	74 49                	je     a28 <parseexec+0xe8>
    if(tok != 'a')
     9df:	83 f8 61             	cmp    $0x61,%eax
     9e2:	75 62                	jne    a46 <parseexec+0x106>
    cmd->argv[argc] = q;
     9e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9e7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9ea:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     9ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9f1:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     9f5:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     9f8:	83 fb 0a             	cmp    $0xa,%ebx
     9fb:	75 a3                	jne    9a0 <parseexec+0x60>
      panic("too many args");
     9fd:	83 ec 0c             	sub    $0xc,%esp
     a00:	68 de 14 00 00       	push   $0x14de
     a05:	e8 06 f9 ff ff       	call   310 <panic>
     a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     a10:	89 7d 0c             	mov    %edi,0xc(%ebp)
     a13:	89 75 08             	mov    %esi,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     a16:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a19:	5b                   	pop    %ebx
     a1a:	5e                   	pop    %esi
     a1b:	5f                   	pop    %edi
     a1c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     a1d:	e9 ae 01 00 00       	jmp    bd0 <parseblock>
     a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     a28:	8b 45 d0             	mov    -0x30(%ebp),%eax
     a2b:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
     a32:	00 
  cmd->eargv[argc] = 0;
     a33:	c7 44 98 2c 00 00 00 	movl   $0x0,0x2c(%eax,%ebx,4)
     a3a:	00 
}
     a3b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a41:	5b                   	pop    %ebx
     a42:	5e                   	pop    %esi
     a43:	5f                   	pop    %edi
     a44:	5d                   	pop    %ebp
     a45:	c3                   	ret    
      panic("syntax");
     a46:	83 ec 0c             	sub    $0xc,%esp
     a49:	68 d7 14 00 00       	push   $0x14d7
     a4e:	e8 bd f8 ff ff       	call   310 <panic>
     a53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a60 <parsepipe>:
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	57                   	push   %edi
     a64:	56                   	push   %esi
     a65:	53                   	push   %ebx
     a66:	83 ec 14             	sub    $0x14,%esp
     a69:	8b 75 08             	mov    0x8(%ebp),%esi
     a6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     a6f:	57                   	push   %edi
     a70:	56                   	push   %esi
     a71:	e8 ca fe ff ff       	call   940 <parseexec>
  if(peek(ps, es, "|")){
     a76:	83 c4 0c             	add    $0xc,%esp
     a79:	68 f1 14 00 00       	push   $0x14f1
  cmd = parseexec(ps, es);
     a7e:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     a80:	57                   	push   %edi
     a81:	56                   	push   %esi
     a82:	e8 f9 fc ff ff       	call   780 <peek>
     a87:	83 c4 10             	add    $0x10,%esp
     a8a:	85 c0                	test   %eax,%eax
     a8c:	75 12                	jne    aa0 <parsepipe+0x40>
}
     a8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a91:	89 d8                	mov    %ebx,%eax
     a93:	5b                   	pop    %ebx
     a94:	5e                   	pop    %esi
     a95:	5f                   	pop    %edi
     a96:	5d                   	pop    %ebp
     a97:	c3                   	ret    
     a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a9f:	90                   	nop
    gettoken(ps, es, 0, 0);
     aa0:	6a 00                	push   $0x0
     aa2:	6a 00                	push   $0x0
     aa4:	57                   	push   %edi
     aa5:	56                   	push   %esi
     aa6:	e8 75 fb ff ff       	call   620 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     aab:	58                   	pop    %eax
     aac:	5a                   	pop    %edx
     aad:	57                   	push   %edi
     aae:	56                   	push   %esi
     aaf:	e8 ac ff ff ff       	call   a60 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     ab4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     abb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     abd:	e8 be 08 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     ac2:	83 c4 0c             	add    $0xc,%esp
     ac5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     ac7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     ac9:	6a 00                	push   $0x0
     acb:	50                   	push   %eax
     acc:	e8 6f 03 00 00       	call   e40 <memset>
  cmd->left = left;
     ad1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     ad4:	83 c4 10             	add    $0x10,%esp
     ad7:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     ad9:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     adf:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     ae1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     ae4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ae7:	5b                   	pop    %ebx
     ae8:	5e                   	pop    %esi
     ae9:	5f                   	pop    %edi
     aea:	5d                   	pop    %ebp
     aeb:	c3                   	ret    
     aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000af0 <parseline>:
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	57                   	push   %edi
     af4:	56                   	push   %esi
     af5:	53                   	push   %ebx
     af6:	83 ec 24             	sub    $0x24,%esp
     af9:	8b 75 08             	mov    0x8(%ebp),%esi
     afc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     aff:	57                   	push   %edi
     b00:	56                   	push   %esi
     b01:	e8 5a ff ff ff       	call   a60 <parsepipe>
  while(peek(ps, es, "&")){
     b06:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     b09:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     b0b:	eb 3b                	jmp    b48 <parseline+0x58>
     b0d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     b10:	6a 00                	push   $0x0
     b12:	6a 00                	push   $0x0
     b14:	57                   	push   %edi
     b15:	56                   	push   %esi
     b16:	e8 05 fb ff ff       	call   620 <gettoken>
  cmd = malloc(sizeof(*cmd));
     b1b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     b22:	e8 59 08 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     b27:	83 c4 0c             	add    $0xc,%esp
     b2a:	6a 08                	push   $0x8
     b2c:	6a 00                	push   $0x0
     b2e:	50                   	push   %eax
     b2f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     b32:	e8 09 03 00 00       	call   e40 <memset>
  cmd->type = BACK;
     b37:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     b3a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     b3d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     b43:	89 5a 04             	mov    %ebx,0x4(%edx)
     b46:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     b48:	83 ec 04             	sub    $0x4,%esp
     b4b:	68 f3 14 00 00       	push   $0x14f3
     b50:	57                   	push   %edi
     b51:	56                   	push   %esi
     b52:	e8 29 fc ff ff       	call   780 <peek>
     b57:	83 c4 10             	add    $0x10,%esp
     b5a:	85 c0                	test   %eax,%eax
     b5c:	75 b2                	jne    b10 <parseline+0x20>
  if(peek(ps, es, ";")){
     b5e:	83 ec 04             	sub    $0x4,%esp
     b61:	68 ef 14 00 00       	push   $0x14ef
     b66:	57                   	push   %edi
     b67:	56                   	push   %esi
     b68:	e8 13 fc ff ff       	call   780 <peek>
     b6d:	83 c4 10             	add    $0x10,%esp
     b70:	85 c0                	test   %eax,%eax
     b72:	75 0c                	jne    b80 <parseline+0x90>
}
     b74:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b77:	89 d8                	mov    %ebx,%eax
     b79:	5b                   	pop    %ebx
     b7a:	5e                   	pop    %esi
     b7b:	5f                   	pop    %edi
     b7c:	5d                   	pop    %ebp
     b7d:	c3                   	ret    
     b7e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     b80:	6a 00                	push   $0x0
     b82:	6a 00                	push   $0x0
     b84:	57                   	push   %edi
     b85:	56                   	push   %esi
     b86:	e8 95 fa ff ff       	call   620 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     b8b:	58                   	pop    %eax
     b8c:	5a                   	pop    %edx
     b8d:	57                   	push   %edi
     b8e:	56                   	push   %esi
     b8f:	e8 5c ff ff ff       	call   af0 <parseline>
  cmd = malloc(sizeof(*cmd));
     b94:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     b9b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     b9d:	e8 de 07 00 00       	call   1380 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     ba2:	83 c4 0c             	add    $0xc,%esp
     ba5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     ba7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     ba9:	6a 00                	push   $0x0
     bab:	50                   	push   %eax
     bac:	e8 8f 02 00 00       	call   e40 <memset>
  cmd->left = left;
     bb1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     bb4:	83 c4 10             	add    $0x10,%esp
     bb7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     bb9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     bbf:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     bc1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     bc4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bc7:	5b                   	pop    %ebx
     bc8:	5e                   	pop    %esi
     bc9:	5f                   	pop    %edi
     bca:	5d                   	pop    %ebp
     bcb:	c3                   	ret    
     bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000bd0 <parseblock>:
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	57                   	push   %edi
     bd4:	56                   	push   %esi
     bd5:	53                   	push   %ebx
     bd6:	83 ec 10             	sub    $0x10,%esp
     bd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bdc:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     bdf:	68 d5 14 00 00       	push   $0x14d5
     be4:	56                   	push   %esi
     be5:	53                   	push   %ebx
     be6:	e8 95 fb ff ff       	call   780 <peek>
     beb:	83 c4 10             	add    $0x10,%esp
     bee:	85 c0                	test   %eax,%eax
     bf0:	74 4a                	je     c3c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     bf2:	6a 00                	push   $0x0
     bf4:	6a 00                	push   $0x0
     bf6:	56                   	push   %esi
     bf7:	53                   	push   %ebx
     bf8:	e8 23 fa ff ff       	call   620 <gettoken>
  cmd = parseline(ps, es);
     bfd:	58                   	pop    %eax
     bfe:	5a                   	pop    %edx
     bff:	56                   	push   %esi
     c00:	53                   	push   %ebx
     c01:	e8 ea fe ff ff       	call   af0 <parseline>
  if(!peek(ps, es, ")"))
     c06:	83 c4 0c             	add    $0xc,%esp
     c09:	68 11 15 00 00       	push   $0x1511
  cmd = parseline(ps, es);
     c0e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     c10:	56                   	push   %esi
     c11:	53                   	push   %ebx
     c12:	e8 69 fb ff ff       	call   780 <peek>
     c17:	83 c4 10             	add    $0x10,%esp
     c1a:	85 c0                	test   %eax,%eax
     c1c:	74 2b                	je     c49 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     c1e:	6a 00                	push   $0x0
     c20:	6a 00                	push   $0x0
     c22:	56                   	push   %esi
     c23:	53                   	push   %ebx
     c24:	e8 f7 f9 ff ff       	call   620 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     c29:	83 c4 0c             	add    $0xc,%esp
     c2c:	56                   	push   %esi
     c2d:	53                   	push   %ebx
     c2e:	57                   	push   %edi
     c2f:	e8 cc fb ff ff       	call   800 <parseredirs>
}
     c34:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c37:	5b                   	pop    %ebx
     c38:	5e                   	pop    %esi
     c39:	5f                   	pop    %edi
     c3a:	5d                   	pop    %ebp
     c3b:	c3                   	ret    
    panic("parseblock");
     c3c:	83 ec 0c             	sub    $0xc,%esp
     c3f:	68 f5 14 00 00       	push   $0x14f5
     c44:	e8 c7 f6 ff ff       	call   310 <panic>
    panic("syntax - missing )");
     c49:	83 ec 0c             	sub    $0xc,%esp
     c4c:	68 00 15 00 00       	push   $0x1500
     c51:	e8 ba f6 ff ff       	call   310 <panic>
     c56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c5d:	8d 76 00             	lea    0x0(%esi),%esi

00000c60 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	53                   	push   %ebx
     c64:	83 ec 04             	sub    $0x4,%esp
     c67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     c6a:	85 db                	test   %ebx,%ebx
     c6c:	0f 84 8e 00 00 00    	je     d00 <nulterminate+0xa0>
    return 0;

  switch(cmd->type){
     c72:	83 3b 05             	cmpl   $0x5,(%ebx)
     c75:	77 61                	ja     cd8 <nulterminate+0x78>
     c77:	8b 03                	mov    (%ebx),%eax
     c79:	ff 24 85 50 15 00 00 	jmp    *0x1550(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     c80:	83 ec 0c             	sub    $0xc,%esp
     c83:	ff 73 04             	push   0x4(%ebx)
     c86:	e8 d5 ff ff ff       	call   c60 <nulterminate>
    nulterminate(lcmd->right);
     c8b:	58                   	pop    %eax
     c8c:	ff 73 08             	push   0x8(%ebx)
     c8f:	e8 cc ff ff ff       	call   c60 <nulterminate>
    break;
     c94:	83 c4 10             	add    $0x10,%esp
     c97:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     c99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c9c:	c9                   	leave  
     c9d:	c3                   	ret    
     c9e:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     ca0:	83 ec 0c             	sub    $0xc,%esp
     ca3:	ff 73 04             	push   0x4(%ebx)
     ca6:	e8 b5 ff ff ff       	call   c60 <nulterminate>
    break;
     cab:	89 d8                	mov    %ebx,%eax
     cad:	83 c4 10             	add    $0x10,%esp
}
     cb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cb3:	c9                   	leave  
     cb4:	c3                   	ret    
     cb5:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     cb8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     cbb:	8d 43 08             	lea    0x8(%ebx),%eax
     cbe:	85 c9                	test   %ecx,%ecx
     cc0:	74 16                	je     cd8 <nulterminate+0x78>
     cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     cc8:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     ccb:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     cce:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     cd1:	8b 50 fc             	mov    -0x4(%eax),%edx
     cd4:	85 d2                	test   %edx,%edx
     cd6:	75 f0                	jne    cc8 <nulterminate+0x68>
  switch(cmd->type){
     cd8:	89 d8                	mov    %ebx,%eax
}
     cda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cdd:	c9                   	leave  
     cde:	c3                   	ret    
     cdf:	90                   	nop
    nulterminate(rcmd->cmd);
     ce0:	83 ec 0c             	sub    $0xc,%esp
     ce3:	ff 73 04             	push   0x4(%ebx)
     ce6:	e8 75 ff ff ff       	call   c60 <nulterminate>
    *rcmd->efile = 0;
     ceb:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     cee:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     cf1:	c6 00 00             	movb   $0x0,(%eax)
    break;
     cf4:	89 d8                	mov    %ebx,%eax
}
     cf6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cf9:	c9                   	leave  
     cfa:	c3                   	ret    
     cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cff:	90                   	nop
    return 0;
     d00:	31 c0                	xor    %eax,%eax
     d02:	eb 95                	jmp    c99 <nulterminate+0x39>
     d04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d0f:	90                   	nop

00000d10 <parsecmd>:
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	57                   	push   %edi
     d14:	56                   	push   %esi
  cmd = parseline(&s, es);
     d15:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     d18:	53                   	push   %ebx
     d19:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     d1c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d1f:	53                   	push   %ebx
     d20:	e8 eb 00 00 00       	call   e10 <strlen>
  cmd = parseline(&s, es);
     d25:	59                   	pop    %ecx
     d26:	5e                   	pop    %esi
  es = s + strlen(s);
     d27:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     d29:	53                   	push   %ebx
     d2a:	57                   	push   %edi
     d2b:	e8 c0 fd ff ff       	call   af0 <parseline>
  peek(&s, es, "");
     d30:	83 c4 0c             	add    $0xc,%esp
     d33:	68 9f 14 00 00       	push   $0x149f
  cmd = parseline(&s, es);
     d38:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     d3a:	53                   	push   %ebx
     d3b:	57                   	push   %edi
     d3c:	e8 3f fa ff ff       	call   780 <peek>
  if(s != es){
     d41:	8b 45 08             	mov    0x8(%ebp),%eax
     d44:	83 c4 10             	add    $0x10,%esp
     d47:	39 d8                	cmp    %ebx,%eax
     d49:	75 13                	jne    d5e <parsecmd+0x4e>
  nulterminate(cmd);
     d4b:	83 ec 0c             	sub    $0xc,%esp
     d4e:	56                   	push   %esi
     d4f:	e8 0c ff ff ff       	call   c60 <nulterminate>
}
     d54:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d57:	89 f0                	mov    %esi,%eax
     d59:	5b                   	pop    %ebx
     d5a:	5e                   	pop    %esi
     d5b:	5f                   	pop    %edi
     d5c:	5d                   	pop    %ebp
     d5d:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     d5e:	52                   	push   %edx
     d5f:	50                   	push   %eax
     d60:	68 13 15 00 00       	push   $0x1513
     d65:	6a 02                	push   $0x2
     d67:	e8 e4 03 00 00       	call   1150 <printf>
    panic("syntax");
     d6c:	c7 04 24 d7 14 00 00 	movl   $0x14d7,(%esp)
     d73:	e8 98 f5 ff ff       	call   310 <panic>
     d78:	66 90                	xchg   %ax,%ax
     d7a:	66 90                	xchg   %ax,%ax
     d7c:	66 90                	xchg   %ax,%ax
     d7e:	66 90                	xchg   %ax,%ax

00000d80 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     d80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     d81:	31 c0                	xor    %eax,%eax
{
     d83:	89 e5                	mov    %esp,%ebp
     d85:	53                   	push   %ebx
     d86:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     d90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     d94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     d97:	83 c0 01             	add    $0x1,%eax
     d9a:	84 d2                	test   %dl,%dl
     d9c:	75 f2                	jne    d90 <strcpy+0x10>
    ;
  return os;
}
     d9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     da1:	89 c8                	mov    %ecx,%eax
     da3:	c9                   	leave  
     da4:	c3                   	ret    
     da5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000db0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	53                   	push   %ebx
     db4:	8b 55 08             	mov    0x8(%ebp),%edx
     db7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     dba:	0f b6 02             	movzbl (%edx),%eax
     dbd:	84 c0                	test   %al,%al
     dbf:	75 17                	jne    dd8 <strcmp+0x28>
     dc1:	eb 3a                	jmp    dfd <strcmp+0x4d>
     dc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dc7:	90                   	nop
     dc8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     dcc:	83 c2 01             	add    $0x1,%edx
     dcf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     dd2:	84 c0                	test   %al,%al
     dd4:	74 1a                	je     df0 <strcmp+0x40>
    p++, q++;
     dd6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
     dd8:	0f b6 19             	movzbl (%ecx),%ebx
     ddb:	38 c3                	cmp    %al,%bl
     ddd:	74 e9                	je     dc8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     ddf:	29 d8                	sub    %ebx,%eax
}
     de1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     de4:	c9                   	leave  
     de5:	c3                   	ret    
     de6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ded:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
     df0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     df4:	31 c0                	xor    %eax,%eax
     df6:	29 d8                	sub    %ebx,%eax
}
     df8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     dfb:	c9                   	leave  
     dfc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
     dfd:	0f b6 19             	movzbl (%ecx),%ebx
     e00:	31 c0                	xor    %eax,%eax
     e02:	eb db                	jmp    ddf <strcmp+0x2f>
     e04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e0f:	90                   	nop

00000e10 <strlen>:

uint
strlen(const char *s)
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     e16:	80 3a 00             	cmpb   $0x0,(%edx)
     e19:	74 15                	je     e30 <strlen+0x20>
     e1b:	31 c0                	xor    %eax,%eax
     e1d:	8d 76 00             	lea    0x0(%esi),%esi
     e20:	83 c0 01             	add    $0x1,%eax
     e23:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     e27:	89 c1                	mov    %eax,%ecx
     e29:	75 f5                	jne    e20 <strlen+0x10>
    ;
  return n;
}
     e2b:	89 c8                	mov    %ecx,%eax
     e2d:	5d                   	pop    %ebp
     e2e:	c3                   	ret    
     e2f:	90                   	nop
  for(n = 0; s[n]; n++)
     e30:	31 c9                	xor    %ecx,%ecx
}
     e32:	5d                   	pop    %ebp
     e33:	89 c8                	mov    %ecx,%eax
     e35:	c3                   	ret    
     e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e3d:	8d 76 00             	lea    0x0(%esi),%esi

00000e40 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	57                   	push   %edi
     e44:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     e47:	8b 4d 10             	mov    0x10(%ebp),%ecx
     e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e4d:	89 d7                	mov    %edx,%edi
     e4f:	fc                   	cld    
     e50:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     e52:	8b 7d fc             	mov    -0x4(%ebp),%edi
     e55:	89 d0                	mov    %edx,%eax
     e57:	c9                   	leave  
     e58:	c3                   	ret    
     e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e60 <strchr>:

char*
strchr(const char *s, char c)
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	8b 45 08             	mov    0x8(%ebp),%eax
     e66:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     e6a:	0f b6 10             	movzbl (%eax),%edx
     e6d:	84 d2                	test   %dl,%dl
     e6f:	75 12                	jne    e83 <strchr+0x23>
     e71:	eb 1d                	jmp    e90 <strchr+0x30>
     e73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e77:	90                   	nop
     e78:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     e7c:	83 c0 01             	add    $0x1,%eax
     e7f:	84 d2                	test   %dl,%dl
     e81:	74 0d                	je     e90 <strchr+0x30>
    if(*s == c)
     e83:	38 d1                	cmp    %dl,%cl
     e85:	75 f1                	jne    e78 <strchr+0x18>
      return (char*)s;
  return 0;
}
     e87:	5d                   	pop    %ebp
     e88:	c3                   	ret    
     e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     e90:	31 c0                	xor    %eax,%eax
}
     e92:	5d                   	pop    %ebp
     e93:	c3                   	ret    
     e94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e9f:	90                   	nop

00000ea0 <gets>:

char*
gets(char *buf, int max)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	57                   	push   %edi
     ea4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     ea5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     ea8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     ea9:	31 db                	xor    %ebx,%ebx
{
     eab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     eae:	eb 27                	jmp    ed7 <gets+0x37>
    cc = read(0, &c, 1);
     eb0:	83 ec 04             	sub    $0x4,%esp
     eb3:	6a 01                	push   $0x1
     eb5:	57                   	push   %edi
     eb6:	6a 00                	push   $0x0
     eb8:	e8 2e 01 00 00       	call   feb <read>
    if(cc < 1)
     ebd:	83 c4 10             	add    $0x10,%esp
     ec0:	85 c0                	test   %eax,%eax
     ec2:	7e 1d                	jle    ee1 <gets+0x41>
      break;
    buf[i++] = c;
     ec4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     ec8:	8b 55 08             	mov    0x8(%ebp),%edx
     ecb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     ecf:	3c 0a                	cmp    $0xa,%al
     ed1:	74 1d                	je     ef0 <gets+0x50>
     ed3:	3c 0d                	cmp    $0xd,%al
     ed5:	74 19                	je     ef0 <gets+0x50>
  for(i=0; i+1 < max; ){
     ed7:	89 de                	mov    %ebx,%esi
     ed9:	83 c3 01             	add    $0x1,%ebx
     edc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     edf:	7c cf                	jl     eb0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     ee1:	8b 45 08             	mov    0x8(%ebp),%eax
     ee4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     ee8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eeb:	5b                   	pop    %ebx
     eec:	5e                   	pop    %esi
     eed:	5f                   	pop    %edi
     eee:	5d                   	pop    %ebp
     eef:	c3                   	ret    
  buf[i] = '\0';
     ef0:	8b 45 08             	mov    0x8(%ebp),%eax
     ef3:	89 de                	mov    %ebx,%esi
     ef5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
     ef9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     efc:	5b                   	pop    %ebx
     efd:	5e                   	pop    %esi
     efe:	5f                   	pop    %edi
     eff:	5d                   	pop    %ebp
     f00:	c3                   	ret    
     f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f0f:	90                   	nop

00000f10 <stat>:

int
stat(const char *n, struct stat *st)
{
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	56                   	push   %esi
     f14:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f15:	83 ec 08             	sub    $0x8,%esp
     f18:	6a 00                	push   $0x0
     f1a:	ff 75 08             	push   0x8(%ebp)
     f1d:	e8 f1 00 00 00       	call   1013 <open>
  if(fd < 0)
     f22:	83 c4 10             	add    $0x10,%esp
     f25:	85 c0                	test   %eax,%eax
     f27:	78 27                	js     f50 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     f29:	83 ec 08             	sub    $0x8,%esp
     f2c:	ff 75 0c             	push   0xc(%ebp)
     f2f:	89 c3                	mov    %eax,%ebx
     f31:	50                   	push   %eax
     f32:	e8 f4 00 00 00       	call   102b <fstat>
  close(fd);
     f37:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     f3a:	89 c6                	mov    %eax,%esi
  close(fd);
     f3c:	e8 ba 00 00 00       	call   ffb <close>
  return r;
     f41:	83 c4 10             	add    $0x10,%esp
}
     f44:	8d 65 f8             	lea    -0x8(%ebp),%esp
     f47:	89 f0                	mov    %esi,%eax
     f49:	5b                   	pop    %ebx
     f4a:	5e                   	pop    %esi
     f4b:	5d                   	pop    %ebp
     f4c:	c3                   	ret    
     f4d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     f50:	be ff ff ff ff       	mov    $0xffffffff,%esi
     f55:	eb ed                	jmp    f44 <stat+0x34>
     f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f5e:	66 90                	xchg   %ax,%ax

00000f60 <atoi>:

int
atoi(const char *s)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	53                   	push   %ebx
     f64:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f67:	0f be 02             	movsbl (%edx),%eax
     f6a:	8d 48 d0             	lea    -0x30(%eax),%ecx
     f6d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     f70:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     f75:	77 1e                	ja     f95 <atoi+0x35>
     f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f7e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     f80:	83 c2 01             	add    $0x1,%edx
     f83:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     f86:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     f8a:	0f be 02             	movsbl (%edx),%eax
     f8d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     f90:	80 fb 09             	cmp    $0x9,%bl
     f93:	76 eb                	jbe    f80 <atoi+0x20>
  return n;
}
     f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f98:	89 c8                	mov    %ecx,%eax
     f9a:	c9                   	leave  
     f9b:	c3                   	ret    
     f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000fa0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	57                   	push   %edi
     fa4:	8b 45 10             	mov    0x10(%ebp),%eax
     fa7:	8b 55 08             	mov    0x8(%ebp),%edx
     faa:	56                   	push   %esi
     fab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     fae:	85 c0                	test   %eax,%eax
     fb0:	7e 13                	jle    fc5 <memmove+0x25>
     fb2:	01 d0                	add    %edx,%eax
  dst = vdst;
     fb4:	89 d7                	mov    %edx,%edi
     fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fbd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     fc0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     fc1:	39 f8                	cmp    %edi,%eax
     fc3:	75 fb                	jne    fc0 <memmove+0x20>
  return vdst;
}
     fc5:	5e                   	pop    %esi
     fc6:	89 d0                	mov    %edx,%eax
     fc8:	5f                   	pop    %edi
     fc9:	5d                   	pop    %ebp
     fca:	c3                   	ret    

00000fcb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     fcb:	b8 01 00 00 00       	mov    $0x1,%eax
     fd0:	cd 40                	int    $0x40
     fd2:	c3                   	ret    

00000fd3 <exit>:
SYSCALL(exit)
     fd3:	b8 02 00 00 00       	mov    $0x2,%eax
     fd8:	cd 40                	int    $0x40
     fda:	c3                   	ret    

00000fdb <wait>:
SYSCALL(wait)
     fdb:	b8 03 00 00 00       	mov    $0x3,%eax
     fe0:	cd 40                	int    $0x40
     fe2:	c3                   	ret    

00000fe3 <pipe>:
SYSCALL(pipe)
     fe3:	b8 04 00 00 00       	mov    $0x4,%eax
     fe8:	cd 40                	int    $0x40
     fea:	c3                   	ret    

00000feb <read>:
SYSCALL(read)
     feb:	b8 05 00 00 00       	mov    $0x5,%eax
     ff0:	cd 40                	int    $0x40
     ff2:	c3                   	ret    

00000ff3 <write>:
SYSCALL(write)
     ff3:	b8 10 00 00 00       	mov    $0x10,%eax
     ff8:	cd 40                	int    $0x40
     ffa:	c3                   	ret    

00000ffb <close>:
SYSCALL(close)
     ffb:	b8 15 00 00 00       	mov    $0x15,%eax
    1000:	cd 40                	int    $0x40
    1002:	c3                   	ret    

00001003 <kill>:
SYSCALL(kill)
    1003:	b8 06 00 00 00       	mov    $0x6,%eax
    1008:	cd 40                	int    $0x40
    100a:	c3                   	ret    

0000100b <exec>:
SYSCALL(exec)
    100b:	b8 07 00 00 00       	mov    $0x7,%eax
    1010:	cd 40                	int    $0x40
    1012:	c3                   	ret    

00001013 <open>:
SYSCALL(open)
    1013:	b8 0f 00 00 00       	mov    $0xf,%eax
    1018:	cd 40                	int    $0x40
    101a:	c3                   	ret    

0000101b <mknod>:
SYSCALL(mknod)
    101b:	b8 11 00 00 00       	mov    $0x11,%eax
    1020:	cd 40                	int    $0x40
    1022:	c3                   	ret    

00001023 <unlink>:
SYSCALL(unlink)
    1023:	b8 12 00 00 00       	mov    $0x12,%eax
    1028:	cd 40                	int    $0x40
    102a:	c3                   	ret    

0000102b <fstat>:
SYSCALL(fstat)
    102b:	b8 08 00 00 00       	mov    $0x8,%eax
    1030:	cd 40                	int    $0x40
    1032:	c3                   	ret    

00001033 <link>:
SYSCALL(link)
    1033:	b8 13 00 00 00       	mov    $0x13,%eax
    1038:	cd 40                	int    $0x40
    103a:	c3                   	ret    

0000103b <mkdir>:
SYSCALL(mkdir)
    103b:	b8 14 00 00 00       	mov    $0x14,%eax
    1040:	cd 40                	int    $0x40
    1042:	c3                   	ret    

00001043 <chdir>:
SYSCALL(chdir)
    1043:	b8 09 00 00 00       	mov    $0x9,%eax
    1048:	cd 40                	int    $0x40
    104a:	c3                   	ret    

0000104b <dup>:
SYSCALL(dup)
    104b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1050:	cd 40                	int    $0x40
    1052:	c3                   	ret    

00001053 <getpid>:
SYSCALL(getpid)
    1053:	b8 0b 00 00 00       	mov    $0xb,%eax
    1058:	cd 40                	int    $0x40
    105a:	c3                   	ret    

0000105b <sbrk>:
SYSCALL(sbrk)
    105b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1060:	cd 40                	int    $0x40
    1062:	c3                   	ret    

00001063 <sleep>:
SYSCALL(sleep)
    1063:	b8 0d 00 00 00       	mov    $0xd,%eax
    1068:	cd 40                	int    $0x40
    106a:	c3                   	ret    

0000106b <uptime>:
SYSCALL(uptime)
    106b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1070:	cd 40                	int    $0x40
    1072:	c3                   	ret    

00001073 <trace>:
SYSCALL(trace)
    1073:	b8 16 00 00 00       	mov    $0x16,%eax
    1078:	cd 40                	int    $0x40
    107a:	c3                   	ret    

0000107b <ps>:
SYSCALL(ps)
    107b:	b8 17 00 00 00       	mov    $0x17,%eax
    1080:	cd 40                	int    $0x40
    1082:	c3                   	ret    

00001083 <history>:
SYSCALL(history)
    1083:	b8 18 00 00 00       	mov    $0x18,%eax
    1088:	cd 40                	int    $0x40
    108a:	c3                   	ret    

0000108b <wait2>:
SYSCALL(wait2)
    108b:	b8 19 00 00 00       	mov    $0x19,%eax
    1090:	cd 40                	int    $0x40
    1092:	c3                   	ret    
    1093:	66 90                	xchg   %ax,%ax
    1095:	66 90                	xchg   %ax,%ax
    1097:	66 90                	xchg   %ax,%ax
    1099:	66 90                	xchg   %ax,%ax
    109b:	66 90                	xchg   %ax,%ax
    109d:	66 90                	xchg   %ax,%ax
    109f:	90                   	nop

000010a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	57                   	push   %edi
    10a4:	56                   	push   %esi
    10a5:	53                   	push   %ebx
    10a6:	83 ec 3c             	sub    $0x3c,%esp
    10a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    10ac:	89 d1                	mov    %edx,%ecx
{
    10ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    10b1:	85 d2                	test   %edx,%edx
    10b3:	0f 89 7f 00 00 00    	jns    1138 <printint+0x98>
    10b9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    10bd:	74 79                	je     1138 <printint+0x98>
    neg = 1;
    10bf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    10c6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    10c8:	31 db                	xor    %ebx,%ebx
    10ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
    10cd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    10d0:	89 c8                	mov    %ecx,%eax
    10d2:	31 d2                	xor    %edx,%edx
    10d4:	89 cf                	mov    %ecx,%edi
    10d6:	f7 75 c4             	divl   -0x3c(%ebp)
    10d9:	0f b6 92 c8 15 00 00 	movzbl 0x15c8(%edx),%edx
    10e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
    10e3:	89 d8                	mov    %ebx,%eax
    10e5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    10e8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    10eb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    10ee:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    10f1:	76 dd                	jbe    10d0 <printint+0x30>
  if(neg)
    10f3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    10f6:	85 c9                	test   %ecx,%ecx
    10f8:	74 0c                	je     1106 <printint+0x66>
    buf[i++] = '-';
    10fa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    10ff:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1101:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1106:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1109:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    110d:	eb 07                	jmp    1116 <printint+0x76>
    110f:	90                   	nop
    putc(fd, buf[i]);
    1110:	0f b6 13             	movzbl (%ebx),%edx
    1113:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1116:	83 ec 04             	sub    $0x4,%esp
    1119:	88 55 d7             	mov    %dl,-0x29(%ebp)
    111c:	6a 01                	push   $0x1
    111e:	56                   	push   %esi
    111f:	57                   	push   %edi
    1120:	e8 ce fe ff ff       	call   ff3 <write>
  while(--i >= 0)
    1125:	83 c4 10             	add    $0x10,%esp
    1128:	39 de                	cmp    %ebx,%esi
    112a:	75 e4                	jne    1110 <printint+0x70>
}
    112c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    112f:	5b                   	pop    %ebx
    1130:	5e                   	pop    %esi
    1131:	5f                   	pop    %edi
    1132:	5d                   	pop    %ebp
    1133:	c3                   	ret    
    1134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1138:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    113f:	eb 87                	jmp    10c8 <printint+0x28>
    1141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1148:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    114f:	90                   	nop

00001150 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	57                   	push   %edi
    1154:	56                   	push   %esi
    1155:	53                   	push   %ebx
    1156:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1159:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    115c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    115f:	0f b6 13             	movzbl (%ebx),%edx
    1162:	84 d2                	test   %dl,%dl
    1164:	74 6a                	je     11d0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    1166:	8d 45 10             	lea    0x10(%ebp),%eax
    1169:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    116c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    116f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    1171:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1174:	eb 36                	jmp    11ac <printf+0x5c>
    1176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    117d:	8d 76 00             	lea    0x0(%esi),%esi
    1180:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1183:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    1188:	83 f8 25             	cmp    $0x25,%eax
    118b:	74 15                	je     11a2 <printf+0x52>
  write(fd, &c, 1);
    118d:	83 ec 04             	sub    $0x4,%esp
    1190:	88 55 e7             	mov    %dl,-0x19(%ebp)
    1193:	6a 01                	push   $0x1
    1195:	57                   	push   %edi
    1196:	56                   	push   %esi
    1197:	e8 57 fe ff ff       	call   ff3 <write>
    119c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    119f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    11a2:	0f b6 13             	movzbl (%ebx),%edx
    11a5:	83 c3 01             	add    $0x1,%ebx
    11a8:	84 d2                	test   %dl,%dl
    11aa:	74 24                	je     11d0 <printf+0x80>
    c = fmt[i] & 0xff;
    11ac:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    11af:	85 c9                	test   %ecx,%ecx
    11b1:	74 cd                	je     1180 <printf+0x30>
      }
    } else if(state == '%'){
    11b3:	83 f9 25             	cmp    $0x25,%ecx
    11b6:	75 ea                	jne    11a2 <printf+0x52>
      if(c == 'd'){
    11b8:	83 f8 25             	cmp    $0x25,%eax
    11bb:	0f 84 07 01 00 00    	je     12c8 <printf+0x178>
    11c1:	83 e8 63             	sub    $0x63,%eax
    11c4:	83 f8 15             	cmp    $0x15,%eax
    11c7:	77 17                	ja     11e0 <printf+0x90>
    11c9:	ff 24 85 70 15 00 00 	jmp    *0x1570(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    11d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11d3:	5b                   	pop    %ebx
    11d4:	5e                   	pop    %esi
    11d5:	5f                   	pop    %edi
    11d6:	5d                   	pop    %ebp
    11d7:	c3                   	ret    
    11d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11df:	90                   	nop
  write(fd, &c, 1);
    11e0:	83 ec 04             	sub    $0x4,%esp
    11e3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    11e6:	6a 01                	push   $0x1
    11e8:	57                   	push   %edi
    11e9:	56                   	push   %esi
    11ea:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    11ee:	e8 00 fe ff ff       	call   ff3 <write>
        putc(fd, c);
    11f3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    11f7:	83 c4 0c             	add    $0xc,%esp
    11fa:	88 55 e7             	mov    %dl,-0x19(%ebp)
    11fd:	6a 01                	push   $0x1
    11ff:	57                   	push   %edi
    1200:	56                   	push   %esi
    1201:	e8 ed fd ff ff       	call   ff3 <write>
        putc(fd, c);
    1206:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1209:	31 c9                	xor    %ecx,%ecx
    120b:	eb 95                	jmp    11a2 <printf+0x52>
    120d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1210:	83 ec 0c             	sub    $0xc,%esp
    1213:	b9 10 00 00 00       	mov    $0x10,%ecx
    1218:	6a 00                	push   $0x0
    121a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    121d:	8b 10                	mov    (%eax),%edx
    121f:	89 f0                	mov    %esi,%eax
    1221:	e8 7a fe ff ff       	call   10a0 <printint>
        ap++;
    1226:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    122a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    122d:	31 c9                	xor    %ecx,%ecx
    122f:	e9 6e ff ff ff       	jmp    11a2 <printf+0x52>
    1234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1238:	8b 45 d0             	mov    -0x30(%ebp),%eax
    123b:	8b 10                	mov    (%eax),%edx
        ap++;
    123d:	83 c0 04             	add    $0x4,%eax
    1240:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    1243:	85 d2                	test   %edx,%edx
    1245:	0f 84 8d 00 00 00    	je     12d8 <printf+0x188>
        while(*s != 0){
    124b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    124e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    1250:	84 c0                	test   %al,%al
    1252:	0f 84 4a ff ff ff    	je     11a2 <printf+0x52>
    1258:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    125b:	89 d3                	mov    %edx,%ebx
    125d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1260:	83 ec 04             	sub    $0x4,%esp
          s++;
    1263:	83 c3 01             	add    $0x1,%ebx
    1266:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1269:	6a 01                	push   $0x1
    126b:	57                   	push   %edi
    126c:	56                   	push   %esi
    126d:	e8 81 fd ff ff       	call   ff3 <write>
        while(*s != 0){
    1272:	0f b6 03             	movzbl (%ebx),%eax
    1275:	83 c4 10             	add    $0x10,%esp
    1278:	84 c0                	test   %al,%al
    127a:	75 e4                	jne    1260 <printf+0x110>
      state = 0;
    127c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    127f:	31 c9                	xor    %ecx,%ecx
    1281:	e9 1c ff ff ff       	jmp    11a2 <printf+0x52>
    1286:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    128d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1290:	83 ec 0c             	sub    $0xc,%esp
    1293:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1298:	6a 01                	push   $0x1
    129a:	e9 7b ff ff ff       	jmp    121a <printf+0xca>
    129f:	90                   	nop
        putc(fd, *ap);
    12a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    12a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    12a6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    12a8:	6a 01                	push   $0x1
    12aa:	57                   	push   %edi
    12ab:	56                   	push   %esi
        putc(fd, *ap);
    12ac:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    12af:	e8 3f fd ff ff       	call   ff3 <write>
        ap++;
    12b4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    12b8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    12bb:	31 c9                	xor    %ecx,%ecx
    12bd:	e9 e0 fe ff ff       	jmp    11a2 <printf+0x52>
    12c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    12c8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    12cb:	83 ec 04             	sub    $0x4,%esp
    12ce:	e9 2a ff ff ff       	jmp    11fd <printf+0xad>
    12d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12d7:	90                   	nop
          s = "(null)";
    12d8:	ba 68 15 00 00       	mov    $0x1568,%edx
        while(*s != 0){
    12dd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    12e0:	b8 28 00 00 00       	mov    $0x28,%eax
    12e5:	89 d3                	mov    %edx,%ebx
    12e7:	e9 74 ff ff ff       	jmp    1260 <printf+0x110>
    12ec:	66 90                	xchg   %ax,%ax
    12ee:	66 90                	xchg   %ax,%ax

000012f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12f1:	a1 24 1d 00 00       	mov    0x1d24,%eax
{
    12f6:	89 e5                	mov    %esp,%ebp
    12f8:	57                   	push   %edi
    12f9:	56                   	push   %esi
    12fa:	53                   	push   %ebx
    12fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    12fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1308:	89 c2                	mov    %eax,%edx
    130a:	8b 00                	mov    (%eax),%eax
    130c:	39 ca                	cmp    %ecx,%edx
    130e:	73 30                	jae    1340 <free+0x50>
    1310:	39 c1                	cmp    %eax,%ecx
    1312:	72 04                	jb     1318 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1314:	39 c2                	cmp    %eax,%edx
    1316:	72 f0                	jb     1308 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1318:	8b 73 fc             	mov    -0x4(%ebx),%esi
    131b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    131e:	39 f8                	cmp    %edi,%eax
    1320:	74 30                	je     1352 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1322:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1325:	8b 42 04             	mov    0x4(%edx),%eax
    1328:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    132b:	39 f1                	cmp    %esi,%ecx
    132d:	74 3a                	je     1369 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    132f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    1331:	5b                   	pop    %ebx
  freep = p;
    1332:	89 15 24 1d 00 00    	mov    %edx,0x1d24
}
    1338:	5e                   	pop    %esi
    1339:	5f                   	pop    %edi
    133a:	5d                   	pop    %ebp
    133b:	c3                   	ret    
    133c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1340:	39 c2                	cmp    %eax,%edx
    1342:	72 c4                	jb     1308 <free+0x18>
    1344:	39 c1                	cmp    %eax,%ecx
    1346:	73 c0                	jae    1308 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1348:	8b 73 fc             	mov    -0x4(%ebx),%esi
    134b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    134e:	39 f8                	cmp    %edi,%eax
    1350:	75 d0                	jne    1322 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1352:	03 70 04             	add    0x4(%eax),%esi
    1355:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1358:	8b 02                	mov    (%edx),%eax
    135a:	8b 00                	mov    (%eax),%eax
    135c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    135f:	8b 42 04             	mov    0x4(%edx),%eax
    1362:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1365:	39 f1                	cmp    %esi,%ecx
    1367:	75 c6                	jne    132f <free+0x3f>
    p->s.size += bp->s.size;
    1369:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    136c:	89 15 24 1d 00 00    	mov    %edx,0x1d24
    p->s.size += bp->s.size;
    1372:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1375:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1378:	89 0a                	mov    %ecx,(%edx)
}
    137a:	5b                   	pop    %ebx
    137b:	5e                   	pop    %esi
    137c:	5f                   	pop    %edi
    137d:	5d                   	pop    %ebp
    137e:	c3                   	ret    
    137f:	90                   	nop

00001380 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	57                   	push   %edi
    1384:	56                   	push   %esi
    1385:	53                   	push   %ebx
    1386:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1389:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    138c:	8b 3d 24 1d 00 00    	mov    0x1d24,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1392:	8d 70 07             	lea    0x7(%eax),%esi
    1395:	c1 ee 03             	shr    $0x3,%esi
    1398:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    139b:	85 ff                	test   %edi,%edi
    139d:	0f 84 9d 00 00 00    	je     1440 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13a3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    13a5:	8b 4a 04             	mov    0x4(%edx),%ecx
    13a8:	39 f1                	cmp    %esi,%ecx
    13aa:	73 6a                	jae    1416 <malloc+0x96>
    13ac:	bb 00 10 00 00       	mov    $0x1000,%ebx
    13b1:	39 de                	cmp    %ebx,%esi
    13b3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    13b6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    13bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    13c0:	eb 17                	jmp    13d9 <malloc+0x59>
    13c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    13ca:	8b 48 04             	mov    0x4(%eax),%ecx
    13cd:	39 f1                	cmp    %esi,%ecx
    13cf:	73 4f                	jae    1420 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    13d1:	8b 3d 24 1d 00 00    	mov    0x1d24,%edi
    13d7:	89 c2                	mov    %eax,%edx
    13d9:	39 d7                	cmp    %edx,%edi
    13db:	75 eb                	jne    13c8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    13dd:	83 ec 0c             	sub    $0xc,%esp
    13e0:	ff 75 e4             	push   -0x1c(%ebp)
    13e3:	e8 73 fc ff ff       	call   105b <sbrk>
  if(p == (char*)-1)
    13e8:	83 c4 10             	add    $0x10,%esp
    13eb:	83 f8 ff             	cmp    $0xffffffff,%eax
    13ee:	74 1c                	je     140c <malloc+0x8c>
  hp->s.size = nu;
    13f0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    13f3:	83 ec 0c             	sub    $0xc,%esp
    13f6:	83 c0 08             	add    $0x8,%eax
    13f9:	50                   	push   %eax
    13fa:	e8 f1 fe ff ff       	call   12f0 <free>
  return freep;
    13ff:	8b 15 24 1d 00 00    	mov    0x1d24,%edx
      if((p = morecore(nunits)) == 0)
    1405:	83 c4 10             	add    $0x10,%esp
    1408:	85 d2                	test   %edx,%edx
    140a:	75 bc                	jne    13c8 <malloc+0x48>
        return 0;
  }
}
    140c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    140f:	31 c0                	xor    %eax,%eax
}
    1411:	5b                   	pop    %ebx
    1412:	5e                   	pop    %esi
    1413:	5f                   	pop    %edi
    1414:	5d                   	pop    %ebp
    1415:	c3                   	ret    
    if(p->s.size >= nunits){
    1416:	89 d0                	mov    %edx,%eax
    1418:	89 fa                	mov    %edi,%edx
    141a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1420:	39 ce                	cmp    %ecx,%esi
    1422:	74 4c                	je     1470 <malloc+0xf0>
        p->s.size -= nunits;
    1424:	29 f1                	sub    %esi,%ecx
    1426:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1429:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    142c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    142f:	89 15 24 1d 00 00    	mov    %edx,0x1d24
}
    1435:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1438:	83 c0 08             	add    $0x8,%eax
}
    143b:	5b                   	pop    %ebx
    143c:	5e                   	pop    %esi
    143d:	5f                   	pop    %edi
    143e:	5d                   	pop    %ebp
    143f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1440:	c7 05 24 1d 00 00 28 	movl   $0x1d28,0x1d24
    1447:	1d 00 00 
    base.s.size = 0;
    144a:	bf 28 1d 00 00       	mov    $0x1d28,%edi
    base.s.ptr = freep = prevp = &base;
    144f:	c7 05 28 1d 00 00 28 	movl   $0x1d28,0x1d28
    1456:	1d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1459:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    145b:	c7 05 2c 1d 00 00 00 	movl   $0x0,0x1d2c
    1462:	00 00 00 
    if(p->s.size >= nunits){
    1465:	e9 42 ff ff ff       	jmp    13ac <malloc+0x2c>
    146a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1470:	8b 08                	mov    (%eax),%ecx
    1472:	89 0a                	mov    %ecx,(%edx)
    1474:	eb b9                	jmp    142f <malloc+0xaf>
