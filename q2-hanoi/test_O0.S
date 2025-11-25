
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00010000 <_start>:
   10000:	00002117          	auipc	sp,0x2
   10004:	b4010113          	addi	sp,sp,-1216 # 11b40 <__stack_top>
   10008:	00001297          	auipc	t0,0x1
   1000c:	b2a28293          	addi	t0,t0,-1238 # 10b32 <__bss_end>
   10010:	00001317          	auipc	t1,0x1
   10014:	b2230313          	addi	t1,t1,-1246 # 10b32 <__bss_end>
   10018:	0062d863          	bge	t0,t1,10028 <_start+0x28>
   1001c:	0002a023          	sw	zero,0(t0)
   10020:	00428293          	addi	t0,t0,4
   10024:	ff5ff06f          	j	10018 <_start+0x18>
   10028:	560000ef          	jal	10588 <main>
   1002c:	05d00893          	li	a7,93
   10030:	00000513          	li	a0,0
   10034:	00000073          	ecall
   10038:	0000006f          	j	10038 <_start+0x38>

0001003c <memcpy>:
   1003c:	fd010113          	addi	sp,sp,-48
   10040:	02112623          	sw	ra,44(sp)
   10044:	02812423          	sw	s0,40(sp)
   10048:	03010413          	addi	s0,sp,48
   1004c:	fca42e23          	sw	a0,-36(s0)
   10050:	fcb42c23          	sw	a1,-40(s0)
   10054:	fcc42a23          	sw	a2,-44(s0)
   10058:	fdc42783          	lw	a5,-36(s0)
   1005c:	fef42623          	sw	a5,-20(s0)
   10060:	fd842783          	lw	a5,-40(s0)
   10064:	fef42423          	sw	a5,-24(s0)
   10068:	0240006f          	j	1008c <memcpy+0x50>
   1006c:	fe842703          	lw	a4,-24(s0)
   10070:	00170793          	addi	a5,a4,1
   10074:	fef42423          	sw	a5,-24(s0)
   10078:	fec42783          	lw	a5,-20(s0)
   1007c:	00178693          	addi	a3,a5,1
   10080:	fed42623          	sw	a3,-20(s0)
   10084:	00074703          	lbu	a4,0(a4)
   10088:	00e78023          	sb	a4,0(a5)
   1008c:	fd442783          	lw	a5,-44(s0)
   10090:	fff78713          	addi	a4,a5,-1
   10094:	fce42a23          	sw	a4,-44(s0)
   10098:	fc079ae3          	bnez	a5,1006c <memcpy+0x30>
   1009c:	fdc42783          	lw	a5,-36(s0)
   100a0:	00078513          	mv	a0,a5
   100a4:	02c12083          	lw	ra,44(sp)
   100a8:	02812403          	lw	s0,40(sp)
   100ac:	03010113          	addi	sp,sp,48
   100b0:	00008067          	ret

000100b4 <udiv>:
   100b4:	fd010113          	addi	sp,sp,-48
   100b8:	02112623          	sw	ra,44(sp)
   100bc:	02812423          	sw	s0,40(sp)
   100c0:	03010413          	addi	s0,sp,48
   100c4:	fca42e23          	sw	a0,-36(s0)
   100c8:	fcb42c23          	sw	a1,-40(s0)
   100cc:	fd842783          	lw	a5,-40(s0)
   100d0:	00079663          	bnez	a5,100dc <udiv+0x28>
   100d4:	00000793          	li	a5,0
   100d8:	08c0006f          	j	10164 <udiv+0xb0>
   100dc:	fe042623          	sw	zero,-20(s0)
   100e0:	fe042423          	sw	zero,-24(s0)
   100e4:	01f00793          	li	a5,31
   100e8:	fef42223          	sw	a5,-28(s0)
   100ec:	06c0006f          	j	10158 <udiv+0xa4>
   100f0:	fe842783          	lw	a5,-24(s0)
   100f4:	00179793          	slli	a5,a5,0x1
   100f8:	fef42423          	sw	a5,-24(s0)
   100fc:	fe442783          	lw	a5,-28(s0)
   10100:	fdc42703          	lw	a4,-36(s0)
   10104:	00f757b3          	srl	a5,a4,a5
   10108:	0017f793          	andi	a5,a5,1
   1010c:	fe842703          	lw	a4,-24(s0)
   10110:	00f767b3          	or	a5,a4,a5
   10114:	fef42423          	sw	a5,-24(s0)
   10118:	fe842703          	lw	a4,-24(s0)
   1011c:	fd842783          	lw	a5,-40(s0)
   10120:	02f76663          	bltu	a4,a5,1014c <udiv+0x98>
   10124:	fe842703          	lw	a4,-24(s0)
   10128:	fd842783          	lw	a5,-40(s0)
   1012c:	40f707b3          	sub	a5,a4,a5
   10130:	fef42423          	sw	a5,-24(s0)
   10134:	fe442783          	lw	a5,-28(s0)
   10138:	00100713          	li	a4,1
   1013c:	00f717b3          	sll	a5,a4,a5
   10140:	fec42703          	lw	a4,-20(s0)
   10144:	00f767b3          	or	a5,a4,a5
   10148:	fef42623          	sw	a5,-20(s0)
   1014c:	fe442783          	lw	a5,-28(s0)
   10150:	fff78793          	addi	a5,a5,-1
   10154:	fef42223          	sw	a5,-28(s0)
   10158:	fe442783          	lw	a5,-28(s0)
   1015c:	f807dae3          	bgez	a5,100f0 <udiv+0x3c>
   10160:	fec42783          	lw	a5,-20(s0)
   10164:	00078513          	mv	a0,a5
   10168:	02c12083          	lw	ra,44(sp)
   1016c:	02812403          	lw	s0,40(sp)
   10170:	03010113          	addi	sp,sp,48
   10174:	00008067          	ret

00010178 <umod>:
   10178:	fd010113          	addi	sp,sp,-48
   1017c:	02112623          	sw	ra,44(sp)
   10180:	02812423          	sw	s0,40(sp)
   10184:	03010413          	addi	s0,sp,48
   10188:	fca42e23          	sw	a0,-36(s0)
   1018c:	fcb42c23          	sw	a1,-40(s0)
   10190:	fd842783          	lw	a5,-40(s0)
   10194:	00079663          	bnez	a5,101a0 <umod+0x28>
   10198:	00000793          	li	a5,0
   1019c:	0700006f          	j	1020c <umod+0x94>
   101a0:	fe042623          	sw	zero,-20(s0)
   101a4:	01f00793          	li	a5,31
   101a8:	fef42423          	sw	a5,-24(s0)
   101ac:	0540006f          	j	10200 <umod+0x88>
   101b0:	fec42783          	lw	a5,-20(s0)
   101b4:	00179793          	slli	a5,a5,0x1
   101b8:	fef42623          	sw	a5,-20(s0)
   101bc:	fe842783          	lw	a5,-24(s0)
   101c0:	fdc42703          	lw	a4,-36(s0)
   101c4:	00f757b3          	srl	a5,a4,a5
   101c8:	0017f793          	andi	a5,a5,1
   101cc:	fec42703          	lw	a4,-20(s0)
   101d0:	00f767b3          	or	a5,a4,a5
   101d4:	fef42623          	sw	a5,-20(s0)
   101d8:	fec42703          	lw	a4,-20(s0)
   101dc:	fd842783          	lw	a5,-40(s0)
   101e0:	00f76a63          	bltu	a4,a5,101f4 <umod+0x7c>
   101e4:	fec42703          	lw	a4,-20(s0)
   101e8:	fd842783          	lw	a5,-40(s0)
   101ec:	40f707b3          	sub	a5,a4,a5
   101f0:	fef42623          	sw	a5,-20(s0)
   101f4:	fe842783          	lw	a5,-24(s0)
   101f8:	fff78793          	addi	a5,a5,-1
   101fc:	fef42423          	sw	a5,-24(s0)
   10200:	fe842783          	lw	a5,-24(s0)
   10204:	fa07d6e3          	bgez	a5,101b0 <umod+0x38>
   10208:	fec42783          	lw	a5,-20(s0)
   1020c:	00078513          	mv	a0,a5
   10210:	02c12083          	lw	ra,44(sp)
   10214:	02812403          	lw	s0,40(sp)
   10218:	03010113          	addi	sp,sp,48
   1021c:	00008067          	ret

00010220 <umul>:
   10220:	fd010113          	addi	sp,sp,-48
   10224:	02112623          	sw	ra,44(sp)
   10228:	02812423          	sw	s0,40(sp)
   1022c:	03010413          	addi	s0,sp,48
   10230:	fca42e23          	sw	a0,-36(s0)
   10234:	fcb42c23          	sw	a1,-40(s0)
   10238:	fe042623          	sw	zero,-20(s0)
   1023c:	0380006f          	j	10274 <umul+0x54>
   10240:	fd842783          	lw	a5,-40(s0)
   10244:	0017f793          	andi	a5,a5,1
   10248:	00078a63          	beqz	a5,1025c <umul+0x3c>
   1024c:	fec42703          	lw	a4,-20(s0)
   10250:	fdc42783          	lw	a5,-36(s0)
   10254:	00f707b3          	add	a5,a4,a5
   10258:	fef42623          	sw	a5,-20(s0)
   1025c:	fdc42783          	lw	a5,-36(s0)
   10260:	00179793          	slli	a5,a5,0x1
   10264:	fcf42e23          	sw	a5,-36(s0)
   10268:	fd842783          	lw	a5,-40(s0)
   1026c:	0017d793          	srli	a5,a5,0x1
   10270:	fcf42c23          	sw	a5,-40(s0)
   10274:	fd842783          	lw	a5,-40(s0)
   10278:	fc0794e3          	bnez	a5,10240 <umul+0x20>
   1027c:	fec42783          	lw	a5,-20(s0)
   10280:	00078513          	mv	a0,a5
   10284:	02c12083          	lw	ra,44(sp)
   10288:	02812403          	lw	s0,40(sp)
   1028c:	03010113          	addi	sp,sp,48
   10290:	00008067          	ret

00010294 <__mulsi3>:
   10294:	fe010113          	addi	sp,sp,-32
   10298:	00112e23          	sw	ra,28(sp)
   1029c:	00812c23          	sw	s0,24(sp)
   102a0:	02010413          	addi	s0,sp,32
   102a4:	fea42623          	sw	a0,-20(s0)
   102a8:	feb42423          	sw	a1,-24(s0)
   102ac:	fe842583          	lw	a1,-24(s0)
   102b0:	fec42503          	lw	a0,-20(s0)
   102b4:	f6dff0ef          	jal	10220 <umul>
   102b8:	00050793          	mv	a5,a0
   102bc:	00078513          	mv	a0,a5
   102c0:	01c12083          	lw	ra,28(sp)
   102c4:	01812403          	lw	s0,24(sp)
   102c8:	02010113          	addi	sp,sp,32
   102cc:	00008067          	ret

000102d0 <print_hex>:
   102d0:	fc010113          	addi	sp,sp,-64
   102d4:	02112e23          	sw	ra,60(sp)
   102d8:	02812c23          	sw	s0,56(sp)
   102dc:	04010413          	addi	s0,sp,64
   102e0:	fca42623          	sw	a0,-52(s0)
   102e4:	fd440793          	addi	a5,s0,-44
   102e8:	01378793          	addi	a5,a5,19
   102ec:	fef42623          	sw	a5,-20(s0)
   102f0:	fec42783          	lw	a5,-20(s0)
   102f4:	00a00713          	li	a4,10
   102f8:	00e78023          	sb	a4,0(a5)
   102fc:	fec42783          	lw	a5,-20(s0)
   10300:	fff78793          	addi	a5,a5,-1
   10304:	fef42623          	sw	a5,-20(s0)
   10308:	fcc42783          	lw	a5,-52(s0)
   1030c:	06079e63          	bnez	a5,10388 <print_hex+0xb8>
   10310:	fec42783          	lw	a5,-20(s0)
   10314:	03000713          	li	a4,48
   10318:	00e78023          	sb	a4,0(a5)
   1031c:	fec42783          	lw	a5,-20(s0)
   10320:	fff78793          	addi	a5,a5,-1
   10324:	fef42623          	sw	a5,-20(s0)
   10328:	0680006f          	j	10390 <print_hex+0xc0>
   1032c:	fcc42783          	lw	a5,-52(s0)
   10330:	00f7f793          	andi	a5,a5,15
   10334:	fef42423          	sw	a5,-24(s0)
   10338:	fe842703          	lw	a4,-24(s0)
   1033c:	00900793          	li	a5,9
   10340:	00e7cc63          	blt	a5,a4,10358 <print_hex+0x88>
   10344:	fe842783          	lw	a5,-24(s0)
   10348:	0ff7f793          	zext.b	a5,a5
   1034c:	03078793          	addi	a5,a5,48
   10350:	0ff7f793          	zext.b	a5,a5
   10354:	0140006f          	j	10368 <print_hex+0x98>
   10358:	fe842783          	lw	a5,-24(s0)
   1035c:	0ff7f793          	zext.b	a5,a5
   10360:	05778793          	addi	a5,a5,87
   10364:	0ff7f793          	zext.b	a5,a5
   10368:	fec42703          	lw	a4,-20(s0)
   1036c:	00f70023          	sb	a5,0(a4)
   10370:	fec42783          	lw	a5,-20(s0)
   10374:	fff78793          	addi	a5,a5,-1
   10378:	fef42623          	sw	a5,-20(s0)
   1037c:	fcc42783          	lw	a5,-52(s0)
   10380:	0047d793          	srli	a5,a5,0x4
   10384:	fcf42623          	sw	a5,-52(s0)
   10388:	fcc42783          	lw	a5,-52(s0)
   1038c:	fa0790e3          	bnez	a5,1032c <print_hex+0x5c>
   10390:	fec42783          	lw	a5,-20(s0)
   10394:	00178793          	addi	a5,a5,1
   10398:	fef42623          	sw	a5,-20(s0)
   1039c:	fd440793          	addi	a5,s0,-44
   103a0:	01478793          	addi	a5,a5,20
   103a4:	fec42703          	lw	a4,-20(s0)
   103a8:	40e78733          	sub	a4,a5,a4
   103ac:	fec42783          	lw	a5,-20(s0)
   103b0:	04000893          	li	a7,64
   103b4:	00100513          	li	a0,1
   103b8:	00f005b3          	add	a1,zero,a5
   103bc:	00070613          	mv	a2,a4
   103c0:	00000073          	ecall
   103c4:	00000013          	nop
   103c8:	03c12083          	lw	ra,60(sp)
   103cc:	03812403          	lw	s0,56(sp)
   103d0:	04010113          	addi	sp,sp,64
   103d4:	00008067          	ret

000103d8 <print_dec>:
   103d8:	fc010113          	addi	sp,sp,-64
   103dc:	02112e23          	sw	ra,60(sp)
   103e0:	02812c23          	sw	s0,56(sp)
   103e4:	04010413          	addi	s0,sp,64
   103e8:	fca42623          	sw	a0,-52(s0)
   103ec:	fd840793          	addi	a5,s0,-40
   103f0:	01378793          	addi	a5,a5,19
   103f4:	fef42623          	sw	a5,-20(s0)
   103f8:	fcc42783          	lw	a5,-52(s0)
   103fc:	06079063          	bnez	a5,1045c <print_dec+0x84>
   10400:	fec42783          	lw	a5,-20(s0)
   10404:	03000713          	li	a4,48
   10408:	00e78023          	sb	a4,0(a5)
   1040c:	fec42783          	lw	a5,-20(s0)
   10410:	fff78793          	addi	a5,a5,-1
   10414:	fef42623          	sw	a5,-20(s0)
   10418:	04c0006f          	j	10464 <print_dec+0x8c>
   1041c:	00a00593          	li	a1,10
   10420:	fcc42503          	lw	a0,-52(s0)
   10424:	d55ff0ef          	jal	10178 <umod>
   10428:	00050793          	mv	a5,a0
   1042c:	0ff7f793          	zext.b	a5,a5
   10430:	03078793          	addi	a5,a5,48
   10434:	0ff7f713          	zext.b	a4,a5
   10438:	fec42783          	lw	a5,-20(s0)
   1043c:	00e78023          	sb	a4,0(a5)
   10440:	fec42783          	lw	a5,-20(s0)
   10444:	fff78793          	addi	a5,a5,-1
   10448:	fef42623          	sw	a5,-20(s0)
   1044c:	00a00593          	li	a1,10
   10450:	fcc42503          	lw	a0,-52(s0)
   10454:	c61ff0ef          	jal	100b4 <udiv>
   10458:	fca42623          	sw	a0,-52(s0)
   1045c:	fcc42783          	lw	a5,-52(s0)
   10460:	fa079ee3          	bnez	a5,1041c <print_dec+0x44>
   10464:	fec42783          	lw	a5,-20(s0)
   10468:	00178793          	addi	a5,a5,1
   1046c:	fef42623          	sw	a5,-20(s0)
   10470:	fd840793          	addi	a5,s0,-40
   10474:	01478793          	addi	a5,a5,20
   10478:	fec42703          	lw	a4,-20(s0)
   1047c:	40e78733          	sub	a4,a5,a4
   10480:	fec42783          	lw	a5,-20(s0)
   10484:	04000893          	li	a7,64
   10488:	00100513          	li	a0,1
   1048c:	00f005b3          	add	a1,zero,a5
   10490:	00070613          	mv	a2,a4
   10494:	00000073          	ecall
   10498:	00000013          	nop
   1049c:	03c12083          	lw	ra,60(sp)
   104a0:	03812403          	lw	s0,56(sp)
   104a4:	04010113          	addi	sp,sp,64
   104a8:	00008067          	ret

000104ac <itoa_dec>:
   104ac:	fc010113          	addi	sp,sp,-64
   104b0:	02112e23          	sw	ra,60(sp)
   104b4:	02812c23          	sw	s0,56(sp)
   104b8:	04010413          	addi	s0,sp,64
   104bc:	fca42623          	sw	a0,-52(s0)
   104c0:	fcb42423          	sw	a1,-56(s0)
   104c4:	fd440793          	addi	a5,s0,-44
   104c8:	01378793          	addi	a5,a5,19
   104cc:	fef42623          	sw	a5,-20(s0)
   104d0:	fcc42783          	lw	a5,-52(s0)
   104d4:	06079063          	bnez	a5,10534 <itoa_dec+0x88>
   104d8:	fec42783          	lw	a5,-20(s0)
   104dc:	03000713          	li	a4,48
   104e0:	00e78023          	sb	a4,0(a5)
   104e4:	fec42783          	lw	a5,-20(s0)
   104e8:	fff78793          	addi	a5,a5,-1
   104ec:	fef42623          	sw	a5,-20(s0)
   104f0:	04c0006f          	j	1053c <itoa_dec+0x90>
   104f4:	00a00593          	li	a1,10
   104f8:	fcc42503          	lw	a0,-52(s0)
   104fc:	c7dff0ef          	jal	10178 <umod>
   10500:	00050793          	mv	a5,a0
   10504:	0ff7f793          	zext.b	a5,a5
   10508:	03078793          	addi	a5,a5,48
   1050c:	0ff7f713          	zext.b	a4,a5
   10510:	fec42783          	lw	a5,-20(s0)
   10514:	00e78023          	sb	a4,0(a5)
   10518:	fec42783          	lw	a5,-20(s0)
   1051c:	fff78793          	addi	a5,a5,-1
   10520:	fef42623          	sw	a5,-20(s0)
   10524:	00a00593          	li	a1,10
   10528:	fcc42503          	lw	a0,-52(s0)
   1052c:	b89ff0ef          	jal	100b4 <udiv>
   10530:	fca42623          	sw	a0,-52(s0)
   10534:	fcc42783          	lw	a5,-52(s0)
   10538:	fa079ee3          	bnez	a5,104f4 <itoa_dec+0x48>
   1053c:	fec42783          	lw	a5,-20(s0)
   10540:	00178793          	addi	a5,a5,1
   10544:	fef42623          	sw	a5,-20(s0)
   10548:	fd440793          	addi	a5,s0,-44
   1054c:	01478793          	addi	a5,a5,20
   10550:	fec42703          	lw	a4,-20(s0)
   10554:	40e787b3          	sub	a5,a5,a4
   10558:	fef42423          	sw	a5,-24(s0)
   1055c:	fe842783          	lw	a5,-24(s0)
   10560:	00078613          	mv	a2,a5
   10564:	fec42583          	lw	a1,-20(s0)
   10568:	fc842503          	lw	a0,-56(s0)
   1056c:	ad1ff0ef          	jal	1003c <memcpy>
   10570:	fe842783          	lw	a5,-24(s0)
   10574:	00078513          	mv	a0,a5
   10578:	03c12083          	lw	ra,60(sp)
   1057c:	03812403          	lw	s0,56(sp)
   10580:	04010113          	addi	sp,sp,64
   10584:	00008067          	ret

00010588 <main>:
   10588:	f3010113          	addi	sp,sp,-208
   1058c:	0c112623          	sw	ra,204(sp)
   10590:	0c812423          	sw	s0,200(sp)
   10594:	0d010413          	addi	s0,sp,208
   10598:	000117b7          	lui	a5,0x11
   1059c:	a5878713          	addi	a4,a5,-1448 # 10a58 <finish_game+0x34>
   105a0:	f3440793          	addi	a5,s0,-204
   105a4:	00070693          	mv	a3,a4
   105a8:	04000713          	li	a4,64
   105ac:	00070613          	mv	a2,a4
   105b0:	00068593          	mv	a1,a3
   105b4:	00078513          	mv	a0,a5
   105b8:	a85ff0ef          	jal	1003c <memcpy>
   105bc:	f3440793          	addi	a5,s0,-204
   105c0:	03f00713          	li	a4,63
   105c4:	04000893          	li	a7,64
   105c8:	00100513          	li	a0,1
   105cc:	00f005b3          	add	a1,zero,a5
   105d0:	00070613          	mv	a2,a4
   105d4:	00000073          	ecall
   105d8:	2b4000ef          	jal	1088c <get_cycles>
   105dc:	fea42423          	sw	a0,-24(s0)
   105e0:	feb42623          	sw	a1,-20(s0)
   105e4:	2bc000ef          	jal	108a0 <get_instret>
   105e8:	fea42023          	sw	a0,-32(s0)
   105ec:	feb42223          	sw	a1,-28(s0)
   105f0:	2c4000ef          	jal	108b4 <run_q2_game_hanoi>
   105f4:	fca42e23          	sw	a0,-36(s0)
   105f8:	294000ef          	jal	1088c <get_cycles>
   105fc:	fca42823          	sw	a0,-48(s0)
   10600:	fcb42a23          	sw	a1,-44(s0)
   10604:	29c000ef          	jal	108a0 <get_instret>
   10608:	fca42423          	sw	a0,-56(s0)
   1060c:	fcb42623          	sw	a1,-52(s0)
   10610:	fd042603          	lw	a2,-48(s0)
   10614:	fd442683          	lw	a3,-44(s0)
   10618:	fe842503          	lw	a0,-24(s0)
   1061c:	fec42583          	lw	a1,-20(s0)
   10620:	40a60733          	sub	a4,a2,a0
   10624:	00070813          	mv	a6,a4
   10628:	01063833          	sltu	a6,a2,a6
   1062c:	40b687b3          	sub	a5,a3,a1
   10630:	410786b3          	sub	a3,a5,a6
   10634:	00068793          	mv	a5,a3
   10638:	fce42023          	sw	a4,-64(s0)
   1063c:	fcf42223          	sw	a5,-60(s0)
   10640:	fc842603          	lw	a2,-56(s0)
   10644:	fcc42683          	lw	a3,-52(s0)
   10648:	fe042503          	lw	a0,-32(s0)
   1064c:	fe442583          	lw	a1,-28(s0)
   10650:	40a60733          	sub	a4,a2,a0
   10654:	00070813          	mv	a6,a4
   10658:	01063833          	sltu	a6,a2,a6
   1065c:	40b687b3          	sub	a5,a3,a1
   10660:	410786b3          	sub	a3,a5,a6
   10664:	00068793          	mv	a5,a3
   10668:	fae42c23          	sw	a4,-72(s0)
   1066c:	faf42e23          	sw	a5,-68(s0)
   10670:	fdc42783          	lw	a5,-36(s0)
   10674:	06078663          	beqz	a5,106e0 <main+0x158>
   10678:	000117b7          	lui	a5,0x11
   1067c:	a9878793          	addi	a5,a5,-1384 # 10a98 <finish_game+0x74>
   10680:	0007a883          	lw	a7,0(a5)
   10684:	0047a803          	lw	a6,4(a5)
   10688:	0087a503          	lw	a0,8(a5)
   1068c:	00c7a583          	lw	a1,12(a5)
   10690:	0107a603          	lw	a2,16(a5)
   10694:	0147a683          	lw	a3,20(a5)
   10698:	0187a703          	lw	a4,24(a5)
   1069c:	01c7a783          	lw	a5,28(a5)
   106a0:	f3142a23          	sw	a7,-204(s0)
   106a4:	f3042c23          	sw	a6,-200(s0)
   106a8:	f2a42e23          	sw	a0,-196(s0)
   106ac:	f4b42023          	sw	a1,-192(s0)
   106b0:	f4c42223          	sw	a2,-188(s0)
   106b4:	f4d42423          	sw	a3,-184(s0)
   106b8:	f4e42623          	sw	a4,-180(s0)
   106bc:	f4f42823          	sw	a5,-176(s0)
   106c0:	f3440793          	addi	a5,s0,-204
   106c4:	01f00713          	li	a4,31
   106c8:	04000893          	li	a7,64
   106cc:	00100513          	li	a0,1
   106d0:	00f005b3          	add	a1,zero,a5
   106d4:	00070613          	mv	a2,a4
   106d8:	00000073          	ecall
   106dc:	0680006f          	j	10744 <main+0x1bc>
   106e0:	000117b7          	lui	a5,0x11
   106e4:	ab878793          	addi	a5,a5,-1352 # 10ab8 <finish_game+0x94>
   106e8:	0007a883          	lw	a7,0(a5)
   106ec:	0047a803          	lw	a6,4(a5)
   106f0:	0087a503          	lw	a0,8(a5)
   106f4:	00c7a583          	lw	a1,12(a5)
   106f8:	0107a603          	lw	a2,16(a5)
   106fc:	0147a683          	lw	a3,20(a5)
   10700:	0187a703          	lw	a4,24(a5)
   10704:	01c7a783          	lw	a5,28(a5)
   10708:	f3142a23          	sw	a7,-204(s0)
   1070c:	f3042c23          	sw	a6,-200(s0)
   10710:	f2a42e23          	sw	a0,-196(s0)
   10714:	f4b42023          	sw	a1,-192(s0)
   10718:	f4c42223          	sw	a2,-188(s0)
   1071c:	f4d42423          	sw	a3,-184(s0)
   10720:	f4e42623          	sw	a4,-180(s0)
   10724:	f4f42823          	sw	a5,-176(s0)
   10728:	f3440793          	addi	a5,s0,-204
   1072c:	01f00713          	li	a4,31
   10730:	04000893          	li	a7,64
   10734:	00100513          	li	a0,1
   10738:	00f005b3          	add	a1,zero,a5
   1073c:	00070613          	mv	a2,a4
   10740:	00000073          	ecall
   10744:	000117b7          	lui	a5,0x11
   10748:	ad878793          	addi	a5,a5,-1320 # 10ad8 <finish_game+0xb4>
   1074c:	0007a683          	lw	a3,0(a5)
   10750:	0047a703          	lw	a4,4(a5)
   10754:	fad42623          	sw	a3,-84(s0)
   10758:	fae42823          	sw	a4,-80(s0)
   1075c:	0087d703          	lhu	a4,8(a5)
   10760:	fae41a23          	sh	a4,-76(s0)
   10764:	00a7c783          	lbu	a5,10(a5)
   10768:	faf40b23          	sb	a5,-74(s0)
   1076c:	fac40793          	addi	a5,s0,-84
   10770:	00a00713          	li	a4,10
   10774:	04000893          	li	a7,64
   10778:	00100513          	li	a0,1
   1077c:	00f005b3          	add	a1,zero,a5
   10780:	00070613          	mv	a2,a4
   10784:	00000073          	ecall
   10788:	fc042783          	lw	a5,-64(s0)
   1078c:	00078513          	mv	a0,a5
   10790:	c49ff0ef          	jal	103d8 <print_dec>
   10794:	000117b7          	lui	a5,0x11
   10798:	ae478793          	addi	a5,a5,-1308 # 10ae4 <finish_game+0xc0>
   1079c:	0007a583          	lw	a1,0(a5)
   107a0:	0047a603          	lw	a2,4(a5)
   107a4:	0087a683          	lw	a3,8(a5)
   107a8:	00c7a703          	lw	a4,12(a5)
   107ac:	f8b42c23          	sw	a1,-104(s0)
   107b0:	f8c42e23          	sw	a2,-100(s0)
   107b4:	fad42023          	sw	a3,-96(s0)
   107b8:	fae42223          	sw	a4,-92(s0)
   107bc:	0107c783          	lbu	a5,16(a5)
   107c0:	faf40423          	sb	a5,-88(s0)
   107c4:	f9840793          	addi	a5,s0,-104
   107c8:	01000713          	li	a4,16
   107cc:	04000893          	li	a7,64
   107d0:	00100513          	li	a0,1
   107d4:	00f005b3          	add	a1,zero,a5
   107d8:	00070613          	mv	a2,a4
   107dc:	00000073          	ecall
   107e0:	fb842783          	lw	a5,-72(s0)
   107e4:	00078513          	mv	a0,a5
   107e8:	bf1ff0ef          	jal	103d8 <print_dec>
   107ec:	00a00793          	li	a5,10
   107f0:	f8f41a23          	sh	a5,-108(s0)
   107f4:	f9440793          	addi	a5,s0,-108
   107f8:	00100713          	li	a4,1
   107fc:	04000893          	li	a7,64
   10800:	00100513          	li	a0,1
   10804:	00f005b3          	add	a1,zero,a5
   10808:	00070613          	mv	a2,a4
   1080c:	00000073          	ecall
   10810:	000117b7          	lui	a5,0x11
   10814:	af878793          	addi	a5,a5,-1288 # 10af8 <finish_game+0xd4>
   10818:	0007a883          	lw	a7,0(a5)
   1081c:	0047a803          	lw	a6,4(a5)
   10820:	0087a503          	lw	a0,8(a5)
   10824:	00c7a583          	lw	a1,12(a5)
   10828:	0107a603          	lw	a2,16(a5)
   1082c:	0147a683          	lw	a3,20(a5)
   10830:	0187a703          	lw	a4,24(a5)
   10834:	f7142a23          	sw	a7,-140(s0)
   10838:	f7042c23          	sw	a6,-136(s0)
   1083c:	f6a42e23          	sw	a0,-132(s0)
   10840:	f8b42023          	sw	a1,-128(s0)
   10844:	f8c42223          	sw	a2,-124(s0)
   10848:	f8d42423          	sw	a3,-120(s0)
   1084c:	f8e42623          	sw	a4,-116(s0)
   10850:	01c7d783          	lhu	a5,28(a5)
   10854:	f8f41823          	sh	a5,-112(s0)
   10858:	f7440793          	addi	a5,s0,-140
   1085c:	01d00713          	li	a4,29
   10860:	04000893          	li	a7,64
   10864:	00100513          	li	a0,1
   10868:	00f005b3          	add	a1,zero,a5
   1086c:	00070613          	mv	a2,a4
   10870:	00000073          	ecall
   10874:	00000793          	li	a5,0
   10878:	00078513          	mv	a0,a5
   1087c:	0cc12083          	lw	ra,204(sp)
   10880:	0c812403          	lw	s0,200(sp)
   10884:	0d010113          	addi	sp,sp,208
   10888:	00008067          	ret

0001088c <get_cycles>:
   1088c:	c80025f3          	rdcycleh	a1
   10890:	c0002573          	rdcycle	a0
   10894:	c8002673          	rdcycleh	a2
   10898:	fec59ae3          	bne	a1,a2,1088c <get_cycles>
   1089c:	00008067          	ret

000108a0 <get_instret>:
   108a0:	c82025f3          	rdinstreth	a1
   108a4:	c0202573          	rdinstret	a0
   108a8:	c8202673          	rdinstreth	a2
   108ac:	fec59ae3          	bne	a1,a2,108a0 <get_instret>
   108b0:	00008067          	ret

000108b4 <run_q2_game_hanoi>:
   108b4:	fc010113          	addi	sp,sp,-64
   108b8:	00812023          	sw	s0,0(sp)
   108bc:	00912223          	sw	s1,4(sp)
   108c0:	01212423          	sw	s2,8(sp)
   108c4:	01312623          	sw	s3,12(sp)
   108c8:	01412823          	sw	s4,16(sp)
   108cc:	00112a23          	sw	ra,20(sp)
   108d0:	01512c23          	sw	s5,24(sp)
   108d4:	01612e23          	sw	s6,28(sp)
   108d8:	03712023          	sw	s7,32(sp)
   108dc:	03812223          	sw	s8,36(sp)
   108e0:	03912423          	sw	s9,40(sp)
   108e4:	00000a97          	auipc	s5,0x0
   108e8:	236a8a93          	addi	s5,s5,566 # 10b1a <str1>
   108ec:	00000b17          	auipc	s6,0x0
   108f0:	239b0b13          	addi	s6,s6,569 # 10b25 <str2>
   108f4:	00000b97          	auipc	s7,0x0
   108f8:	238b8b93          	addi	s7,s7,568 # 10b2c <str3>
   108fc:	00000c17          	auipc	s8,0x0
   10900:	235c0c13          	addi	s8,s8,565 # 10b31 <str_nl>
   10904:	00000c97          	auipc	s9,0x0
   10908:	212c8c93          	addi	s9,s9,530 # 10b16 <peg_names>
   1090c:	03010a13          	addi	s4,sp,48
   10910:	000a2023          	sw	zero,0(s4)
   10914:	000a2223          	sw	zero,4(s4)
   10918:	000a2423          	sw	zero,8(s4)
   1091c:	00100413          	li	s0,1

00010920 <game_loop>:
   10920:	00800293          	li	t0,8
   10924:	10540063          	beq	s0,t0,10a24 <finish_game>
   10928:	00145293          	srli	t0,s0,0x1
   1092c:	00544333          	xor	t1,s0,t0
   10930:	fff40393          	addi	t2,s0,-1
   10934:	0013de13          	srli	t3,t2,0x1
   10938:	01c3c3b3          	xor	t2,t2,t3
   1093c:	007342b3          	xor	t0,t1,t2
   10940:	00000493          	li	s1,0
   10944:	0012f313          	andi	t1,t0,1
   10948:	00031a63          	bnez	t1,1095c <disk_found>
   1094c:	00100493          	li	s1,1
   10950:	0022f313          	andi	t1,t0,2
   10954:	00031463          	bnez	t1,1095c <disk_found>
   10958:	00200493          	li	s1,2

0001095c <disk_found>:
   1095c:	00249293          	slli	t0,s1,0x2
   10960:	005a02b3          	add	t0,s4,t0
   10964:	0002a903          	lw	s2,0(t0)
   10968:	00049c63          	bnez	s1,10980 <handle_large>
   1096c:	00290993          	addi	s3,s2,2
   10970:	00300313          	li	t1,3
   10974:	0069ce63          	blt	s3,t1,10990 <display_move>
   10978:	406989b3          	sub	s3,s3,t1
   1097c:	0140006f          	j	10990 <display_move>

00010980 <handle_large>:
   10980:	000a2303          	lw	t1,0(s4)
   10984:	00300993          	li	s3,3
   10988:	412989b3          	sub	s3,s3,s2
   1098c:	406989b3          	sub	s3,s3,t1

00010990 <display_move>:
   10990:	04000893          	li	a7,64
   10994:	00100513          	li	a0,1
   10998:	000a8593          	mv	a1,s5
   1099c:	00b00613          	li	a2,11
   109a0:	00000073          	ecall
   109a4:	00148513          	addi	a0,s1,1
   109a8:	a31ff0ef          	jal	103d8 <print_dec>
   109ac:	04000893          	li	a7,64
   109b0:	00100513          	li	a0,1
   109b4:	000b0593          	mv	a1,s6
   109b8:	00600613          	li	a2,6
   109bc:	00000073          	ecall
   109c0:	012c85b3          	add	a1,s9,s2
   109c4:	04000893          	li	a7,64
   109c8:	00100513          	li	a0,1
   109cc:	00100613          	li	a2,1
   109d0:	00000073          	ecall
   109d4:	04000893          	li	a7,64
   109d8:	00100513          	li	a0,1
   109dc:	000b8593          	mv	a1,s7
   109e0:	00400613          	li	a2,4
   109e4:	00000073          	ecall
   109e8:	013c85b3          	add	a1,s9,s3
   109ec:	04000893          	li	a7,64
   109f0:	00100513          	li	a0,1
   109f4:	00100613          	li	a2,1
   109f8:	00000073          	ecall
   109fc:	04000893          	li	a7,64
   10a00:	00100513          	li	a0,1
   10a04:	000c0593          	mv	a1,s8
   10a08:	00100613          	li	a2,1
   10a0c:	00000073          	ecall
   10a10:	00249293          	slli	t0,s1,0x2
   10a14:	005a02b3          	add	t0,s4,t0
   10a18:	0132a023          	sw	s3,0(t0)
   10a1c:	00140413          	addi	s0,s0,1
   10a20:	f01ff06f          	j	10920 <game_loop>

00010a24 <finish_game>:
   10a24:	00012403          	lw	s0,0(sp)
   10a28:	00412483          	lw	s1,4(sp)
   10a2c:	00812903          	lw	s2,8(sp)
   10a30:	00c12983          	lw	s3,12(sp)
   10a34:	01012a03          	lw	s4,16(sp)
   10a38:	01412083          	lw	ra,20(sp)
   10a3c:	01812a83          	lw	s5,24(sp)
   10a40:	01c12b03          	lw	s6,28(sp)
   10a44:	02012b83          	lw	s7,32(sp)
   10a48:	02412c03          	lw	s8,36(sp)
   10a4c:	02812c83          	lw	s9,40(sp)
   10a50:	04010113          	addi	sp,sp,64
   10a54:	00008067          	ret
