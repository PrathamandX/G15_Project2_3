
user/_fops:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copystr>:
  dst[n + i] = 0;
}

static void
copystr(char *dst, char *src, int max)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
  int i;
  for(i = 0; i < max - 1 && src[i]; i++)
       6:	4785                	li	a5,1
       8:	02c7d663          	bge	a5,a2,34 <copystr+0x34>
       c:	86aa                	mv	a3,a0
       e:	367d                	addiw	a2,a2,-1
      10:	4781                	li	a5,0
      12:	0005c703          	lbu	a4,0(a1)
      16:	cb09                	beqz	a4,28 <copystr+0x28>
    dst[i] = src[i];
      18:	00e68023          	sb	a4,0(a3)
  for(i = 0; i < max - 1 && src[i]; i++)
      1c:	2785                	addiw	a5,a5,1
      1e:	0585                	addi	a1,a1,1
      20:	0685                	addi	a3,a3,1
      22:	fec798e3          	bne	a5,a2,12 <copystr+0x12>
      26:	87b2                	mv	a5,a2
  dst[i] = 0;
      28:	953e                	add	a0,a0,a5
      2a:	00050023          	sb	zero,0(a0)
}
      2e:	6422                	ld	s0,8(sp)
      30:	0141                	addi	sp,sp,16
      32:	8082                	ret
  for(i = 0; i < max - 1 && src[i]; i++)
      34:	4781                	li	a5,0
      36:	bfcd                	j	28 <copystr+0x28>

0000000000000038 <appendstr>:
{
      38:	7179                	addi	sp,sp,-48
      3a:	f406                	sd	ra,40(sp)
      3c:	f022                	sd	s0,32(sp)
      3e:	ec26                	sd	s1,24(sp)
      40:	e84a                	sd	s2,16(sp)
      42:	e44e                	sd	s3,8(sp)
      44:	1800                	addi	s0,sp,48
      46:	84aa                	mv	s1,a0
      48:	892e                	mv	s2,a1
      4a:	89b2                	mv	s3,a2
  int n = strlen(dst);
      4c:	4cb000ef          	jal	d16 <strlen>
      50:	0005079b          	sext.w	a5,a0
  while(n + i < max - 1 && src[i]){
      54:	fff9861b          	addiw	a2,s3,-1
      58:	02c7d863          	bge	a5,a2,88 <appendstr+0x50>
      5c:	85be                	mv	a1,a5
      5e:	0007851b          	sext.w	a0,a5
      62:	40b78733          	sub	a4,a5,a1
      66:	974a                	add	a4,a4,s2
      68:	00074703          	lbu	a4,0(a4)
      6c:	cf09                	beqz	a4,86 <appendstr+0x4e>
    dst[n + i] = src[i];
      6e:	00f486b3          	add	a3,s1,a5
      72:	00e68023          	sb	a4,0(a3)
  while(n + i < max - 1 && src[i]){
      76:	0785                	addi	a5,a5,1
      78:	0007871b          	sext.w	a4,a5
      7c:	fec741e3          	blt	a4,a2,5e <appendstr+0x26>
      80:	0015079b          	addiw	a5,a0,1
      84:	a011                	j	88 <appendstr+0x50>
      86:	87aa                	mv	a5,a0
  dst[n + i] = 0;
      88:	94be                	add	s1,s1,a5
      8a:	00048023          	sb	zero,0(s1)
}
      8e:	70a2                	ld	ra,40(sp)
      90:	7402                	ld	s0,32(sp)
      92:	64e2                	ld	s1,24(sp)
      94:	6942                	ld	s2,16(sp)
      96:	69a2                	ld	s3,8(sp)
      98:	6145                	addi	sp,sp,48
      9a:	8082                	ret

000000000000009c <lock_two>:
  fmunlock("fops.log", FM_WRITE);
}

static int
lock_two(char *a, int ma, char *b, int mb)
{
      9c:	7179                	addi	sp,sp,-48
      9e:	f406                	sd	ra,40(sp)
      a0:	f022                	sd	s0,32(sp)
      a2:	ec26                	sd	s1,24(sp)
      a4:	e84a                	sd	s2,16(sp)
      a6:	e44e                	sd	s3,8(sp)
      a8:	e052                	sd	s4,0(sp)
      aa:	1800                	addi	s0,sp,48
      ac:	8a2a                	mv	s4,a0
      ae:	892e                	mv	s2,a1
      b0:	84b2                	mv	s1,a2
      b2:	89b6                	mv	s3,a3
  if(strcmp(a, b) == 0){
      b4:	85b2                	mv	a1,a2
      b6:	435000ef          	jal	cea <strcmp>
      ba:	ed19                	bnez	a0,d8 <lock_two+0x3c>
    if(ma != mb)
      bc:	07299c63          	bne	s3,s2,134 <lock_two+0x98>
      return -1;
    return fmlock(a, ma);
      c0:	85ca                	mv	a1,s2
      c2:	8552                	mv	a0,s4
      c4:	72f000ef          	jal	ff2 <fmlock>
      return -1;
    }
  }

  return 0;
}
      c8:	70a2                	ld	ra,40(sp)
      ca:	7402                	ld	s0,32(sp)
      cc:	64e2                	ld	s1,24(sp)
      ce:	6942                	ld	s2,16(sp)
      d0:	69a2                	ld	s3,8(sp)
      d2:	6a02                	ld	s4,0(sp)
      d4:	6145                	addi	sp,sp,48
      d6:	8082                	ret
  if(strcmp(a, b) < 0){
      d8:	85a6                	mv	a1,s1
      da:	8552                	mv	a0,s4
      dc:	40f000ef          	jal	cea <strcmp>
      e0:	02054663          	bltz	a0,10c <lock_two+0x70>
    if(fmlock(b, mb) < 0)
      e4:	85ce                	mv	a1,s3
      e6:	8526                	mv	a0,s1
      e8:	70b000ef          	jal	ff2 <fmlock>
      ec:	04054863          	bltz	a0,13c <lock_two+0xa0>
    if(fmlock(a, ma) < 0){
      f0:	85ca                	mv	a1,s2
      f2:	8552                	mv	a0,s4
      f4:	6ff000ef          	jal	ff2 <fmlock>
      f8:	87aa                	mv	a5,a0
  return 0;
      fa:	4501                	li	a0,0
    if(fmlock(a, ma) < 0){
      fc:	fc07d6e3          	bgez	a5,c8 <lock_two+0x2c>
      fmunlock(b, mb);
     100:	85ce                	mv	a1,s3
     102:	8526                	mv	a0,s1
     104:	6f7000ef          	jal	ffa <fmunlock>
      return -1;
     108:	557d                	li	a0,-1
     10a:	bf7d                	j	c8 <lock_two+0x2c>
    if(fmlock(a, ma) < 0)
     10c:	85ca                	mv	a1,s2
     10e:	8552                	mv	a0,s4
     110:	6e3000ef          	jal	ff2 <fmlock>
     114:	02054263          	bltz	a0,138 <lock_two+0x9c>
    if(fmlock(b, mb) < 0){
     118:	85ce                	mv	a1,s3
     11a:	8526                	mv	a0,s1
     11c:	6d7000ef          	jal	ff2 <fmlock>
     120:	87aa                	mv	a5,a0
  return 0;
     122:	4501                	li	a0,0
    if(fmlock(b, mb) < 0){
     124:	fa07d2e3          	bgez	a5,c8 <lock_two+0x2c>
      fmunlock(a, ma);
     128:	85ca                	mv	a1,s2
     12a:	8552                	mv	a0,s4
     12c:	6cf000ef          	jal	ffa <fmunlock>
      return -1;
     130:	557d                	li	a0,-1
     132:	bf59                	j	c8 <lock_two+0x2c>
      return -1;
     134:	557d                	li	a0,-1
     136:	bf49                	j	c8 <lock_two+0x2c>
      return -1;
     138:	557d                	li	a0,-1
     13a:	b779                	j	c8 <lock_two+0x2c>
      return -1;
     13c:	557d                	li	a0,-1
     13e:	b769                	j	c8 <lock_two+0x2c>

0000000000000140 <unlock_two>:

static void
unlock_two(char *a, int ma, char *b, int mb)
{
     140:	7179                	addi	sp,sp,-48
     142:	f406                	sd	ra,40(sp)
     144:	f022                	sd	s0,32(sp)
     146:	ec26                	sd	s1,24(sp)
     148:	e84a                	sd	s2,16(sp)
     14a:	e44e                	sd	s3,8(sp)
     14c:	e052                	sd	s4,0(sp)
     14e:	1800                	addi	s0,sp,48
     150:	892a                	mv	s2,a0
     152:	89ae                	mv	s3,a1
     154:	84b2                	mv	s1,a2
     156:	8a36                	mv	s4,a3
  if(strcmp(a, b) == 0){
     158:	85b2                	mv	a1,a2
     15a:	391000ef          	jal	cea <strcmp>
     15e:	c10d                	beqz	a0,180 <unlock_two+0x40>
    fmunlock(a, ma);
    return;
  }
  fmunlock(a, ma);
     160:	85ce                	mv	a1,s3
     162:	854a                	mv	a0,s2
     164:	697000ef          	jal	ffa <fmunlock>
  fmunlock(b, mb);
     168:	85d2                	mv	a1,s4
     16a:	8526                	mv	a0,s1
     16c:	68f000ef          	jal	ffa <fmunlock>
}
     170:	70a2                	ld	ra,40(sp)
     172:	7402                	ld	s0,32(sp)
     174:	64e2                	ld	s1,24(sp)
     176:	6942                	ld	s2,16(sp)
     178:	69a2                	ld	s3,8(sp)
     17a:	6a02                	ld	s4,0(sp)
     17c:	6145                	addi	sp,sp,48
     17e:	8082                	ret
    fmunlock(a, ma);
     180:	85ce                	mv	a1,s3
     182:	854a                	mv	a0,s2
     184:	677000ef          	jal	ffa <fmunlock>
    return;
     188:	b7e5                	j	170 <unlock_two+0x30>

000000000000018a <log_result>:
{
     18a:	7119                	addi	sp,sp,-128
     18c:	fc86                	sd	ra,120(sp)
     18e:	f8a2                	sd	s0,112(sp)
     190:	f0ca                	sd	s2,96(sp)
     192:	ecce                	sd	s3,88(sp)
     194:	e8d2                	sd	s4,80(sp)
     196:	e4d6                	sd	s5,72(sp)
     198:	0100                	addi	s0,sp,128
     19a:	8aaa                	mv	s5,a0
     19c:	8a2e                	mv	s4,a1
     19e:	89b2                	mv	s3,a2
     1a0:	8936                	mv	s2,a3
  if(fmlock("fops.log", FM_WRITE) < 0)
     1a2:	4585                	li	a1,1
     1a4:	00001517          	auipc	a0,0x1
     1a8:	3a450513          	addi	a0,a0,932 # 1548 <malloc+0x10a>
     1ac:	647000ef          	jal	ff2 <fmlock>
     1b0:	06054a63          	bltz	a0,224 <log_result+0x9a>
     1b4:	f4a6                	sd	s1,104(sp)
  fd = open("fops.log", O_CREATE | O_RDWR);
     1b6:	20200593          	li	a1,514
     1ba:	00001517          	auipc	a0,0x1
     1be:	38e50513          	addi	a0,a0,910 # 1548 <malloc+0x10a>
     1c2:	5d1000ef          	jal	f92 <open>
     1c6:	84aa                	mv	s1,a0
  if(fd >= 0){
     1c8:	04054663          	bltz	a0,214 <log_result+0x8a>
     1cc:	e0da                	sd	s6,64(sp)
    while(read(fd, junk, sizeof(junk)) > 0)
     1ce:	04000613          	li	a2,64
     1d2:	f8040593          	addi	a1,s0,-128
     1d6:	8526                	mv	a0,s1
     1d8:	593000ef          	jal	f6a <read>
     1dc:	fea049e3          	bgtz	a0,1ce <log_result+0x44>
    fprintf(fd, "tick=%d pid=%d op=%s a=%s b=%s rc=%d\n",
     1e0:	60b000ef          	jal	fea <uptime>
     1e4:	8b2a                	mv	s6,a0
     1e6:	5ed000ef          	jal	fd2 <getpid>
     1ea:	86aa                	mv	a3,a0
     1ec:	040a0463          	beqz	s4,234 <log_result+0xaa>
     1f0:	04098763          	beqz	s3,23e <log_result+0xb4>
     1f4:	88ca                	mv	a7,s2
     1f6:	884e                	mv	a6,s3
     1f8:	87d2                	mv	a5,s4
     1fa:	8756                	mv	a4,s5
     1fc:	865a                	mv	a2,s6
     1fe:	00001597          	auipc	a1,0x1
     202:	35a58593          	addi	a1,a1,858 # 1558 <malloc+0x11a>
     206:	8526                	mv	a0,s1
     208:	158010ef          	jal	1360 <fprintf>
    close(fd);
     20c:	8526                	mv	a0,s1
     20e:	56d000ef          	jal	f7a <close>
     212:	6b06                	ld	s6,64(sp)
  fmunlock("fops.log", FM_WRITE);
     214:	4585                	li	a1,1
     216:	00001517          	auipc	a0,0x1
     21a:	33250513          	addi	a0,a0,818 # 1548 <malloc+0x10a>
     21e:	5dd000ef          	jal	ffa <fmunlock>
     222:	74a6                	ld	s1,104(sp)
}
     224:	70e6                	ld	ra,120(sp)
     226:	7446                	ld	s0,112(sp)
     228:	7906                	ld	s2,96(sp)
     22a:	69e6                	ld	s3,88(sp)
     22c:	6a46                	ld	s4,80(sp)
     22e:	6aa6                	ld	s5,72(sp)
     230:	6109                	addi	sp,sp,128
     232:	8082                	ret
    fprintf(fd, "tick=%d pid=%d op=%s a=%s b=%s rc=%d\n",
     234:	00001a17          	auipc	s4,0x1
     238:	30ca0a13          	addi	s4,s4,780 # 1540 <malloc+0x102>
     23c:	bf55                	j	1f0 <log_result+0x66>
     23e:	00001997          	auipc	s3,0x1
     242:	30298993          	addi	s3,s3,770 # 1540 <malloc+0x102>
     246:	b77d                	j	1f4 <log_result+0x6a>

0000000000000248 <main>:
  exit(0);
}

int
main(int argc, char *argv[])
{
     248:	d2010113          	addi	sp,sp,-736
     24c:	2c113c23          	sd	ra,728(sp)
     250:	2c813823          	sd	s0,720(sp)
     254:	2c913423          	sd	s1,712(sp)
     258:	2d213023          	sd	s2,704(sp)
     25c:	2b313c23          	sd	s3,696(sp)
     260:	2b413823          	sd	s4,688(sp)
     264:	2b513423          	sd	s5,680(sp)
     268:	2b613023          	sd	s6,672(sp)
     26c:	29713c23          	sd	s7,664(sp)
     270:	29813823          	sd	s8,656(sp)
     274:	1580                	addi	s0,sp,736
     276:	8a2a                	mv	s4,a0
     278:	892e                	mv	s2,a1
  memset(t, 0, sizeof(*t));
     27a:	10400613          	li	a2,260
     27e:	4581                	li	a1,0
     280:	e8040513          	addi	a0,s0,-384
     284:	2bd000ef          	jal	d40 <memset>
  if(argc < 2)
     288:	4785                	li	a5,1
     28a:	1b47dde3          	bge	a5,s4,c44 <main+0x9fc>
  if(strcmp(argv[1], "read") == 0){
     28e:	00001597          	auipc	a1,0x1
     292:	31258593          	addi	a1,a1,786 # 15a0 <malloc+0x162>
     296:	00893503          	ld	a0,8(s2)
     29a:	251000ef          	jal	cea <strcmp>
     29e:	0c051663          	bnez	a0,36a <main+0x122>
    if(argc != 3) return -1;
     2a2:	478d                	li	a5,3
     2a4:	1afa10e3          	bne	s4,a5,c44 <main+0x9fc>
    t->op = OP_READ;
     2a8:	4785                	li	a5,1
     2aa:	e8f42023          	sw	a5,-384(s0)
    copystr(t->a, argv[2], sizeof(t->a));
     2ae:	04000613          	li	a2,64
     2b2:	01093583          	ld	a1,16(s2)
     2b6:	e8440513          	addi	a0,s0,-380
     2ba:	d47ff0ef          	jal	0 <copystr>
  if(build_task_from_argv(argc, argv, &t) < 0){
    usage();
    exit(1);
  }

  for(i = 0; i < NWORKERS; i++){
     2be:	f8840493          	addi	s1,s0,-120
     2c2:	fa040993          	addi	s3,s0,-96
    for(i = 3; i < argc; i++){
     2c6:	8926                	mv	s2,s1
    if(pipe(q[i]) < 0){
     2c8:	854a                	mv	a0,s2
     2ca:	499000ef          	jal	f62 <pipe>
     2ce:	26054663          	bltz	a0,53a <main+0x2f2>
  for(i = 0; i < NWORKERS; i++){
     2d2:	0921                	addi	s2,s2,8
     2d4:	ff299ae3          	bne	s3,s2,2c8 <main+0x80>
     2d8:	29913423          	sd	s9,648(sp)
     2dc:	29a13023          	sd	s10,640(sp)
      exit(1);
    }
  }

  for(i = 0; i < NWORKERS; i++){
    if(fork() == 0){
     2e0:	46b000ef          	jal	f4a <fork>
     2e4:	892a                	mv	s2,a0
     2e6:	26050963          	beqz	a0,558 <main+0x310>
     2ea:	461000ef          	jal	f4a <fork>
     2ee:	26050463          	beqz	a0,556 <main+0x30e>
     2f2:	459000ef          	jal	f4a <fork>
     2f6:	4909                	li	s2,2
     2f8:	26050063          	beqz	a0,558 <main+0x310>
      worker(q[i][0]);
    }
  }

  for(i = 0; i < NWORKERS; i++)
    close(q[i][0]);
     2fc:	f8842503          	lw	a0,-120(s0)
     300:	47b000ef          	jal	f7a <close>
     304:	f9042503          	lw	a0,-112(s0)
     308:	473000ef          	jal	f7a <close>
     30c:	f9842503          	lw	a0,-104(s0)
     310:	46b000ef          	jal	f7a <close>
  if(write(q[0][1], task, sizeof(*task)) != sizeof(*task)){
     314:	10400613          	li	a2,260
     318:	e8040593          	addi	a1,s0,-384
     31c:	f8c42503          	lw	a0,-116(s0)
     320:	453000ef          	jal	f72 <write>
     324:	10400793          	li	a5,260
     328:	10f514e3          	bne	a0,a5,c30 <main+0x9e8>
  memset(&stop, 0, sizeof(stop));
     32c:	10400613          	li	a2,260
     330:	4581                	li	a1,0
     332:	d7840513          	addi	a0,s0,-648
     336:	20b000ef          	jal	d40 <memset>
  stop.op = OP_STOP;
     33a:	47a5                	li	a5,9
     33c:	d6f42c23          	sw	a5,-648(s0)
    write(q[i][1], &stop, sizeof(stop));
     340:	10400613          	li	a2,260
     344:	d7840593          	addi	a1,s0,-648
     348:	40c8                	lw	a0,4(s1)
     34a:	429000ef          	jal	f72 <write>
    close(q[i][1]);
     34e:	40c8                	lw	a0,4(s1)
     350:	42b000ef          	jal	f7a <close>
  for(i = 0; i < NWORKERS; i++){
     354:	04a1                	addi	s1,s1,8
     356:	fe9995e3          	bne	s3,s1,340 <main+0xf8>
  while(wait(0) > 0)
     35a:	4501                	li	a0,0
     35c:	3ff000ef          	jal	f5a <wait>
     360:	fea04de3          	bgtz	a0,35a <main+0x112>
  exit(0);
     364:	4501                	li	a0,0
     366:	3ed000ef          	jal	f52 <exit>
  if(strcmp(argv[1], "write") == 0){
     36a:	00001597          	auipc	a1,0x1
     36e:	23e58593          	addi	a1,a1,574 # 15a8 <malloc+0x16a>
     372:	00893503          	ld	a0,8(s2)
     376:	175000ef          	jal	cea <strcmp>
     37a:	e141                	bnez	a0,3fa <main+0x1b2>
    if(argc < 4) return -1;
     37c:	478d                	li	a5,3
     37e:	0d47d3e3          	bge	a5,s4,c44 <main+0x9fc>
    t->op = OP_WRITE;
     382:	4789                	li	a5,2
     384:	e8f42023          	sw	a5,-384(s0)
    copystr(t->a, argv[2], sizeof(t->a));
     388:	04000613          	li	a2,64
     38c:	01093583          	ld	a1,16(s2)
     390:	e8440513          	addi	a0,s0,-380
     394:	c6dff0ef          	jal	0 <copystr>
    t->data[0] = 0;
     398:	f0040223          	sb	zero,-252(s0)
    for(i = 3; i < argc; i++){
     39c:	0961                	addi	s2,s2,24
     39e:	498d                	li	s3,3
      if(strlen(t->data) + strlen(argv[i]) + 2 >= sizeof(t->data))
     3a0:	07f00a93          	li	s5,127
      if(i > 3)
     3a4:	4b0d                	li	s6,3
        appendstr(t->data, " ", sizeof(t->data));
     3a6:	00001b97          	auipc	s7,0x1
     3aa:	20ab8b93          	addi	s7,s7,522 # 15b0 <malloc+0x172>
     3ae:	a829                	j	3c8 <main+0x180>
      appendstr(t->data, argv[i], sizeof(t->data));
     3b0:	08000613          	li	a2,128
     3b4:	000c3583          	ld	a1,0(s8)
     3b8:	f0440513          	addi	a0,s0,-252
     3bc:	c7dff0ef          	jal	38 <appendstr>
    for(i = 3; i < argc; i++){
     3c0:	2985                	addiw	s3,s3,1
     3c2:	0921                	addi	s2,s2,8
     3c4:	ef3a0de3          	beq	s4,s3,2be <main+0x76>
      if(strlen(t->data) + strlen(argv[i]) + 2 >= sizeof(t->data))
     3c8:	f0440513          	addi	a0,s0,-252
     3cc:	14b000ef          	jal	d16 <strlen>
     3d0:	0005049b          	sext.w	s1,a0
     3d4:	8c4a                	mv	s8,s2
     3d6:	00093503          	ld	a0,0(s2)
     3da:	13d000ef          	jal	d16 <strlen>
     3de:	9ca9                	addw	s1,s1,a0
     3e0:	2489                	addiw	s1,s1,2
     3e2:	ec9aeee3          	bltu	s5,s1,2be <main+0x76>
      if(i > 3)
     3e6:	fd3b55e3          	bge	s6,s3,3b0 <main+0x168>
        appendstr(t->data, " ", sizeof(t->data));
     3ea:	08000613          	li	a2,128
     3ee:	85de                	mv	a1,s7
     3f0:	f0440513          	addi	a0,s0,-252
     3f4:	c45ff0ef          	jal	38 <appendstr>
     3f8:	bf65                	j	3b0 <main+0x168>
  if(strcmp(argv[1], "copy") == 0){
     3fa:	00001597          	auipc	a1,0x1
     3fe:	1be58593          	addi	a1,a1,446 # 15b8 <malloc+0x17a>
     402:	00893503          	ld	a0,8(s2)
     406:	0e5000ef          	jal	cea <strcmp>
     40a:	e905                	bnez	a0,43a <main+0x1f2>
    if(argc != 4) return -1;
     40c:	4791                	li	a5,4
     40e:	02fa1be3          	bne	s4,a5,c44 <main+0x9fc>
    t->op = OP_COPY;
     412:	478d                	li	a5,3
     414:	e8f42023          	sw	a5,-384(s0)
    copystr(t->a, argv[2], sizeof(t->a));
     418:	04000613          	li	a2,64
     41c:	01093583          	ld	a1,16(s2)
     420:	e8440513          	addi	a0,s0,-380
     424:	bddff0ef          	jal	0 <copystr>
    copystr(t->b, argv[3], sizeof(t->b));
     428:	04000613          	li	a2,64
     42c:	01893583          	ld	a1,24(s2)
     430:	ec440513          	addi	a0,s0,-316
     434:	bcdff0ef          	jal	0 <copystr>
    return 0;
     438:	b559                	j	2be <main+0x76>
  if(strcmp(argv[1], "rename") == 0){
     43a:	00001597          	auipc	a1,0x1
     43e:	18658593          	addi	a1,a1,390 # 15c0 <malloc+0x182>
     442:	00893503          	ld	a0,8(s2)
     446:	0a5000ef          	jal	cea <strcmp>
     44a:	e51d                	bnez	a0,478 <main+0x230>
    if(argc != 4) return -1;
     44c:	4791                	li	a5,4
     44e:	7efa1b63          	bne	s4,a5,c44 <main+0x9fc>
    t->op = OP_RENAME;
     452:	e8f42023          	sw	a5,-384(s0)
    copystr(t->a, argv[2], sizeof(t->a));
     456:	04000613          	li	a2,64
     45a:	01093583          	ld	a1,16(s2)
     45e:	e8440513          	addi	a0,s0,-380
     462:	b9fff0ef          	jal	0 <copystr>
    copystr(t->b, argv[3], sizeof(t->b));
     466:	04000613          	li	a2,64
     46a:	01893583          	ld	a1,24(s2)
     46e:	ec440513          	addi	a0,s0,-316
     472:	b8fff0ef          	jal	0 <copystr>
    return 0;
     476:	b5a1                	j	2be <main+0x76>
  if(strcmp(argv[1], "delete") == 0){
     478:	00001597          	auipc	a1,0x1
     47c:	15058593          	addi	a1,a1,336 # 15c8 <malloc+0x18a>
     480:	00893503          	ld	a0,8(s2)
     484:	067000ef          	jal	cea <strcmp>
     488:	e105                	bnez	a0,4a8 <main+0x260>
    if(argc != 3) return -1;
     48a:	478d                	li	a5,3
     48c:	7afa1c63          	bne	s4,a5,c44 <main+0x9fc>
    t->op = OP_DELETE;
     490:	4795                	li	a5,5
     492:	e8f42023          	sw	a5,-384(s0)
    copystr(t->a, argv[2], sizeof(t->a));
     496:	04000613          	li	a2,64
     49a:	01093583          	ld	a1,16(s2)
     49e:	e8440513          	addi	a0,s0,-380
     4a2:	b5fff0ef          	jal	0 <copystr>
    return 0;
     4a6:	bd21                	j	2be <main+0x76>
  if(strcmp(argv[1], "meta") == 0){
     4a8:	00001597          	auipc	a1,0x1
     4ac:	12858593          	addi	a1,a1,296 # 15d0 <malloc+0x192>
     4b0:	00893503          	ld	a0,8(s2)
     4b4:	037000ef          	jal	cea <strcmp>
     4b8:	e105                	bnez	a0,4d8 <main+0x290>
    if(argc != 3) return -1;
     4ba:	478d                	li	a5,3
     4bc:	78fa1463          	bne	s4,a5,c44 <main+0x9fc>
    t->op = OP_META;
     4c0:	4799                	li	a5,6
     4c2:	e8f42023          	sw	a5,-384(s0)
    copystr(t->a, argv[2], sizeof(t->a));
     4c6:	04000613          	li	a2,64
     4ca:	01093583          	ld	a1,16(s2)
     4ce:	e8440513          	addi	a0,s0,-380
     4d2:	b2fff0ef          	jal	0 <copystr>
    return 0;
     4d6:	b3e5                	j	2be <main+0x76>
  if(strcmp(argv[1], "compress") == 0){
     4d8:	00001597          	auipc	a1,0x1
     4dc:	10058593          	addi	a1,a1,256 # 15d8 <malloc+0x19a>
     4e0:	00893503          	ld	a0,8(s2)
     4e4:	007000ef          	jal	cea <strcmp>
     4e8:	e105                	bnez	a0,508 <main+0x2c0>
    if(argc != 3) return -1;
     4ea:	478d                	li	a5,3
     4ec:	74fa1c63          	bne	s4,a5,c44 <main+0x9fc>
    t->op = OP_COMPRESS;
     4f0:	479d                	li	a5,7
     4f2:	e8f42023          	sw	a5,-384(s0)
    copystr(t->a, argv[2], sizeof(t->a));
     4f6:	04000613          	li	a2,64
     4fa:	01093583          	ld	a1,16(s2)
     4fe:	e8440513          	addi	a0,s0,-380
     502:	affff0ef          	jal	0 <copystr>
    return 0;
     506:	bb65                	j	2be <main+0x76>
  if(strcmp(argv[1], "decompress") == 0){
     508:	00001597          	auipc	a1,0x1
     50c:	0e058593          	addi	a1,a1,224 # 15e8 <malloc+0x1aa>
     510:	00893503          	ld	a0,8(s2)
     514:	7d6000ef          	jal	cea <strcmp>
     518:	72051663          	bnez	a0,c44 <main+0x9fc>
    if(argc != 3) return -1;
     51c:	478d                	li	a5,3
     51e:	72fa1363          	bne	s4,a5,c44 <main+0x9fc>
    t->op = OP_DECOMPRESS;
     522:	47a1                	li	a5,8
     524:	e8f42023          	sw	a5,-384(s0)
    copystr(t->a, argv[2], sizeof(t->a));
     528:	04000613          	li	a2,64
     52c:	01093583          	ld	a1,16(s2)
     530:	e8440513          	addi	a0,s0,-380
     534:	acdff0ef          	jal	0 <copystr>
    return 0;
     538:	b359                	j	2be <main+0x76>
     53a:	29913423          	sd	s9,648(sp)
     53e:	29a13023          	sd	s10,640(sp)
      fprintf(2, "pipe failed\n");
     542:	00001597          	auipc	a1,0x1
     546:	0b658593          	addi	a1,a1,182 # 15f8 <malloc+0x1ba>
     54a:	4509                	li	a0,2
     54c:	615000ef          	jal	1360 <fprintf>
      exit(1);
     550:	4505                	li	a0,1
     552:	201000ef          	jal	f52 <exit>
  for(i = 0; i < NWORKERS; i++){
     556:	4905                	li	s2,1
      for(j = 0; j < NWORKERS; j++){
     558:	4981                	li	s3,0
     55a:	4a0d                	li	s4,3
     55c:	a029                	j	566 <main+0x31e>
     55e:	2985                	addiw	s3,s3,1
     560:	04a1                	addi	s1,s1,8
     562:	01498b63          	beq	s3,s4,578 <main+0x330>
        close(q[j][1]);
     566:	40c8                	lw	a0,4(s1)
     568:	213000ef          	jal	f7a <close>
        if(j != i)
     56c:	ff2989e3          	beq	s3,s2,55e <main+0x316>
          close(q[j][0]);
     570:	4088                	lw	a0,0(s1)
     572:	209000ef          	jal	f7a <close>
     576:	b7e5                	j	55e <main+0x316>
      worker(q[i][0]);
     578:	090e                	slli	s2,s2,0x3
     57a:	fa090793          	addi	a5,s2,-96
     57e:	00878933          	add	s2,a5,s0
     582:	fe892903          	lw	s2,-24(s2)
    if(t.op == OP_STOP)
     586:	49a5                	li	s3,9
     588:	4a21                	li	s4,8
    printf("[%d] operation failed\n", getpid());
     58a:	00001a97          	auipc	s5,0x1
     58e:	0cea8a93          	addi	s5,s5,206 # 1658 <malloc+0x21a>
     592:	00001497          	auipc	s1,0x1
     596:	1e648493          	addi	s1,s1,486 # 1778 <malloc+0x33a>
  while(read(rfd, &t, sizeof(t)) == sizeof(t)){
     59a:	a045                	j	63a <main+0x3f2>
  if(fmlock(t->a, FM_READ) < 0)
     59c:	4581                	li	a1,0
     59e:	d7c40513          	addi	a0,s0,-644
     5a2:	251000ef          	jal	ff2 <fmlock>
     5a6:	0c054063          	bltz	a0,666 <main+0x41e>
  fd = open(t->a, O_RDONLY);
     5aa:	4581                	li	a1,0
     5ac:	d7c40513          	addi	a0,s0,-644
     5b0:	1e3000ef          	jal	f92 <open>
     5b4:	8baa                	mv	s7,a0
  int fd, n, rc = -1;
     5b6:	5b7d                	li	s6,-1
  if(fd < 0)
     5b8:	04054763          	bltz	a0,606 <main+0x3be>
  printf("\n[%d] read %s:\n", getpid(), t->a);
     5bc:	217000ef          	jal	fd2 <getpid>
     5c0:	85aa                	mv	a1,a0
     5c2:	d7c40613          	addi	a2,s0,-644
     5c6:	00001517          	auipc	a0,0x1
     5ca:	04250513          	addi	a0,a0,66 # 1608 <malloc+0x1ca>
     5ce:	5bd000ef          	jal	138a <printf>
  while((n = read(fd, buf, sizeof(buf))) > 0)
     5d2:	a031                	j	5de <main+0x396>
    write(1, buf, n);
     5d4:	d3840593          	addi	a1,s0,-712
     5d8:	4505                	li	a0,1
     5da:	199000ef          	jal	f72 <write>
  while((n = read(fd, buf, sizeof(buf))) > 0)
     5de:	04000613          	li	a2,64
     5e2:	d3840593          	addi	a1,s0,-712
     5e6:	855e                	mv	a0,s7
     5e8:	183000ef          	jal	f6a <read>
     5ec:	862a                	mv	a2,a0
     5ee:	fea043e3          	bgtz	a0,5d4 <main+0x38c>
  printf("\n");
     5f2:	00001517          	auipc	a0,0x1
     5f6:	02650513          	addi	a0,a0,38 # 1618 <malloc+0x1da>
     5fa:	591000ef          	jal	138a <printf>
  close(fd);
     5fe:	855e                	mv	a0,s7
     600:	17b000ef          	jal	f7a <close>
  rc = 0;
     604:	4b01                	li	s6,0
  fmunlock(t->a, FM_READ);
     606:	4581                	li	a1,0
     608:	d7c40513          	addi	a0,s0,-644
     60c:	1ef000ef          	jal	ffa <fmunlock>
  log_result("read", t->a, "", rc);
     610:	86da                	mv	a3,s6
     612:	00001617          	auipc	a2,0x1
     616:	0ce60613          	addi	a2,a2,206 # 16e0 <malloc+0x2a2>
     61a:	d7c40593          	addi	a1,s0,-644
     61e:	00001517          	auipc	a0,0x1
     622:	f8250513          	addi	a0,a0,-126 # 15a0 <malloc+0x162>
     626:	b65ff0ef          	jal	18a <log_result>
  if(rc < 0)
     62a:	000b5863          	bgez	s6,63a <main+0x3f2>
    printf("[%d] operation failed\n", getpid());
     62e:	1a5000ef          	jal	fd2 <getpid>
     632:	85aa                	mv	a1,a0
     634:	8556                	mv	a0,s5
     636:	555000ef          	jal	138a <printf>
  while(read(rfd, &t, sizeof(t)) == sizeof(t)){
     63a:	10400613          	li	a2,260
     63e:	d7840593          	addi	a1,s0,-648
     642:	854a                	mv	a0,s2
     644:	127000ef          	jal	f6a <read>
     648:	10400793          	li	a5,260
     64c:	5cf51c63          	bne	a0,a5,c24 <main+0x9dc>
    if(t.op == OP_STOP)
     650:	d7842783          	lw	a5,-648(s0)
     654:	5d378863          	beq	a5,s3,c24 <main+0x9dc>
  if(t->op == OP_READ)           rc = op_read(t);
     658:	fcfa6be3          	bltu	s4,a5,62e <main+0x3e6>
     65c:	078a                	slli	a5,a5,0x2
     65e:	97a6                	add	a5,a5,s1
     660:	439c                	lw	a5,0(a5)
     662:	97a6                	add	a5,a5,s1
     664:	8782                	jr	a5
  int fd, n, rc = -1;
     666:	5b7d                	li	s6,-1
     668:	b765                	j	610 <main+0x3c8>
  if(fmlock(t->a, FM_WRITE) < 0)
     66a:	4585                	li	a1,1
     66c:	d7c40513          	addi	a0,s0,-644
     670:	183000ef          	jal	ff2 <fmlock>
     674:	08054763          	bltz	a0,702 <main+0x4ba>
  unlink(t->a);
     678:	d7c40513          	addi	a0,s0,-644
     67c:	127000ef          	jal	fa2 <unlink>
  fd = open(t->a, O_CREATE | O_WRONLY);
     680:	20100593          	li	a1,513
     684:	d7c40513          	addi	a0,s0,-644
     688:	10b000ef          	jal	f92 <open>
     68c:	8baa                	mv	s7,a0
  int fd, rc = -1;
     68e:	5b7d                	li	s6,-1
  if(fd < 0)
     690:	02054c63          	bltz	a0,6c8 <main+0x480>
  if(write(fd, t->data, strlen(t->data)) != strlen(t->data))
     694:	dfc40513          	addi	a0,s0,-516
     698:	67e000ef          	jal	d16 <strlen>
     69c:	0005061b          	sext.w	a2,a0
     6a0:	dfc40593          	addi	a1,s0,-516
     6a4:	855e                	mv	a0,s7
     6a6:	0cd000ef          	jal	f72 <write>
     6aa:	8b2a                	mv	s6,a0
     6ac:	dfc40513          	addi	a0,s0,-516
     6b0:	666000ef          	jal	d16 <strlen>
     6b4:	0005071b          	sext.w	a4,a0
     6b8:	000b079b          	sext.w	a5,s6
  int fd, rc = -1;
     6bc:	5b7d                	li	s6,-1
  if(write(fd, t->data, strlen(t->data)) != strlen(t->data))
     6be:	02e78863          	beq	a5,a4,6ee <main+0x4a6>
  close(fd);
     6c2:	855e                	mv	a0,s7
     6c4:	0b7000ef          	jal	f7a <close>
  fmunlock(t->a, FM_WRITE);
     6c8:	4585                	li	a1,1
     6ca:	d7c40513          	addi	a0,s0,-644
     6ce:	12d000ef          	jal	ffa <fmunlock>
  log_result("write", t->a, "", rc);
     6d2:	86da                	mv	a3,s6
     6d4:	00001617          	auipc	a2,0x1
     6d8:	00c60613          	addi	a2,a2,12 # 16e0 <malloc+0x2a2>
     6dc:	d7c40593          	addi	a1,s0,-644
     6e0:	00001517          	auipc	a0,0x1
     6e4:	ec850513          	addi	a0,a0,-312 # 15a8 <malloc+0x16a>
     6e8:	aa3ff0ef          	jal	18a <log_result>
  return rc;
     6ec:	bf3d                	j	62a <main+0x3e2>
  write(fd, "\n", 1);
     6ee:	4605                	li	a2,1
     6f0:	00001597          	auipc	a1,0x1
     6f4:	f2858593          	addi	a1,a1,-216 # 1618 <malloc+0x1da>
     6f8:	855e                	mv	a0,s7
     6fa:	079000ef          	jal	f72 <write>
  rc = 0;
     6fe:	4b01                	li	s6,0
     700:	b7c9                	j	6c2 <main+0x47a>
  int fd, rc = -1;
     702:	5b7d                	li	s6,-1
     704:	b7f9                	j	6d2 <main+0x48a>
  if(strcmp(t->a, t->b) == 0)
     706:	dbc40593          	addi	a1,s0,-580
     70a:	d7c40513          	addi	a0,s0,-644
     70e:	5dc000ef          	jal	cea <strcmp>
     712:	c155                	beqz	a0,7b6 <main+0x56e>
  if(lock_two(t->a, FM_READ, t->b, FM_WRITE) < 0)
     714:	4685                	li	a3,1
     716:	dbc40613          	addi	a2,s0,-580
     71a:	4581                	li	a1,0
     71c:	d7c40513          	addi	a0,s0,-644
     720:	97dff0ef          	jal	9c <lock_two>
     724:	08054b63          	bltz	a0,7ba <main+0x572>
  sfd = open(t->a, O_RDONLY);
     728:	4581                	li	a1,0
     72a:	d7c40513          	addi	a0,s0,-644
     72e:	065000ef          	jal	f92 <open>
     732:	8baa                	mv	s7,a0
  int sfd = -1, dfd = -1, n, rc = -1;
     734:	5b7d                	li	s6,-1
  if(sfd < 0)
     736:	04054a63          	bltz	a0,78a <main+0x542>
  unlink(t->b);
     73a:	dbc40513          	addi	a0,s0,-580
     73e:	065000ef          	jal	fa2 <unlink>
  dfd = open(t->b, O_CREATE | O_WRONLY);
     742:	20100593          	li	a1,513
     746:	dbc40513          	addi	a0,s0,-580
     74a:	049000ef          	jal	f92 <open>
     74e:	8c2a                	mv	s8,a0
  if(dfd < 0)
     750:	06054163          	bltz	a0,7b2 <main+0x56a>
  while((n = read(sfd, buf, sizeof(buf))) > 0){
     754:	04000613          	li	a2,64
     758:	d3840593          	addi	a1,s0,-712
     75c:	855e                	mv	a0,s7
     75e:	00d000ef          	jal	f6a <read>
     762:	8b2a                	mv	s6,a0
     764:	00a05c63          	blez	a0,77c <main+0x534>
    if(write(dfd, buf, n) != n)
     768:	865a                	mv	a2,s6
     76a:	d3840593          	addi	a1,s0,-712
     76e:	8562                	mv	a0,s8
     770:	003000ef          	jal	f72 <write>
     774:	feab00e3          	beq	s6,a0,754 <main+0x50c>
  int sfd = -1, dfd = -1, n, rc = -1;
     778:	5b7d                	li	s6,-1
     77a:	a011                	j	77e <main+0x536>
  rc = 0;
     77c:	4b01                	li	s6,0
  close(dfd);
     77e:	8562                	mv	a0,s8
     780:	7fa000ef          	jal	f7a <close>
  close(sfd);
     784:	855e                	mv	a0,s7
     786:	7f4000ef          	jal	f7a <close>
  unlock_two(t->a, FM_READ, t->b, FM_WRITE);
     78a:	4685                	li	a3,1
     78c:	dbc40613          	addi	a2,s0,-580
     790:	4581                	li	a1,0
     792:	d7c40513          	addi	a0,s0,-644
     796:	9abff0ef          	jal	140 <unlock_two>
  log_result("copy", t->a, t->b, rc);
     79a:	86da                	mv	a3,s6
     79c:	dbc40613          	addi	a2,s0,-580
     7a0:	d7c40593          	addi	a1,s0,-644
     7a4:	00001517          	auipc	a0,0x1
     7a8:	e1450513          	addi	a0,a0,-492 # 15b8 <malloc+0x17a>
     7ac:	9dfff0ef          	jal	18a <log_result>
  return rc;
     7b0:	bdad                	j	62a <main+0x3e2>
  int sfd = -1, dfd = -1, n, rc = -1;
     7b2:	5b7d                	li	s6,-1
     7b4:	bfc1                	j	784 <main+0x53c>
     7b6:	5b7d                	li	s6,-1
     7b8:	b7cd                	j	79a <main+0x552>
     7ba:	5b7d                	li	s6,-1
     7bc:	bff9                	j	79a <main+0x552>
  if(strcmp(t->a, t->b) == 0)
     7be:	dbc40593          	addi	a1,s0,-580
     7c2:	d7c40513          	addi	a0,s0,-644
     7c6:	524000ef          	jal	cea <strcmp>
     7ca:	e60508e3          	beqz	a0,63a <main+0x3f2>
  if(lock_two(t->a, FM_WRITE, t->b, FM_WRITE) < 0)
     7ce:	4685                	li	a3,1
     7d0:	dbc40613          	addi	a2,s0,-580
     7d4:	4585                	li	a1,1
     7d6:	d7c40513          	addi	a0,s0,-644
     7da:	8c3ff0ef          	jal	9c <lock_two>
  int rc = -1;
     7de:	5b7d                	li	s6,-1
  if(lock_two(t->a, FM_WRITE, t->b, FM_WRITE) < 0)
     7e0:	02054963          	bltz	a0,812 <main+0x5ca>
  if(link(t->a, t->b) < 0)
     7e4:	dbc40593          	addi	a1,s0,-580
     7e8:	d7c40513          	addi	a0,s0,-644
     7ec:	7c6000ef          	jal	fb2 <link>
     7f0:	00054963          	bltz	a0,802 <main+0x5ba>
  if(unlink(t->a) < 0){
     7f4:	d7c40513          	addi	a0,s0,-644
     7f8:	7aa000ef          	jal	fa2 <unlink>
  rc = 0;
     7fc:	4b01                	li	s6,0
  if(unlink(t->a) < 0){
     7fe:	02054663          	bltz	a0,82a <main+0x5e2>
  unlock_two(t->a, FM_WRITE, t->b, FM_WRITE);
     802:	4685                	li	a3,1
     804:	dbc40613          	addi	a2,s0,-580
     808:	4585                	li	a1,1
     80a:	d7c40513          	addi	a0,s0,-644
     80e:	933ff0ef          	jal	140 <unlock_two>
  log_result("rename", t->a, t->b, rc);
     812:	86da                	mv	a3,s6
     814:	dbc40613          	addi	a2,s0,-580
     818:	d7c40593          	addi	a1,s0,-644
     81c:	00001517          	auipc	a0,0x1
     820:	da450513          	addi	a0,a0,-604 # 15c0 <malloc+0x182>
     824:	967ff0ef          	jal	18a <log_result>
  return rc;
     828:	b509                	j	62a <main+0x3e2>
    unlink(t->b);
     82a:	dbc40513          	addi	a0,s0,-580
     82e:	774000ef          	jal	fa2 <unlink>
  int rc = -1;
     832:	5b7d                	li	s6,-1
    goto out_unlock;
     834:	b7f9                	j	802 <main+0x5ba>
  if(fmlock(t->a, FM_WRITE) < 0)
     836:	4585                	li	a1,1
     838:	d7c40513          	addi	a0,s0,-644
     83c:	7b6000ef          	jal	ff2 <fmlock>
     840:	02054b63          	bltz	a0,876 <main+0x62e>
  if(unlink(t->a) < 0)
     844:	d7c40513          	addi	a0,s0,-644
     848:	75a000ef          	jal	fa2 <unlink>
     84c:	41f55b1b          	sraiw	s6,a0,0x1f
  fmunlock(t->a, FM_WRITE);
     850:	4585                	li	a1,1
     852:	d7c40513          	addi	a0,s0,-644
     856:	7a4000ef          	jal	ffa <fmunlock>
  log_result("delete", t->a, "", rc);
     85a:	86da                	mv	a3,s6
     85c:	00001617          	auipc	a2,0x1
     860:	e8460613          	addi	a2,a2,-380 # 16e0 <malloc+0x2a2>
     864:	d7c40593          	addi	a1,s0,-644
     868:	00001517          	auipc	a0,0x1
     86c:	d6050513          	addi	a0,a0,-672 # 15c8 <malloc+0x18a>
     870:	91bff0ef          	jal	18a <log_result>
  return rc;
     874:	bb5d                	j	62a <main+0x3e2>
  int rc = -1;
     876:	5b7d                	li	s6,-1
     878:	b7cd                	j	85a <main+0x612>
  if(fmlock(t->a, FM_READ) < 0)
     87a:	4581                	li	a1,0
     87c:	d7c40513          	addi	a0,s0,-644
     880:	772000ef          	jal	ff2 <fmlock>
     884:	0a054763          	bltz	a0,932 <main+0x6ea>
  fd = open(t->a, O_RDONLY);
     888:	4581                	li	a1,0
     88a:	d7c40513          	addi	a0,s0,-644
     88e:	704000ef          	jal	f92 <open>
     892:	8baa                	mv	s7,a0
  int fd, rc = -1;
     894:	5b7d                	li	s6,-1
  if(fd < 0)
     896:	04054c63          	bltz	a0,8ee <main+0x6a6>
  if(fstat(fd, &st) < 0)
     89a:	d3840593          	addi	a1,s0,-712
     89e:	70c000ef          	jal	faa <fstat>
     8a2:	04054363          	bltz	a0,8e8 <main+0x6a0>
  printf("[%d] meta %s: type=%s ino=%d nlink=%d size=%d\n",
     8a6:	72c000ef          	jal	fd2 <getpid>
     8aa:	85aa                	mv	a1,a0
     8ac:	d4041783          	lh	a5,-704(s0)
  if(type == T_DIR)    return "DIR";
     8b0:	4705                	li	a4,1
     8b2:	06e78163          	beq	a5,a4,914 <main+0x6cc>
  if(type == T_FILE)   return "FILE";
     8b6:	4709                	li	a4,2
     8b8:	06e78363          	beq	a5,a4,91e <main+0x6d6>
  if(type == T_DEVICE) return "DEVICE";
     8bc:	470d                	li	a4,3
     8be:	06e78563          	beq	a5,a4,928 <main+0x6e0>
  return "UNKNOWN";
     8c2:	00001697          	auipc	a3,0x1
     8c6:	cce68693          	addi	a3,a3,-818 # 1590 <malloc+0x152>
  printf("[%d] meta %s: type=%s ino=%d nlink=%d size=%d\n",
     8ca:	d4842803          	lw	a6,-696(s0)
     8ce:	d4241783          	lh	a5,-702(s0)
     8d2:	d3c42703          	lw	a4,-708(s0)
     8d6:	d7c40613          	addi	a2,s0,-644
     8da:	00001517          	auipc	a0,0x1
     8de:	d4650513          	addi	a0,a0,-698 # 1620 <malloc+0x1e2>
     8e2:	2a9000ef          	jal	138a <printf>
  rc = 0;
     8e6:	4b01                	li	s6,0
  close(fd);
     8e8:	855e                	mv	a0,s7
     8ea:	690000ef          	jal	f7a <close>
  fmunlock(t->a, FM_READ);
     8ee:	4581                	li	a1,0
     8f0:	d7c40513          	addi	a0,s0,-644
     8f4:	706000ef          	jal	ffa <fmunlock>
  log_result("meta", t->a, "", rc);
     8f8:	86da                	mv	a3,s6
     8fa:	00001617          	auipc	a2,0x1
     8fe:	de660613          	addi	a2,a2,-538 # 16e0 <malloc+0x2a2>
     902:	d7c40593          	addi	a1,s0,-644
     906:	00001517          	auipc	a0,0x1
     90a:	cca50513          	addi	a0,a0,-822 # 15d0 <malloc+0x192>
     90e:	87dff0ef          	jal	18a <log_result>
  return rc;
     912:	bb21                	j	62a <main+0x3e2>
  if(type == T_DIR)    return "DIR";
     914:	00001697          	auipc	a3,0x1
     918:	c6c68693          	addi	a3,a3,-916 # 1580 <malloc+0x142>
     91c:	b77d                	j	8ca <main+0x682>
  if(type == T_FILE)   return "FILE";
     91e:	00001697          	auipc	a3,0x1
     922:	c6a68693          	addi	a3,a3,-918 # 1588 <malloc+0x14a>
     926:	b755                	j	8ca <main+0x682>
  if(type == T_DEVICE) return "DEVICE";
     928:	00001697          	auipc	a3,0x1
     92c:	c7068693          	addi	a3,a3,-912 # 1598 <malloc+0x15a>
     930:	bf69                	j	8ca <main+0x682>
  int fd, rc = -1;
     932:	5b7d                	li	s6,-1
     934:	b7d1                	j	8f8 <main+0x6b0>
  int n = strlen(src);
     936:	d7c40513          	addi	a0,s0,-644
     93a:	3dc000ef          	jal	d16 <strlen>
     93e:	00050b1b          	sext.w	s6,a0
  if(n + 4 >= MAXNAME)
     942:	03b00793          	li	a5,59
     946:	1567cc63          	blt	a5,s6,a9e <main+0x856>
  copystr(dst, src, MAXNAME);
     94a:	04000613          	li	a2,64
     94e:	d7c40593          	addi	a1,s0,-644
     952:	d3840513          	addi	a0,s0,-712
     956:	eaaff0ef          	jal	0 <copystr>
  dst[n]   = '.';
     95a:	fa0b0793          	addi	a5,s6,-96
     95e:	97a2                	add	a5,a5,s0
     960:	02e00713          	li	a4,46
     964:	d8e78c23          	sb	a4,-616(a5)
  dst[n+1] = 'r';
     968:	07200713          	li	a4,114
     96c:	d8e78ca3          	sb	a4,-615(a5)
  dst[n+2] = 'l';
     970:	06c00713          	li	a4,108
     974:	d8e78d23          	sb	a4,-614(a5)
  dst[n+3] = 'e';
     978:	06500713          	li	a4,101
     97c:	d8e78da3          	sb	a4,-613(a5)
  dst[n+4] = 0;
     980:	d8078e23          	sb	zero,-612(a5)
  if(strcmp(t->a, dst) == 0)
     984:	d3840593          	addi	a1,s0,-712
     988:	d7c40513          	addi	a0,s0,-644
     98c:	35e000ef          	jal	cea <strcmp>
     990:	10050963          	beqz	a0,aa2 <main+0x85a>
  if(lock_two(t->a, FM_READ, dst, FM_WRITE) < 0)
     994:	4685                	li	a3,1
     996:	d3840613          	addi	a2,s0,-712
     99a:	4581                	li	a1,0
     99c:	d7c40513          	addi	a0,s0,-644
     9a0:	efcff0ef          	jal	9c <lock_two>
     9a4:	10054163          	bltz	a0,aa6 <main+0x85e>
  sfd = open(t->a, O_RDONLY);
     9a8:	4581                	li	a1,0
     9aa:	d7c40513          	addi	a0,s0,-644
     9ae:	5e4000ef          	jal	f92 <open>
     9b2:	8baa                	mv	s7,a0
  int sfd = -1, dfd = -1, n, rc = -1, count;
     9b4:	5b7d                	li	s6,-1
  if(sfd < 0)
     9b6:	0a054c63          	bltz	a0,a6e <main+0x826>
  unlink(dst);
     9ba:	d3840513          	addi	a0,s0,-712
     9be:	5e4000ef          	jal	fa2 <unlink>
  dfd = open(dst, O_CREATE | O_WRONLY);
     9c2:	20100593          	li	a1,513
     9c6:	d3840513          	addi	a0,s0,-712
     9ca:	5c8000ef          	jal	f92 <open>
     9ce:	8caa                	mv	s9,a0
  if(dfd < 0)
     9d0:	08054c63          	bltz	a0,a68 <main+0x820>
  n = read(sfd, &prev, 1);
     9d4:	4605                	li	a2,1
     9d6:	d2e40593          	addi	a1,s0,-722
     9da:	855e                	mv	a0,s7
     9dc:	58e000ef          	jal	f6a <read>
     9e0:	8b2a                	mv	s6,a0
  if(n < 0)
     9e2:	0a054a63          	bltz	a0,a96 <main+0x84e>
  if(n == 0){
     9e6:	cd35                	beqz	a0,a62 <main+0x81a>
  count = 1;
     9e8:	4c05                	li	s8,1
    if(cur == prev && count < 255){
     9ea:	0fe00d13          	li	s10,254
     9ee:	a01d                	j	a14 <main+0x7cc>
      pair[0] = (unsigned char)count;
     9f0:	d3840823          	sb	s8,-720(s0)
      pair[1] = prev;
     9f4:	d2f408a3          	sb	a5,-719(s0)
      if(write(dfd, pair, 2) != 2)
     9f8:	4609                	li	a2,2
     9fa:	d3040593          	addi	a1,s0,-720
     9fe:	8566                	mv	a0,s9
     a00:	572000ef          	jal	f72 <write>
     a04:	4789                	li	a5,2
     a06:	08f51a63          	bne	a0,a5,a9a <main+0x852>
      prev = cur;
     a0a:	d2f44783          	lbu	a5,-721(s0)
     a0e:	d2f40723          	sb	a5,-722(s0)
  int fd, rc = -1;
     a12:	8c5a                	mv	s8,s6
  while((n = read(sfd, &cur, 1)) == 1){
     a14:	4605                	li	a2,1
     a16:	d2f40593          	addi	a1,s0,-721
     a1a:	855e                	mv	a0,s7
     a1c:	54e000ef          	jal	f6a <read>
     a20:	8b2a                	mv	s6,a0
     a22:	4785                	li	a5,1
     a24:	00f51d63          	bne	a0,a5,a3e <main+0x7f6>
    if(cur == prev && count < 255){
     a28:	d2e44783          	lbu	a5,-722(s0)
     a2c:	d2f44703          	lbu	a4,-721(s0)
     a30:	fcf710e3          	bne	a4,a5,9f0 <main+0x7a8>
     a34:	fb8d4ee3          	blt	s10,s8,9f0 <main+0x7a8>
      count++;
     a38:	001c0b1b          	addiw	s6,s8,1
     a3c:	bfd9                	j	a12 <main+0x7ca>
  pair[0] = (unsigned char)count;
     a3e:	d3840823          	sb	s8,-720(s0)
  pair[1] = prev;
     a42:	d2e44783          	lbu	a5,-722(s0)
     a46:	d2f408a3          	sb	a5,-719(s0)
  if(write(dfd, pair, 2) != 2)
     a4a:	4609                	li	a2,2
     a4c:	d3040593          	addi	a1,s0,-720
     a50:	8566                	mv	a0,s9
     a52:	520000ef          	jal	f72 <write>
     a56:	ffe50b13          	addi	s6,a0,-2
     a5a:	01603b33          	snez	s6,s6
     a5e:	41600b33          	neg	s6,s6
  close(dfd);
     a62:	8566                	mv	a0,s9
     a64:	516000ef          	jal	f7a <close>
  close(sfd);
     a68:	855e                	mv	a0,s7
     a6a:	510000ef          	jal	f7a <close>
  unlock_two(t->a, FM_READ, dst, FM_WRITE);
     a6e:	4685                	li	a3,1
     a70:	d3840613          	addi	a2,s0,-712
     a74:	4581                	li	a1,0
     a76:	d7c40513          	addi	a0,s0,-644
     a7a:	ec6ff0ef          	jal	140 <unlock_two>
  log_result("compress", t->a, dst, rc);
     a7e:	86da                	mv	a3,s6
     a80:	d3840613          	addi	a2,s0,-712
     a84:	d7c40593          	addi	a1,s0,-644
     a88:	00001517          	auipc	a0,0x1
     a8c:	b5050513          	addi	a0,a0,-1200 # 15d8 <malloc+0x19a>
     a90:	efaff0ef          	jal	18a <log_result>
  return rc;
     a94:	be59                	j	62a <main+0x3e2>
  int sfd = -1, dfd = -1, n, rc = -1, count;
     a96:	5b7d                	li	s6,-1
     a98:	b7e9                	j	a62 <main+0x81a>
     a9a:	5b7d                	li	s6,-1
     a9c:	b7d9                	j	a62 <main+0x81a>
     a9e:	5b7d                	li	s6,-1
     aa0:	bff9                	j	a7e <main+0x836>
     aa2:	5b7d                	li	s6,-1
     aa4:	bfe9                	j	a7e <main+0x836>
     aa6:	5b7d                	li	s6,-1
     aa8:	bfd9                	j	a7e <main+0x836>
  int n = strlen(src);
     aaa:	d7c40513          	addi	a0,s0,-644
     aae:	268000ef          	jal	d16 <strlen>
     ab2:	00050c1b          	sext.w	s8,a0
     ab6:	8b62                	mv	s6,s8
  int n = strlen(s);
     ab8:	d7c40513          	addi	a0,s0,-644
     abc:	25a000ef          	jal	d16 <strlen>
     ac0:	00050b9b          	sext.w	s7,a0
  int m = strlen(suffix);
     ac4:	00001517          	auipc	a0,0x1
     ac8:	b8c50513          	addi	a0,a0,-1140 # 1650 <malloc+0x212>
     acc:	24a000ef          	jal	d16 <strlen>
     ad0:	2501                	sext.w	a0,a0
  if(m > n)
     ad2:	0aabd863          	bge	s7,a0,b82 <main+0x93a>
  if(n + 4 >= MAXNAME)
     ad6:	03b00793          	li	a5,59
     ada:	1767c363          	blt	a5,s6,c40 <main+0x9f8>
  copystr(dst, src, MAXNAME);
     ade:	04000613          	li	a2,64
     ae2:	d7c40593          	addi	a1,s0,-644
     ae6:	d3840513          	addi	a0,s0,-712
     aea:	d16ff0ef          	jal	0 <copystr>
  dst[n]   = '.';
     aee:	fa0b0793          	addi	a5,s6,-96
     af2:	00878b33          	add	s6,a5,s0
     af6:	02e00793          	li	a5,46
     afa:	d8fb0c23          	sb	a5,-616(s6)
  dst[n+1] = 'o';
     afe:	06f00793          	li	a5,111
     b02:	d8fb0ca3          	sb	a5,-615(s6)
  dst[n+2] = 'u';
     b06:	07500793          	li	a5,117
     b0a:	d8fb0d23          	sb	a5,-614(s6)
  dst[n+3] = 't';
     b0e:	07400793          	li	a5,116
     b12:	d8fb0da3          	sb	a5,-613(s6)
  dst[n+4] = 0;
     b16:	d80b0e23          	sb	zero,-612(s6)
  if(strcmp(t->a, dst) == 0)
     b1a:	d3840593          	addi	a1,s0,-712
     b1e:	d7c40513          	addi	a0,s0,-644
     b22:	1c8000ef          	jal	cea <strcmp>
     b26:	0e050d63          	beqz	a0,c20 <main+0x9d8>
  if(lock_two(t->a, FM_READ, dst, FM_WRITE) < 0)
     b2a:	4685                	li	a3,1
     b2c:	d3840613          	addi	a2,s0,-712
     b30:	4581                	li	a1,0
     b32:	d7c40513          	addi	a0,s0,-644
     b36:	d66ff0ef          	jal	9c <lock_two>
     b3a:	0e054163          	bltz	a0,c1c <main+0x9d4>
  sfd = open(t->a, O_RDONLY);
     b3e:	4581                	li	a1,0
     b40:	d7c40513          	addi	a0,s0,-644
     b44:	44e000ef          	jal	f92 <open>
     b48:	8c2a                	mv	s8,a0
  int sfd = -1, dfd = -1, i, rc = -1;
     b4a:	5b7d                	li	s6,-1
  if(sfd < 0)
     b4c:	0a054063          	bltz	a0,bec <main+0x9a4>
  unlink(dst);
     b50:	d3840513          	addi	a0,s0,-712
     b54:	44e000ef          	jal	fa2 <unlink>
  dfd = open(dst, O_CREATE | O_WRONLY);
     b58:	20100593          	li	a1,513
     b5c:	d3840513          	addi	a0,s0,-712
     b60:	432000ef          	jal	f92 <open>
     b64:	8baa                	mv	s7,a0
  if(dfd < 0)
     b66:	0a054963          	bltz	a0,c18 <main+0x9d0>
    for(i = 0; i < pair[0]; i++){
     b6a:	4c81                	li	s9,0
  while(read(sfd, pair, 2) == 2){
     b6c:	4609                	li	a2,2
     b6e:	d3040593          	addi	a1,s0,-720
     b72:	8562                	mv	a0,s8
     b74:	3f6000ef          	jal	f6a <read>
     b78:	4789                	li	a5,2
     b7a:	08f51d63          	bne	a0,a5,c14 <main+0x9cc>
    for(i = 0; i < pair[0]; i++){
     b7e:	8b66                	mv	s6,s9
     b80:	a091                	j	bc4 <main+0x97c>
  return strcmp(s + n - m, suffix) == 0;
     b82:	40ab8533          	sub	a0,s7,a0
     b86:	00001597          	auipc	a1,0x1
     b8a:	aca58593          	addi	a1,a1,-1334 # 1650 <malloc+0x212>
     b8e:	d7c40793          	addi	a5,s0,-644
     b92:	953e                	add	a0,a0,a5
     b94:	156000ef          	jal	cea <strcmp>
  if(endswith(src, ".rle")){
     b98:	fd1d                	bnez	a0,ad6 <main+0x88e>
    if(n - 4 <= 0 || n - 4 >= MAXNAME)
     b9a:	3c6d                	addiw	s8,s8,-5
     b9c:	03e00793          	li	a5,62
     ba0:	0b87e063          	bltu	a5,s8,c40 <main+0x9f8>
    memmove(dst, src, n - 4);
     ba4:	ffcb061b          	addiw	a2,s6,-4
     ba8:	d7c40593          	addi	a1,s0,-644
     bac:	d3840513          	addi	a0,s0,-712
     bb0:	2c8000ef          	jal	e78 <memmove>
    dst[n - 4] = 0;
     bb4:	fa0b0793          	addi	a5,s6,-96
     bb8:	00878b33          	add	s6,a5,s0
     bbc:	d80b0a23          	sb	zero,-620(s6)
    return 0;
     bc0:	bfa9                	j	b1a <main+0x8d2>
    for(i = 0; i < pair[0]; i++){
     bc2:	2b05                	addiw	s6,s6,1
     bc4:	d3044783          	lbu	a5,-720(s0)
     bc8:	fafb52e3          	bge	s6,a5,b6c <main+0x924>
      if(write(dfd, &pair[1], 1) != 1)
     bcc:	4605                	li	a2,1
     bce:	d3140593          	addi	a1,s0,-719
     bd2:	855e                	mv	a0,s7
     bd4:	39e000ef          	jal	f72 <write>
     bd8:	4785                	li	a5,1
     bda:	fef504e3          	beq	a0,a5,bc2 <main+0x97a>
  int sfd = -1, dfd = -1, i, rc = -1;
     bde:	5b7d                	li	s6,-1
  close(dfd);
     be0:	855e                	mv	a0,s7
     be2:	398000ef          	jal	f7a <close>
  close(sfd);
     be6:	8562                	mv	a0,s8
     be8:	392000ef          	jal	f7a <close>
  unlock_two(t->a, FM_READ, dst, FM_WRITE);
     bec:	4685                	li	a3,1
     bee:	d3840613          	addi	a2,s0,-712
     bf2:	4581                	li	a1,0
     bf4:	d7c40513          	addi	a0,s0,-644
     bf8:	d48ff0ef          	jal	140 <unlock_two>
  log_result("decompress", t->a, dst, rc);
     bfc:	86da                	mv	a3,s6
     bfe:	d3840613          	addi	a2,s0,-712
     c02:	d7c40593          	addi	a1,s0,-644
     c06:	00001517          	auipc	a0,0x1
     c0a:	9e250513          	addi	a0,a0,-1566 # 15e8 <malloc+0x1aa>
     c0e:	d7cff0ef          	jal	18a <log_result>
  return rc;
     c12:	bc21                	j	62a <main+0x3e2>
  rc = 0;
     c14:	4b01                	li	s6,0
     c16:	b7e9                	j	be0 <main+0x998>
  int sfd = -1, dfd = -1, i, rc = -1;
     c18:	5b7d                	li	s6,-1
     c1a:	b7f1                	j	be6 <main+0x99e>
     c1c:	5b7d                	li	s6,-1
     c1e:	bff9                	j	bfc <main+0x9b4>
     c20:	5b7d                	li	s6,-1
     c22:	bfe9                	j	bfc <main+0x9b4>
  close(rfd);
     c24:	854a                	mv	a0,s2
     c26:	354000ef          	jal	f7a <close>
  exit(0);
     c2a:	4501                	li	a0,0
     c2c:	326000ef          	jal	f52 <exit>
    printf("queue write failed\n");
     c30:	00001517          	auipc	a0,0x1
     c34:	a4050513          	addi	a0,a0,-1472 # 1670 <malloc+0x232>
     c38:	752000ef          	jal	138a <printf>
     c3c:	ef0ff06f          	j	32c <main+0xe4>
  int sfd = -1, dfd = -1, i, rc = -1;
     c40:	5b7d                	li	s6,-1
     c42:	bf6d                	j	bfc <main+0x9b4>
     c44:	29913423          	sd	s9,648(sp)
     c48:	29a13023          	sd	s10,640(sp)
  printf("usage:\n");
     c4c:	00001517          	auipc	a0,0x1
     c50:	a3c50513          	addi	a0,a0,-1476 # 1688 <malloc+0x24a>
     c54:	736000ef          	jal	138a <printf>
  printf("  fops read <file>\n");
     c58:	00001517          	auipc	a0,0x1
     c5c:	a3850513          	addi	a0,a0,-1480 # 1690 <malloc+0x252>
     c60:	72a000ef          	jal	138a <printf>
  printf("  fops write <file> <text>\n");
     c64:	00001517          	auipc	a0,0x1
     c68:	a4450513          	addi	a0,a0,-1468 # 16a8 <malloc+0x26a>
     c6c:	71e000ef          	jal	138a <printf>
  printf("  fops copy <src> <dst>\n");
     c70:	00001517          	auipc	a0,0x1
     c74:	a5850513          	addi	a0,a0,-1448 # 16c8 <malloc+0x28a>
     c78:	712000ef          	jal	138a <printf>
  printf("  fops rename <old> <new>\n");
     c7c:	00001517          	auipc	a0,0x1
     c80:	a6c50513          	addi	a0,a0,-1428 # 16e8 <malloc+0x2aa>
     c84:	706000ef          	jal	138a <printf>
  printf("  fops delete <file>\n");
     c88:	00001517          	auipc	a0,0x1
     c8c:	a8050513          	addi	a0,a0,-1408 # 1708 <malloc+0x2ca>
     c90:	6fa000ef          	jal	138a <printf>
  printf("  fops meta <file>\n");
     c94:	00001517          	auipc	a0,0x1
     c98:	a8c50513          	addi	a0,a0,-1396 # 1720 <malloc+0x2e2>
     c9c:	6ee000ef          	jal	138a <printf>
  printf("  fops compress <file>\n");
     ca0:	00001517          	auipc	a0,0x1
     ca4:	a9850513          	addi	a0,a0,-1384 # 1738 <malloc+0x2fa>
     ca8:	6e2000ef          	jal	138a <printf>
  printf("  fops decompress <file.rle>\n");
     cac:	00001517          	auipc	a0,0x1
     cb0:	aa450513          	addi	a0,a0,-1372 # 1750 <malloc+0x312>
     cb4:	6d6000ef          	jal	138a <printf>
    exit(1);
     cb8:	4505                	li	a0,1
     cba:	298000ef          	jal	f52 <exit>

0000000000000cbe <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     cbe:	1141                	addi	sp,sp,-16
     cc0:	e406                	sd	ra,8(sp)
     cc2:	e022                	sd	s0,0(sp)
     cc4:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     cc6:	d82ff0ef          	jal	248 <main>
  exit(r);
     cca:	288000ef          	jal	f52 <exit>

0000000000000cce <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     cce:	1141                	addi	sp,sp,-16
     cd0:	e422                	sd	s0,8(sp)
     cd2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     cd4:	87aa                	mv	a5,a0
     cd6:	0585                	addi	a1,a1,1
     cd8:	0785                	addi	a5,a5,1
     cda:	fff5c703          	lbu	a4,-1(a1)
     cde:	fee78fa3          	sb	a4,-1(a5)
     ce2:	fb75                	bnez	a4,cd6 <strcpy+0x8>
    ;
  return os;
}
     ce4:	6422                	ld	s0,8(sp)
     ce6:	0141                	addi	sp,sp,16
     ce8:	8082                	ret

0000000000000cea <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cea:	1141                	addi	sp,sp,-16
     cec:	e422                	sd	s0,8(sp)
     cee:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     cf0:	00054783          	lbu	a5,0(a0)
     cf4:	cb91                	beqz	a5,d08 <strcmp+0x1e>
     cf6:	0005c703          	lbu	a4,0(a1)
     cfa:	00f71763          	bne	a4,a5,d08 <strcmp+0x1e>
    p++, q++;
     cfe:	0505                	addi	a0,a0,1
     d00:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     d02:	00054783          	lbu	a5,0(a0)
     d06:	fbe5                	bnez	a5,cf6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     d08:	0005c503          	lbu	a0,0(a1)
}
     d0c:	40a7853b          	subw	a0,a5,a0
     d10:	6422                	ld	s0,8(sp)
     d12:	0141                	addi	sp,sp,16
     d14:	8082                	ret

0000000000000d16 <strlen>:

uint
strlen(const char *s)
{
     d16:	1141                	addi	sp,sp,-16
     d18:	e422                	sd	s0,8(sp)
     d1a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     d1c:	00054783          	lbu	a5,0(a0)
     d20:	cf91                	beqz	a5,d3c <strlen+0x26>
     d22:	0505                	addi	a0,a0,1
     d24:	87aa                	mv	a5,a0
     d26:	86be                	mv	a3,a5
     d28:	0785                	addi	a5,a5,1
     d2a:	fff7c703          	lbu	a4,-1(a5)
     d2e:	ff65                	bnez	a4,d26 <strlen+0x10>
     d30:	40a6853b          	subw	a0,a3,a0
     d34:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     d36:	6422                	ld	s0,8(sp)
     d38:	0141                	addi	sp,sp,16
     d3a:	8082                	ret
  for(n = 0; s[n]; n++)
     d3c:	4501                	li	a0,0
     d3e:	bfe5                	j	d36 <strlen+0x20>

0000000000000d40 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d40:	1141                	addi	sp,sp,-16
     d42:	e422                	sd	s0,8(sp)
     d44:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     d46:	ca19                	beqz	a2,d5c <memset+0x1c>
     d48:	87aa                	mv	a5,a0
     d4a:	1602                	slli	a2,a2,0x20
     d4c:	9201                	srli	a2,a2,0x20
     d4e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     d52:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     d56:	0785                	addi	a5,a5,1
     d58:	fee79de3          	bne	a5,a4,d52 <memset+0x12>
  }
  return dst;
}
     d5c:	6422                	ld	s0,8(sp)
     d5e:	0141                	addi	sp,sp,16
     d60:	8082                	ret

0000000000000d62 <strchr>:

char*
strchr(const char *s, char c)
{
     d62:	1141                	addi	sp,sp,-16
     d64:	e422                	sd	s0,8(sp)
     d66:	0800                	addi	s0,sp,16
  for(; *s; s++)
     d68:	00054783          	lbu	a5,0(a0)
     d6c:	cb99                	beqz	a5,d82 <strchr+0x20>
    if(*s == c)
     d6e:	00f58763          	beq	a1,a5,d7c <strchr+0x1a>
  for(; *s; s++)
     d72:	0505                	addi	a0,a0,1
     d74:	00054783          	lbu	a5,0(a0)
     d78:	fbfd                	bnez	a5,d6e <strchr+0xc>
      return (char*)s;
  return 0;
     d7a:	4501                	li	a0,0
}
     d7c:	6422                	ld	s0,8(sp)
     d7e:	0141                	addi	sp,sp,16
     d80:	8082                	ret
  return 0;
     d82:	4501                	li	a0,0
     d84:	bfe5                	j	d7c <strchr+0x1a>

0000000000000d86 <gets>:

char*
gets(char *buf, int max)
{
     d86:	711d                	addi	sp,sp,-96
     d88:	ec86                	sd	ra,88(sp)
     d8a:	e8a2                	sd	s0,80(sp)
     d8c:	e4a6                	sd	s1,72(sp)
     d8e:	e0ca                	sd	s2,64(sp)
     d90:	fc4e                	sd	s3,56(sp)
     d92:	f852                	sd	s4,48(sp)
     d94:	f456                	sd	s5,40(sp)
     d96:	f05a                	sd	s6,32(sp)
     d98:	ec5e                	sd	s7,24(sp)
     d9a:	1080                	addi	s0,sp,96
     d9c:	8baa                	mv	s7,a0
     d9e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     da0:	892a                	mv	s2,a0
     da2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     da4:	4aa9                	li	s5,10
     da6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     da8:	89a6                	mv	s3,s1
     daa:	2485                	addiw	s1,s1,1
     dac:	0344d663          	bge	s1,s4,dd8 <gets+0x52>
    cc = read(0, &c, 1);
     db0:	4605                	li	a2,1
     db2:	faf40593          	addi	a1,s0,-81
     db6:	4501                	li	a0,0
     db8:	1b2000ef          	jal	f6a <read>
    if(cc < 1)
     dbc:	00a05e63          	blez	a0,dd8 <gets+0x52>
    buf[i++] = c;
     dc0:	faf44783          	lbu	a5,-81(s0)
     dc4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     dc8:	01578763          	beq	a5,s5,dd6 <gets+0x50>
     dcc:	0905                	addi	s2,s2,1
     dce:	fd679de3          	bne	a5,s6,da8 <gets+0x22>
    buf[i++] = c;
     dd2:	89a6                	mv	s3,s1
     dd4:	a011                	j	dd8 <gets+0x52>
     dd6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     dd8:	99de                	add	s3,s3,s7
     dda:	00098023          	sb	zero,0(s3)
  return buf;
}
     dde:	855e                	mv	a0,s7
     de0:	60e6                	ld	ra,88(sp)
     de2:	6446                	ld	s0,80(sp)
     de4:	64a6                	ld	s1,72(sp)
     de6:	6906                	ld	s2,64(sp)
     de8:	79e2                	ld	s3,56(sp)
     dea:	7a42                	ld	s4,48(sp)
     dec:	7aa2                	ld	s5,40(sp)
     dee:	7b02                	ld	s6,32(sp)
     df0:	6be2                	ld	s7,24(sp)
     df2:	6125                	addi	sp,sp,96
     df4:	8082                	ret

0000000000000df6 <stat>:

int
stat(const char *n, struct stat *st)
{
     df6:	1101                	addi	sp,sp,-32
     df8:	ec06                	sd	ra,24(sp)
     dfa:	e822                	sd	s0,16(sp)
     dfc:	e04a                	sd	s2,0(sp)
     dfe:	1000                	addi	s0,sp,32
     e00:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e02:	4581                	li	a1,0
     e04:	18e000ef          	jal	f92 <open>
  if(fd < 0)
     e08:	02054263          	bltz	a0,e2c <stat+0x36>
     e0c:	e426                	sd	s1,8(sp)
     e0e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     e10:	85ca                	mv	a1,s2
     e12:	198000ef          	jal	faa <fstat>
     e16:	892a                	mv	s2,a0
  close(fd);
     e18:	8526                	mv	a0,s1
     e1a:	160000ef          	jal	f7a <close>
  return r;
     e1e:	64a2                	ld	s1,8(sp)
}
     e20:	854a                	mv	a0,s2
     e22:	60e2                	ld	ra,24(sp)
     e24:	6442                	ld	s0,16(sp)
     e26:	6902                	ld	s2,0(sp)
     e28:	6105                	addi	sp,sp,32
     e2a:	8082                	ret
    return -1;
     e2c:	597d                	li	s2,-1
     e2e:	bfcd                	j	e20 <stat+0x2a>

0000000000000e30 <atoi>:

int
atoi(const char *s)
{
     e30:	1141                	addi	sp,sp,-16
     e32:	e422                	sd	s0,8(sp)
     e34:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e36:	00054683          	lbu	a3,0(a0)
     e3a:	fd06879b          	addiw	a5,a3,-48
     e3e:	0ff7f793          	zext.b	a5,a5
     e42:	4625                	li	a2,9
     e44:	02f66863          	bltu	a2,a5,e74 <atoi+0x44>
     e48:	872a                	mv	a4,a0
  n = 0;
     e4a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     e4c:	0705                	addi	a4,a4,1
     e4e:	0025179b          	slliw	a5,a0,0x2
     e52:	9fa9                	addw	a5,a5,a0
     e54:	0017979b          	slliw	a5,a5,0x1
     e58:	9fb5                	addw	a5,a5,a3
     e5a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     e5e:	00074683          	lbu	a3,0(a4)
     e62:	fd06879b          	addiw	a5,a3,-48
     e66:	0ff7f793          	zext.b	a5,a5
     e6a:	fef671e3          	bgeu	a2,a5,e4c <atoi+0x1c>
  return n;
}
     e6e:	6422                	ld	s0,8(sp)
     e70:	0141                	addi	sp,sp,16
     e72:	8082                	ret
  n = 0;
     e74:	4501                	li	a0,0
     e76:	bfe5                	j	e6e <atoi+0x3e>

0000000000000e78 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e78:	1141                	addi	sp,sp,-16
     e7a:	e422                	sd	s0,8(sp)
     e7c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     e7e:	02b57463          	bgeu	a0,a1,ea6 <memmove+0x2e>
    while(n-- > 0)
     e82:	00c05f63          	blez	a2,ea0 <memmove+0x28>
     e86:	1602                	slli	a2,a2,0x20
     e88:	9201                	srli	a2,a2,0x20
     e8a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     e8e:	872a                	mv	a4,a0
      *dst++ = *src++;
     e90:	0585                	addi	a1,a1,1
     e92:	0705                	addi	a4,a4,1
     e94:	fff5c683          	lbu	a3,-1(a1)
     e98:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     e9c:	fef71ae3          	bne	a4,a5,e90 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ea0:	6422                	ld	s0,8(sp)
     ea2:	0141                	addi	sp,sp,16
     ea4:	8082                	ret
    dst += n;
     ea6:	00c50733          	add	a4,a0,a2
    src += n;
     eaa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     eac:	fec05ae3          	blez	a2,ea0 <memmove+0x28>
     eb0:	fff6079b          	addiw	a5,a2,-1
     eb4:	1782                	slli	a5,a5,0x20
     eb6:	9381                	srli	a5,a5,0x20
     eb8:	fff7c793          	not	a5,a5
     ebc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ebe:	15fd                	addi	a1,a1,-1
     ec0:	177d                	addi	a4,a4,-1
     ec2:	0005c683          	lbu	a3,0(a1)
     ec6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     eca:	fee79ae3          	bne	a5,a4,ebe <memmove+0x46>
     ece:	bfc9                	j	ea0 <memmove+0x28>

0000000000000ed0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     ed0:	1141                	addi	sp,sp,-16
     ed2:	e422                	sd	s0,8(sp)
     ed4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     ed6:	ca05                	beqz	a2,f06 <memcmp+0x36>
     ed8:	fff6069b          	addiw	a3,a2,-1
     edc:	1682                	slli	a3,a3,0x20
     ede:	9281                	srli	a3,a3,0x20
     ee0:	0685                	addi	a3,a3,1
     ee2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     ee4:	00054783          	lbu	a5,0(a0)
     ee8:	0005c703          	lbu	a4,0(a1)
     eec:	00e79863          	bne	a5,a4,efc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     ef0:	0505                	addi	a0,a0,1
    p2++;
     ef2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     ef4:	fed518e3          	bne	a0,a3,ee4 <memcmp+0x14>
  }
  return 0;
     ef8:	4501                	li	a0,0
     efa:	a019                	j	f00 <memcmp+0x30>
      return *p1 - *p2;
     efc:	40e7853b          	subw	a0,a5,a4
}
     f00:	6422                	ld	s0,8(sp)
     f02:	0141                	addi	sp,sp,16
     f04:	8082                	ret
  return 0;
     f06:	4501                	li	a0,0
     f08:	bfe5                	j	f00 <memcmp+0x30>

0000000000000f0a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     f0a:	1141                	addi	sp,sp,-16
     f0c:	e406                	sd	ra,8(sp)
     f0e:	e022                	sd	s0,0(sp)
     f10:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     f12:	f67ff0ef          	jal	e78 <memmove>
}
     f16:	60a2                	ld	ra,8(sp)
     f18:	6402                	ld	s0,0(sp)
     f1a:	0141                	addi	sp,sp,16
     f1c:	8082                	ret

0000000000000f1e <sbrk>:

char *
sbrk(int n) {
     f1e:	1141                	addi	sp,sp,-16
     f20:	e406                	sd	ra,8(sp)
     f22:	e022                	sd	s0,0(sp)
     f24:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     f26:	4585                	li	a1,1
     f28:	0b2000ef          	jal	fda <sys_sbrk>
}
     f2c:	60a2                	ld	ra,8(sp)
     f2e:	6402                	ld	s0,0(sp)
     f30:	0141                	addi	sp,sp,16
     f32:	8082                	ret

0000000000000f34 <sbrklazy>:

char *
sbrklazy(int n) {
     f34:	1141                	addi	sp,sp,-16
     f36:	e406                	sd	ra,8(sp)
     f38:	e022                	sd	s0,0(sp)
     f3a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     f3c:	4589                	li	a1,2
     f3e:	09c000ef          	jal	fda <sys_sbrk>
}
     f42:	60a2                	ld	ra,8(sp)
     f44:	6402                	ld	s0,0(sp)
     f46:	0141                	addi	sp,sp,16
     f48:	8082                	ret

0000000000000f4a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     f4a:	4885                	li	a7,1
 ecall
     f4c:	00000073          	ecall
 ret
     f50:	8082                	ret

0000000000000f52 <exit>:
.global exit
exit:
 li a7, SYS_exit
     f52:	4889                	li	a7,2
 ecall
     f54:	00000073          	ecall
 ret
     f58:	8082                	ret

0000000000000f5a <wait>:
.global wait
wait:
 li a7, SYS_wait
     f5a:	488d                	li	a7,3
 ecall
     f5c:	00000073          	ecall
 ret
     f60:	8082                	ret

0000000000000f62 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     f62:	4891                	li	a7,4
 ecall
     f64:	00000073          	ecall
 ret
     f68:	8082                	ret

0000000000000f6a <read>:
.global read
read:
 li a7, SYS_read
     f6a:	4895                	li	a7,5
 ecall
     f6c:	00000073          	ecall
 ret
     f70:	8082                	ret

0000000000000f72 <write>:
.global write
write:
 li a7, SYS_write
     f72:	48c1                	li	a7,16
 ecall
     f74:	00000073          	ecall
 ret
     f78:	8082                	ret

0000000000000f7a <close>:
.global close
close:
 li a7, SYS_close
     f7a:	48d5                	li	a7,21
 ecall
     f7c:	00000073          	ecall
 ret
     f80:	8082                	ret

0000000000000f82 <kill>:
.global kill
kill:
 li a7, SYS_kill
     f82:	4899                	li	a7,6
 ecall
     f84:	00000073          	ecall
 ret
     f88:	8082                	ret

0000000000000f8a <exec>:
.global exec
exec:
 li a7, SYS_exec
     f8a:	489d                	li	a7,7
 ecall
     f8c:	00000073          	ecall
 ret
     f90:	8082                	ret

0000000000000f92 <open>:
.global open
open:
 li a7, SYS_open
     f92:	48bd                	li	a7,15
 ecall
     f94:	00000073          	ecall
 ret
     f98:	8082                	ret

0000000000000f9a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     f9a:	48c5                	li	a7,17
 ecall
     f9c:	00000073          	ecall
 ret
     fa0:	8082                	ret

0000000000000fa2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     fa2:	48c9                	li	a7,18
 ecall
     fa4:	00000073          	ecall
 ret
     fa8:	8082                	ret

0000000000000faa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     faa:	48a1                	li	a7,8
 ecall
     fac:	00000073          	ecall
 ret
     fb0:	8082                	ret

0000000000000fb2 <link>:
.global link
link:
 li a7, SYS_link
     fb2:	48cd                	li	a7,19
 ecall
     fb4:	00000073          	ecall
 ret
     fb8:	8082                	ret

0000000000000fba <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     fba:	48d1                	li	a7,20
 ecall
     fbc:	00000073          	ecall
 ret
     fc0:	8082                	ret

0000000000000fc2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     fc2:	48a5                	li	a7,9
 ecall
     fc4:	00000073          	ecall
 ret
     fc8:	8082                	ret

0000000000000fca <dup>:
.global dup
dup:
 li a7, SYS_dup
     fca:	48a9                	li	a7,10
 ecall
     fcc:	00000073          	ecall
 ret
     fd0:	8082                	ret

0000000000000fd2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     fd2:	48ad                	li	a7,11
 ecall
     fd4:	00000073          	ecall
 ret
     fd8:	8082                	ret

0000000000000fda <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     fda:	48b1                	li	a7,12
 ecall
     fdc:	00000073          	ecall
 ret
     fe0:	8082                	ret

0000000000000fe2 <pause>:
.global pause
pause:
 li a7, SYS_pause
     fe2:	48b5                	li	a7,13
 ecall
     fe4:	00000073          	ecall
 ret
     fe8:	8082                	ret

0000000000000fea <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     fea:	48b9                	li	a7,14
 ecall
     fec:	00000073          	ecall
 ret
     ff0:	8082                	ret

0000000000000ff2 <fmlock>:
.global fmlock
fmlock:
 li a7, SYS_fmlock
     ff2:	48d9                	li	a7,22
 ecall
     ff4:	00000073          	ecall
 ret
     ff8:	8082                	ret

0000000000000ffa <fmunlock>:
.global fmunlock
fmunlock:
 li a7, SYS_fmunlock
     ffa:	48dd                	li	a7,23
 ecall
     ffc:	00000073          	ecall
 ret
    1000:	8082                	ret

0000000000001002 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1002:	1101                	addi	sp,sp,-32
    1004:	ec06                	sd	ra,24(sp)
    1006:	e822                	sd	s0,16(sp)
    1008:	1000                	addi	s0,sp,32
    100a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    100e:	4605                	li	a2,1
    1010:	fef40593          	addi	a1,s0,-17
    1014:	f5fff0ef          	jal	f72 <write>
}
    1018:	60e2                	ld	ra,24(sp)
    101a:	6442                	ld	s0,16(sp)
    101c:	6105                	addi	sp,sp,32
    101e:	8082                	ret

0000000000001020 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    1020:	715d                	addi	sp,sp,-80
    1022:	e486                	sd	ra,72(sp)
    1024:	e0a2                	sd	s0,64(sp)
    1026:	f84a                	sd	s2,48(sp)
    1028:	0880                	addi	s0,sp,80
    102a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
    102c:	c299                	beqz	a3,1032 <printint+0x12>
    102e:	0805c363          	bltz	a1,10b4 <printint+0x94>
  neg = 0;
    1032:	4881                	li	a7,0
    1034:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    1038:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
    103a:	00000517          	auipc	a0,0x0
    103e:	76650513          	addi	a0,a0,1894 # 17a0 <digits>
    1042:	883e                	mv	a6,a5
    1044:	2785                	addiw	a5,a5,1
    1046:	02c5f733          	remu	a4,a1,a2
    104a:	972a                	add	a4,a4,a0
    104c:	00074703          	lbu	a4,0(a4)
    1050:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
    1054:	872e                	mv	a4,a1
    1056:	02c5d5b3          	divu	a1,a1,a2
    105a:	0685                	addi	a3,a3,1
    105c:	fec773e3          	bgeu	a4,a2,1042 <printint+0x22>
  if(neg)
    1060:	00088b63          	beqz	a7,1076 <printint+0x56>
    buf[i++] = '-';
    1064:	fd078793          	addi	a5,a5,-48
    1068:	97a2                	add	a5,a5,s0
    106a:	02d00713          	li	a4,45
    106e:	fee78423          	sb	a4,-24(a5)
    1072:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
    1076:	02f05a63          	blez	a5,10aa <printint+0x8a>
    107a:	fc26                	sd	s1,56(sp)
    107c:	f44e                	sd	s3,40(sp)
    107e:	fb840713          	addi	a4,s0,-72
    1082:	00f704b3          	add	s1,a4,a5
    1086:	fff70993          	addi	s3,a4,-1
    108a:	99be                	add	s3,s3,a5
    108c:	37fd                	addiw	a5,a5,-1
    108e:	1782                	slli	a5,a5,0x20
    1090:	9381                	srli	a5,a5,0x20
    1092:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
    1096:	fff4c583          	lbu	a1,-1(s1)
    109a:	854a                	mv	a0,s2
    109c:	f67ff0ef          	jal	1002 <putc>
  while(--i >= 0)
    10a0:	14fd                	addi	s1,s1,-1
    10a2:	ff349ae3          	bne	s1,s3,1096 <printint+0x76>
    10a6:	74e2                	ld	s1,56(sp)
    10a8:	79a2                	ld	s3,40(sp)
}
    10aa:	60a6                	ld	ra,72(sp)
    10ac:	6406                	ld	s0,64(sp)
    10ae:	7942                	ld	s2,48(sp)
    10b0:	6161                	addi	sp,sp,80
    10b2:	8082                	ret
    x = -xx;
    10b4:	40b005b3          	neg	a1,a1
    neg = 1;
    10b8:	4885                	li	a7,1
    x = -xx;
    10ba:	bfad                	j	1034 <printint+0x14>

00000000000010bc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    10bc:	711d                	addi	sp,sp,-96
    10be:	ec86                	sd	ra,88(sp)
    10c0:	e8a2                	sd	s0,80(sp)
    10c2:	e0ca                	sd	s2,64(sp)
    10c4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    10c6:	0005c903          	lbu	s2,0(a1)
    10ca:	28090663          	beqz	s2,1356 <vprintf+0x29a>
    10ce:	e4a6                	sd	s1,72(sp)
    10d0:	fc4e                	sd	s3,56(sp)
    10d2:	f852                	sd	s4,48(sp)
    10d4:	f456                	sd	s5,40(sp)
    10d6:	f05a                	sd	s6,32(sp)
    10d8:	ec5e                	sd	s7,24(sp)
    10da:	e862                	sd	s8,16(sp)
    10dc:	e466                	sd	s9,8(sp)
    10de:	8b2a                	mv	s6,a0
    10e0:	8a2e                	mv	s4,a1
    10e2:	8bb2                	mv	s7,a2
  state = 0;
    10e4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    10e6:	4481                	li	s1,0
    10e8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    10ea:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    10ee:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    10f2:	06c00c93          	li	s9,108
    10f6:	a005                	j	1116 <vprintf+0x5a>
        putc(fd, c0);
    10f8:	85ca                	mv	a1,s2
    10fa:	855a                	mv	a0,s6
    10fc:	f07ff0ef          	jal	1002 <putc>
    1100:	a019                	j	1106 <vprintf+0x4a>
    } else if(state == '%'){
    1102:	03598263          	beq	s3,s5,1126 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
    1106:	2485                	addiw	s1,s1,1
    1108:	8726                	mv	a4,s1
    110a:	009a07b3          	add	a5,s4,s1
    110e:	0007c903          	lbu	s2,0(a5)
    1112:	22090a63          	beqz	s2,1346 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
    1116:	0009079b          	sext.w	a5,s2
    if(state == 0){
    111a:	fe0994e3          	bnez	s3,1102 <vprintf+0x46>
      if(c0 == '%'){
    111e:	fd579de3          	bne	a5,s5,10f8 <vprintf+0x3c>
        state = '%';
    1122:	89be                	mv	s3,a5
    1124:	b7cd                	j	1106 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
    1126:	00ea06b3          	add	a3,s4,a4
    112a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    112e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
    1130:	c681                	beqz	a3,1138 <vprintf+0x7c>
    1132:	9752                	add	a4,a4,s4
    1134:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
    1138:	05878363          	beq	a5,s8,117e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
    113c:	05978d63          	beq	a5,s9,1196 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    1140:	07500713          	li	a4,117
    1144:	0ee78763          	beq	a5,a4,1232 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    1148:	07800713          	li	a4,120
    114c:	12e78963          	beq	a5,a4,127e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    1150:	07000713          	li	a4,112
    1154:	14e78e63          	beq	a5,a4,12b0 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
    1158:	06300713          	li	a4,99
    115c:	18e78e63          	beq	a5,a4,12f8 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
    1160:	07300713          	li	a4,115
    1164:	1ae78463          	beq	a5,a4,130c <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    1168:	02500713          	li	a4,37
    116c:	04e79563          	bne	a5,a4,11b6 <vprintf+0xfa>
        putc(fd, '%');
    1170:	02500593          	li	a1,37
    1174:	855a                	mv	a0,s6
    1176:	e8dff0ef          	jal	1002 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
    117a:	4981                	li	s3,0
    117c:	b769                	j	1106 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    117e:	008b8913          	addi	s2,s7,8
    1182:	4685                	li	a3,1
    1184:	4629                	li	a2,10
    1186:	000ba583          	lw	a1,0(s7)
    118a:	855a                	mv	a0,s6
    118c:	e95ff0ef          	jal	1020 <printint>
    1190:	8bca                	mv	s7,s2
      state = 0;
    1192:	4981                	li	s3,0
    1194:	bf8d                	j	1106 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
    1196:	06400793          	li	a5,100
    119a:	02f68963          	beq	a3,a5,11cc <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    119e:	06c00793          	li	a5,108
    11a2:	04f68263          	beq	a3,a5,11e6 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
    11a6:	07500793          	li	a5,117
    11aa:	0af68063          	beq	a3,a5,124a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
    11ae:	07800793          	li	a5,120
    11b2:	0ef68263          	beq	a3,a5,1296 <vprintf+0x1da>
        putc(fd, '%');
    11b6:	02500593          	li	a1,37
    11ba:	855a                	mv	a0,s6
    11bc:	e47ff0ef          	jal	1002 <putc>
        putc(fd, c0);
    11c0:	85ca                	mv	a1,s2
    11c2:	855a                	mv	a0,s6
    11c4:	e3fff0ef          	jal	1002 <putc>
      state = 0;
    11c8:	4981                	li	s3,0
    11ca:	bf35                	j	1106 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    11cc:	008b8913          	addi	s2,s7,8
    11d0:	4685                	li	a3,1
    11d2:	4629                	li	a2,10
    11d4:	000bb583          	ld	a1,0(s7)
    11d8:	855a                	mv	a0,s6
    11da:	e47ff0ef          	jal	1020 <printint>
        i += 1;
    11de:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    11e0:	8bca                	mv	s7,s2
      state = 0;
    11e2:	4981                	li	s3,0
        i += 1;
    11e4:	b70d                	j	1106 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    11e6:	06400793          	li	a5,100
    11ea:	02f60763          	beq	a2,a5,1218 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    11ee:	07500793          	li	a5,117
    11f2:	06f60963          	beq	a2,a5,1264 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    11f6:	07800793          	li	a5,120
    11fa:	faf61ee3          	bne	a2,a5,11b6 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
    11fe:	008b8913          	addi	s2,s7,8
    1202:	4681                	li	a3,0
    1204:	4641                	li	a2,16
    1206:	000bb583          	ld	a1,0(s7)
    120a:	855a                	mv	a0,s6
    120c:	e15ff0ef          	jal	1020 <printint>
        i += 2;
    1210:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    1212:	8bca                	mv	s7,s2
      state = 0;
    1214:	4981                	li	s3,0
        i += 2;
    1216:	bdc5                	j	1106 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1218:	008b8913          	addi	s2,s7,8
    121c:	4685                	li	a3,1
    121e:	4629                	li	a2,10
    1220:	000bb583          	ld	a1,0(s7)
    1224:	855a                	mv	a0,s6
    1226:	dfbff0ef          	jal	1020 <printint>
        i += 2;
    122a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    122c:	8bca                	mv	s7,s2
      state = 0;
    122e:	4981                	li	s3,0
        i += 2;
    1230:	bdd9                	j	1106 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
    1232:	008b8913          	addi	s2,s7,8
    1236:	4681                	li	a3,0
    1238:	4629                	li	a2,10
    123a:	000be583          	lwu	a1,0(s7)
    123e:	855a                	mv	a0,s6
    1240:	de1ff0ef          	jal	1020 <printint>
    1244:	8bca                	mv	s7,s2
      state = 0;
    1246:	4981                	li	s3,0
    1248:	bd7d                	j	1106 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    124a:	008b8913          	addi	s2,s7,8
    124e:	4681                	li	a3,0
    1250:	4629                	li	a2,10
    1252:	000bb583          	ld	a1,0(s7)
    1256:	855a                	mv	a0,s6
    1258:	dc9ff0ef          	jal	1020 <printint>
        i += 1;
    125c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    125e:	8bca                	mv	s7,s2
      state = 0;
    1260:	4981                	li	s3,0
        i += 1;
    1262:	b555                	j	1106 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1264:	008b8913          	addi	s2,s7,8
    1268:	4681                	li	a3,0
    126a:	4629                	li	a2,10
    126c:	000bb583          	ld	a1,0(s7)
    1270:	855a                	mv	a0,s6
    1272:	dafff0ef          	jal	1020 <printint>
        i += 2;
    1276:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1278:	8bca                	mv	s7,s2
      state = 0;
    127a:	4981                	li	s3,0
        i += 2;
    127c:	b569                	j	1106 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
    127e:	008b8913          	addi	s2,s7,8
    1282:	4681                	li	a3,0
    1284:	4641                	li	a2,16
    1286:	000be583          	lwu	a1,0(s7)
    128a:	855a                	mv	a0,s6
    128c:	d95ff0ef          	jal	1020 <printint>
    1290:	8bca                	mv	s7,s2
      state = 0;
    1292:	4981                	li	s3,0
    1294:	bd8d                	j	1106 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1296:	008b8913          	addi	s2,s7,8
    129a:	4681                	li	a3,0
    129c:	4641                	li	a2,16
    129e:	000bb583          	ld	a1,0(s7)
    12a2:	855a                	mv	a0,s6
    12a4:	d7dff0ef          	jal	1020 <printint>
        i += 1;
    12a8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    12aa:	8bca                	mv	s7,s2
      state = 0;
    12ac:	4981                	li	s3,0
        i += 1;
    12ae:	bda1                	j	1106 <vprintf+0x4a>
    12b0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    12b2:	008b8d13          	addi	s10,s7,8
    12b6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    12ba:	03000593          	li	a1,48
    12be:	855a                	mv	a0,s6
    12c0:	d43ff0ef          	jal	1002 <putc>
  putc(fd, 'x');
    12c4:	07800593          	li	a1,120
    12c8:	855a                	mv	a0,s6
    12ca:	d39ff0ef          	jal	1002 <putc>
    12ce:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    12d0:	00000b97          	auipc	s7,0x0
    12d4:	4d0b8b93          	addi	s7,s7,1232 # 17a0 <digits>
    12d8:	03c9d793          	srli	a5,s3,0x3c
    12dc:	97de                	add	a5,a5,s7
    12de:	0007c583          	lbu	a1,0(a5)
    12e2:	855a                	mv	a0,s6
    12e4:	d1fff0ef          	jal	1002 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    12e8:	0992                	slli	s3,s3,0x4
    12ea:	397d                	addiw	s2,s2,-1
    12ec:	fe0916e3          	bnez	s2,12d8 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
    12f0:	8bea                	mv	s7,s10
      state = 0;
    12f2:	4981                	li	s3,0
    12f4:	6d02                	ld	s10,0(sp)
    12f6:	bd01                	j	1106 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
    12f8:	008b8913          	addi	s2,s7,8
    12fc:	000bc583          	lbu	a1,0(s7)
    1300:	855a                	mv	a0,s6
    1302:	d01ff0ef          	jal	1002 <putc>
    1306:	8bca                	mv	s7,s2
      state = 0;
    1308:	4981                	li	s3,0
    130a:	bbf5                	j	1106 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    130c:	008b8993          	addi	s3,s7,8
    1310:	000bb903          	ld	s2,0(s7)
    1314:	00090f63          	beqz	s2,1332 <vprintf+0x276>
        for(; *s; s++)
    1318:	00094583          	lbu	a1,0(s2)
    131c:	c195                	beqz	a1,1340 <vprintf+0x284>
          putc(fd, *s);
    131e:	855a                	mv	a0,s6
    1320:	ce3ff0ef          	jal	1002 <putc>
        for(; *s; s++)
    1324:	0905                	addi	s2,s2,1
    1326:	00094583          	lbu	a1,0(s2)
    132a:	f9f5                	bnez	a1,131e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    132c:	8bce                	mv	s7,s3
      state = 0;
    132e:	4981                	li	s3,0
    1330:	bbd9                	j	1106 <vprintf+0x4a>
          s = "(null)";
    1332:	00000917          	auipc	s2,0x0
    1336:	43e90913          	addi	s2,s2,1086 # 1770 <malloc+0x332>
        for(; *s; s++)
    133a:	02800593          	li	a1,40
    133e:	b7c5                	j	131e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    1340:	8bce                	mv	s7,s3
      state = 0;
    1342:	4981                	li	s3,0
    1344:	b3c9                	j	1106 <vprintf+0x4a>
    1346:	64a6                	ld	s1,72(sp)
    1348:	79e2                	ld	s3,56(sp)
    134a:	7a42                	ld	s4,48(sp)
    134c:	7aa2                	ld	s5,40(sp)
    134e:	7b02                	ld	s6,32(sp)
    1350:	6be2                	ld	s7,24(sp)
    1352:	6c42                	ld	s8,16(sp)
    1354:	6ca2                	ld	s9,8(sp)
    }
  }
}
    1356:	60e6                	ld	ra,88(sp)
    1358:	6446                	ld	s0,80(sp)
    135a:	6906                	ld	s2,64(sp)
    135c:	6125                	addi	sp,sp,96
    135e:	8082                	ret

0000000000001360 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1360:	715d                	addi	sp,sp,-80
    1362:	ec06                	sd	ra,24(sp)
    1364:	e822                	sd	s0,16(sp)
    1366:	1000                	addi	s0,sp,32
    1368:	e010                	sd	a2,0(s0)
    136a:	e414                	sd	a3,8(s0)
    136c:	e818                	sd	a4,16(s0)
    136e:	ec1c                	sd	a5,24(s0)
    1370:	03043023          	sd	a6,32(s0)
    1374:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1378:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    137c:	8622                	mv	a2,s0
    137e:	d3fff0ef          	jal	10bc <vprintf>
}
    1382:	60e2                	ld	ra,24(sp)
    1384:	6442                	ld	s0,16(sp)
    1386:	6161                	addi	sp,sp,80
    1388:	8082                	ret

000000000000138a <printf>:

void
printf(const char *fmt, ...)
{
    138a:	711d                	addi	sp,sp,-96
    138c:	ec06                	sd	ra,24(sp)
    138e:	e822                	sd	s0,16(sp)
    1390:	1000                	addi	s0,sp,32
    1392:	e40c                	sd	a1,8(s0)
    1394:	e810                	sd	a2,16(s0)
    1396:	ec14                	sd	a3,24(s0)
    1398:	f018                	sd	a4,32(s0)
    139a:	f41c                	sd	a5,40(s0)
    139c:	03043823          	sd	a6,48(s0)
    13a0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    13a4:	00840613          	addi	a2,s0,8
    13a8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    13ac:	85aa                	mv	a1,a0
    13ae:	4505                	li	a0,1
    13b0:	d0dff0ef          	jal	10bc <vprintf>
}
    13b4:	60e2                	ld	ra,24(sp)
    13b6:	6442                	ld	s0,16(sp)
    13b8:	6125                	addi	sp,sp,96
    13ba:	8082                	ret

00000000000013bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    13bc:	1141                	addi	sp,sp,-16
    13be:	e422                	sd	s0,8(sp)
    13c0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    13c2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13c6:	00001797          	auipc	a5,0x1
    13ca:	c3a7b783          	ld	a5,-966(a5) # 2000 <freep>
    13ce:	a02d                	j	13f8 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    13d0:	4618                	lw	a4,8(a2)
    13d2:	9f2d                	addw	a4,a4,a1
    13d4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    13d8:	6398                	ld	a4,0(a5)
    13da:	6310                	ld	a2,0(a4)
    13dc:	a83d                	j	141a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    13de:	ff852703          	lw	a4,-8(a0)
    13e2:	9f31                	addw	a4,a4,a2
    13e4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    13e6:	ff053683          	ld	a3,-16(a0)
    13ea:	a091                	j	142e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13ec:	6398                	ld	a4,0(a5)
    13ee:	00e7e463          	bltu	a5,a4,13f6 <free+0x3a>
    13f2:	00e6ea63          	bltu	a3,a4,1406 <free+0x4a>
{
    13f6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13f8:	fed7fae3          	bgeu	a5,a3,13ec <free+0x30>
    13fc:	6398                	ld	a4,0(a5)
    13fe:	00e6e463          	bltu	a3,a4,1406 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1402:	fee7eae3          	bltu	a5,a4,13f6 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1406:	ff852583          	lw	a1,-8(a0)
    140a:	6390                	ld	a2,0(a5)
    140c:	02059813          	slli	a6,a1,0x20
    1410:	01c85713          	srli	a4,a6,0x1c
    1414:	9736                	add	a4,a4,a3
    1416:	fae60de3          	beq	a2,a4,13d0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    141a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    141e:	4790                	lw	a2,8(a5)
    1420:	02061593          	slli	a1,a2,0x20
    1424:	01c5d713          	srli	a4,a1,0x1c
    1428:	973e                	add	a4,a4,a5
    142a:	fae68ae3          	beq	a3,a4,13de <free+0x22>
    p->s.ptr = bp->s.ptr;
    142e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1430:	00001717          	auipc	a4,0x1
    1434:	bcf73823          	sd	a5,-1072(a4) # 2000 <freep>
}
    1438:	6422                	ld	s0,8(sp)
    143a:	0141                	addi	sp,sp,16
    143c:	8082                	ret

000000000000143e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    143e:	7139                	addi	sp,sp,-64
    1440:	fc06                	sd	ra,56(sp)
    1442:	f822                	sd	s0,48(sp)
    1444:	f426                	sd	s1,40(sp)
    1446:	ec4e                	sd	s3,24(sp)
    1448:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    144a:	02051493          	slli	s1,a0,0x20
    144e:	9081                	srli	s1,s1,0x20
    1450:	04bd                	addi	s1,s1,15
    1452:	8091                	srli	s1,s1,0x4
    1454:	0014899b          	addiw	s3,s1,1
    1458:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    145a:	00001517          	auipc	a0,0x1
    145e:	ba653503          	ld	a0,-1114(a0) # 2000 <freep>
    1462:	c915                	beqz	a0,1496 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1464:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1466:	4798                	lw	a4,8(a5)
    1468:	08977a63          	bgeu	a4,s1,14fc <malloc+0xbe>
    146c:	f04a                	sd	s2,32(sp)
    146e:	e852                	sd	s4,16(sp)
    1470:	e456                	sd	s5,8(sp)
    1472:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1474:	8a4e                	mv	s4,s3
    1476:	0009871b          	sext.w	a4,s3
    147a:	6685                	lui	a3,0x1
    147c:	00d77363          	bgeu	a4,a3,1482 <malloc+0x44>
    1480:	6a05                	lui	s4,0x1
    1482:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1486:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    148a:	00001917          	auipc	s2,0x1
    148e:	b7690913          	addi	s2,s2,-1162 # 2000 <freep>
  if(p == SBRK_ERROR)
    1492:	5afd                	li	s5,-1
    1494:	a081                	j	14d4 <malloc+0x96>
    1496:	f04a                	sd	s2,32(sp)
    1498:	e852                	sd	s4,16(sp)
    149a:	e456                	sd	s5,8(sp)
    149c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    149e:	00001797          	auipc	a5,0x1
    14a2:	b7278793          	addi	a5,a5,-1166 # 2010 <base>
    14a6:	00001717          	auipc	a4,0x1
    14aa:	b4f73d23          	sd	a5,-1190(a4) # 2000 <freep>
    14ae:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    14b0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    14b4:	b7c1                	j	1474 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    14b6:	6398                	ld	a4,0(a5)
    14b8:	e118                	sd	a4,0(a0)
    14ba:	a8a9                	j	1514 <malloc+0xd6>
  hp->s.size = nu;
    14bc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    14c0:	0541                	addi	a0,a0,16
    14c2:	efbff0ef          	jal	13bc <free>
  return freep;
    14c6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    14ca:	c12d                	beqz	a0,152c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14cc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    14ce:	4798                	lw	a4,8(a5)
    14d0:	02977263          	bgeu	a4,s1,14f4 <malloc+0xb6>
    if(p == freep)
    14d4:	00093703          	ld	a4,0(s2)
    14d8:	853e                	mv	a0,a5
    14da:	fef719e3          	bne	a4,a5,14cc <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    14de:	8552                	mv	a0,s4
    14e0:	a3fff0ef          	jal	f1e <sbrk>
  if(p == SBRK_ERROR)
    14e4:	fd551ce3          	bne	a0,s5,14bc <malloc+0x7e>
        return 0;
    14e8:	4501                	li	a0,0
    14ea:	7902                	ld	s2,32(sp)
    14ec:	6a42                	ld	s4,16(sp)
    14ee:	6aa2                	ld	s5,8(sp)
    14f0:	6b02                	ld	s6,0(sp)
    14f2:	a03d                	j	1520 <malloc+0xe2>
    14f4:	7902                	ld	s2,32(sp)
    14f6:	6a42                	ld	s4,16(sp)
    14f8:	6aa2                	ld	s5,8(sp)
    14fa:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    14fc:	fae48de3          	beq	s1,a4,14b6 <malloc+0x78>
        p->s.size -= nunits;
    1500:	4137073b          	subw	a4,a4,s3
    1504:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1506:	02071693          	slli	a3,a4,0x20
    150a:	01c6d713          	srli	a4,a3,0x1c
    150e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1510:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1514:	00001717          	auipc	a4,0x1
    1518:	aea73623          	sd	a0,-1300(a4) # 2000 <freep>
      return (void*)(p + 1);
    151c:	01078513          	addi	a0,a5,16
  }
}
    1520:	70e2                	ld	ra,56(sp)
    1522:	7442                	ld	s0,48(sp)
    1524:	74a2                	ld	s1,40(sp)
    1526:	69e2                	ld	s3,24(sp)
    1528:	6121                	addi	sp,sp,64
    152a:	8082                	ret
    152c:	7902                	ld	s2,32(sp)
    152e:	6a42                	ld	s4,16(sp)
    1530:	6aa2                	ld	s5,8(sp)
    1532:	6b02                	ld	s6,0(sp)
    1534:	b7f5                	j	1520 <malloc+0xe2>
