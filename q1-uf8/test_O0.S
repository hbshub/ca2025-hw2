
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00010000 <_start>:
   10000:	00002117          	auipc	sp,0x2
   10004:	be010113          	addi	sp,sp,-1056 # 11be0 <__stack_top>
   10008:	00001297          	auipc	t0,0x1
   1000c:	bcf28293          	addi	t0,t0,-1073 # 10bd7 <__bss_end>
   10010:	00001317          	auipc	t1,0x1
   10014:	bc730313          	addi	t1,t1,-1081 # 10bd7 <__bss_end>
   10018:	0062d863          	bge	t0,t1,10028 <_start+0x28>
   1001c:	0002a023          	sw	zero,0(t0)
   10020:	00428293          	addi	t0,t0,4
   10024:	ff5ff06f          	j	10018 <_start+0x18>
   10028:	484000ef          	jal	104ac <main>
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

000104ac <main>:
   104ac:	ef010113          	addi	sp,sp,-272
   104b0:	10112623          	sw	ra,268(sp)
   104b4:	10812423          	sw	s0,264(sp)
   104b8:	11010413          	addi	s0,sp,272
   104bc:	000117b7          	lui	a5,0x11
   104c0:	ac478713          	addi	a4,a5,-1340 # 10ac4 <print_suc_msg+0x14>
   104c4:	ef840793          	addi	a5,s0,-264
   104c8:	00070693          	mv	a3,a4
   104cc:	03900713          	li	a4,57
   104d0:	00070613          	mv	a2,a4
   104d4:	00068593          	mv	a1,a3
   104d8:	00078513          	mv	a0,a5
   104dc:	b61ff0ef          	jal	1003c <memcpy>
   104e0:	ef840793          	addi	a5,s0,-264
   104e4:	03800713          	li	a4,56
   104e8:	04000893          	li	a7,64
   104ec:	00100513          	li	a0,1
   104f0:	00f005b3          	add	a1,zero,a5
   104f4:	00070613          	mv	a2,a4
   104f8:	00000073          	ecall
   104fc:	2b4000ef          	jal	107b0 <get_cycles>
   10500:	fea42423          	sw	a0,-24(s0)
   10504:	feb42623          	sw	a1,-20(s0)
   10508:	2bc000ef          	jal	107c4 <get_instret>
   1050c:	fea42023          	sw	a0,-32(s0)
   10510:	feb42223          	sw	a1,-28(s0)
   10514:	2c4000ef          	jal	107d8 <run_q1_uf8>
   10518:	fca42e23          	sw	a0,-36(s0)
   1051c:	294000ef          	jal	107b0 <get_cycles>
   10520:	fca42823          	sw	a0,-48(s0)
   10524:	fcb42a23          	sw	a1,-44(s0)
   10528:	29c000ef          	jal	107c4 <get_instret>
   1052c:	fca42423          	sw	a0,-56(s0)
   10530:	fcb42623          	sw	a1,-52(s0)
   10534:	fd042603          	lw	a2,-48(s0)
   10538:	fd442683          	lw	a3,-44(s0)
   1053c:	fe842503          	lw	a0,-24(s0)
   10540:	fec42583          	lw	a1,-20(s0)
   10544:	40a60733          	sub	a4,a2,a0
   10548:	00070813          	mv	a6,a4
   1054c:	01063833          	sltu	a6,a2,a6
   10550:	40b687b3          	sub	a5,a3,a1
   10554:	410786b3          	sub	a3,a5,a6
   10558:	00068793          	mv	a5,a3
   1055c:	fce42023          	sw	a4,-64(s0)
   10560:	fcf42223          	sw	a5,-60(s0)
   10564:	fc842603          	lw	a2,-56(s0)
   10568:	fcc42683          	lw	a3,-52(s0)
   1056c:	fe042503          	lw	a0,-32(s0)
   10570:	fe442583          	lw	a1,-28(s0)
   10574:	40a60733          	sub	a4,a2,a0
   10578:	00070813          	mv	a6,a4
   1057c:	01063833          	sltu	a6,a2,a6
   10580:	40b687b3          	sub	a5,a3,a1
   10584:	410786b3          	sub	a3,a5,a6
   10588:	00068793          	mv	a5,a3
   1058c:	fae42c23          	sw	a4,-72(s0)
   10590:	faf42e23          	sw	a5,-68(s0)
   10594:	fdc42783          	lw	a5,-36(s0)
   10598:	06078663          	beqz	a5,10604 <main+0x158>
   1059c:	000117b7          	lui	a5,0x11
   105a0:	b0078793          	addi	a5,a5,-1280 # 10b00 <print_suc_msg+0x50>
   105a4:	0007a883          	lw	a7,0(a5)
   105a8:	0047a803          	lw	a6,4(a5)
   105ac:	0087a503          	lw	a0,8(a5)
   105b0:	00c7a583          	lw	a1,12(a5)
   105b4:	0107a603          	lw	a2,16(a5)
   105b8:	0147a683          	lw	a3,20(a5)
   105bc:	0187a703          	lw	a4,24(a5)
   105c0:	f9142c23          	sw	a7,-104(s0)
   105c4:	f9042e23          	sw	a6,-100(s0)
   105c8:	faa42023          	sw	a0,-96(s0)
   105cc:	fab42223          	sw	a1,-92(s0)
   105d0:	fac42423          	sw	a2,-88(s0)
   105d4:	fad42623          	sw	a3,-84(s0)
   105d8:	fae42823          	sw	a4,-80(s0)
   105dc:	01c7c783          	lbu	a5,28(a5)
   105e0:	faf40a23          	sb	a5,-76(s0)
   105e4:	f9840793          	addi	a5,s0,-104
   105e8:	01c00713          	li	a4,28
   105ec:	04000893          	li	a7,64
   105f0:	00100513          	li	a0,1
   105f4:	00f005b3          	add	a1,zero,a5
   105f8:	00070613          	mv	a2,a4
   105fc:	00000073          	ecall
   10600:	0680006f          	j	10668 <main+0x1bc>
   10604:	000117b7          	lui	a5,0x11
   10608:	b2078793          	addi	a5,a5,-1248 # 10b20 <print_suc_msg+0x70>
   1060c:	0007a883          	lw	a7,0(a5)
   10610:	0047a803          	lw	a6,4(a5)
   10614:	0087a503          	lw	a0,8(a5)
   10618:	00c7a583          	lw	a1,12(a5)
   1061c:	0107a603          	lw	a2,16(a5)
   10620:	0147a683          	lw	a3,20(a5)
   10624:	0187a703          	lw	a4,24(a5)
   10628:	f7142c23          	sw	a7,-136(s0)
   1062c:	f7042e23          	sw	a6,-132(s0)
   10630:	f8a42023          	sw	a0,-128(s0)
   10634:	f8b42223          	sw	a1,-124(s0)
   10638:	f8c42423          	sw	a2,-120(s0)
   1063c:	f8d42623          	sw	a3,-116(s0)
   10640:	f8e42823          	sw	a4,-112(s0)
   10644:	01c7c783          	lbu	a5,28(a5)
   10648:	f8f40a23          	sb	a5,-108(s0)
   1064c:	f7840793          	addi	a5,s0,-136
   10650:	01c00713          	li	a4,28
   10654:	04000893          	li	a7,64
   10658:	00100513          	li	a0,1
   1065c:	00f005b3          	add	a1,zero,a5
   10660:	00070613          	mv	a2,a4
   10664:	00000073          	ecall
   10668:	000117b7          	lui	a5,0x11
   1066c:	b4078793          	addi	a5,a5,-1216 # 10b40 <print_suc_msg+0x90>
   10670:	0007a683          	lw	a3,0(a5)
   10674:	0047a703          	lw	a4,4(a5)
   10678:	f6d42623          	sw	a3,-148(s0)
   1067c:	f6e42823          	sw	a4,-144(s0)
   10680:	0087d703          	lhu	a4,8(a5)
   10684:	f6e41a23          	sh	a4,-140(s0)
   10688:	00a7c783          	lbu	a5,10(a5)
   1068c:	f6f40b23          	sb	a5,-138(s0)
   10690:	f6c40793          	addi	a5,s0,-148
   10694:	00a00713          	li	a4,10
   10698:	04000893          	li	a7,64
   1069c:	00100513          	li	a0,1
   106a0:	00f005b3          	add	a1,zero,a5
   106a4:	00070613          	mv	a2,a4
   106a8:	00000073          	ecall
   106ac:	fc042783          	lw	a5,-64(s0)
   106b0:	00078513          	mv	a0,a5
   106b4:	d25ff0ef          	jal	103d8 <print_dec>
   106b8:	000117b7          	lui	a5,0x11
   106bc:	b4c78793          	addi	a5,a5,-1204 # 10b4c <print_suc_msg+0x9c>
   106c0:	0007a583          	lw	a1,0(a5)
   106c4:	0047a603          	lw	a2,4(a5)
   106c8:	0087a683          	lw	a3,8(a5)
   106cc:	00c7a703          	lw	a4,12(a5)
   106d0:	f4b42c23          	sw	a1,-168(s0)
   106d4:	f4c42e23          	sw	a2,-164(s0)
   106d8:	f6d42023          	sw	a3,-160(s0)
   106dc:	f6e42223          	sw	a4,-156(s0)
   106e0:	0107c783          	lbu	a5,16(a5)
   106e4:	f6f40423          	sb	a5,-152(s0)
   106e8:	f5840793          	addi	a5,s0,-168
   106ec:	01000713          	li	a4,16
   106f0:	04000893          	li	a7,64
   106f4:	00100513          	li	a0,1
   106f8:	00f005b3          	add	a1,zero,a5
   106fc:	00070613          	mv	a2,a4
   10700:	00000073          	ecall
   10704:	fb842783          	lw	a5,-72(s0)
   10708:	00078513          	mv	a0,a5
   1070c:	ccdff0ef          	jal	103d8 <print_dec>
   10710:	00a00793          	li	a5,10
   10714:	f4f41a23          	sh	a5,-172(s0)
   10718:	f5440793          	addi	a5,s0,-172
   1071c:	00100713          	li	a4,1
   10720:	04000893          	li	a7,64
   10724:	00100513          	li	a0,1
   10728:	00f005b3          	add	a1,zero,a5
   1072c:	00070613          	mv	a2,a4
   10730:	00000073          	ecall
   10734:	000117b7          	lui	a5,0x11
   10738:	b6078793          	addi	a5,a5,-1184 # 10b60 <print_suc_msg+0xb0>
   1073c:	0007a883          	lw	a7,0(a5)
   10740:	0047a803          	lw	a6,4(a5)
   10744:	0087a503          	lw	a0,8(a5)
   10748:	00c7a583          	lw	a1,12(a5)
   1074c:	0107a603          	lw	a2,16(a5)
   10750:	0147a683          	lw	a3,20(a5)
   10754:	0187a703          	lw	a4,24(a5)
   10758:	f3142a23          	sw	a7,-204(s0)
   1075c:	f3042c23          	sw	a6,-200(s0)
   10760:	f2a42e23          	sw	a0,-196(s0)
   10764:	f4b42023          	sw	a1,-192(s0)
   10768:	f4c42223          	sw	a2,-188(s0)
   1076c:	f4d42423          	sw	a3,-184(s0)
   10770:	f4e42623          	sw	a4,-180(s0)
   10774:	01c7d783          	lhu	a5,28(a5)
   10778:	f4f41823          	sh	a5,-176(s0)
   1077c:	f3440793          	addi	a5,s0,-204
   10780:	01d00713          	li	a4,29
   10784:	04000893          	li	a7,64
   10788:	00100513          	li	a0,1
   1078c:	00f005b3          	add	a1,zero,a5
   10790:	00070613          	mv	a2,a4
   10794:	00000073          	ecall
   10798:	00000793          	li	a5,0
   1079c:	00078513          	mv	a0,a5
   107a0:	10c12083          	lw	ra,268(sp)
   107a4:	10812403          	lw	s0,264(sp)
   107a8:	11010113          	addi	sp,sp,272
   107ac:	00008067          	ret

000107b0 <get_cycles>:
   107b0:	c80025f3          	rdcycleh	a1
   107b4:	c0002573          	rdcycle	a0
   107b8:	c8002673          	rdcycleh	a2
   107bc:	fec59ae3          	bne	a1,a2,107b0 <get_cycles>
   107c0:	00008067          	ret

000107c4 <get_instret>:
   107c4:	c82025f3          	rdinstreth	a1
   107c8:	c0202573          	rdinstret	a0
   107cc:	c8202673          	rdinstreth	a2
   107d0:	fec59ae3          	bne	a1,a2,107c4 <get_instret>
   107d4:	00008067          	ret

000107d8 <run_q1_uf8>:
   107d8:	fe010113          	addi	sp,sp,-32
   107dc:	00112e23          	sw	ra,28(sp)
   107e0:	00812c23          	sw	s0,24(sp)
   107e4:	00912a23          	sw	s1,20(sp)
   107e8:	01212823          	sw	s2,16(sp)
   107ec:	01312623          	sw	s3,12(sp)
   107f0:	01512423          	sw	s5,8(sp)
   107f4:	00000413          	li	s0,0
   107f8:	fff00493          	li	s1,-1
   107fc:	10000913          	li	s2,256
   10800:	00100993          	li	s3,1
   10804:	00f00a93          	li	s5,15
   10808:	028000ef          	jal	10830 <test>
   1080c:	2a051263          	bnez	a0,10ab0 <print_suc_msg>

00010810 <main_c>:
   10810:	01c12083          	lw	ra,28(sp)
   10814:	01812403          	lw	s0,24(sp)
   10818:	01412483          	lw	s1,20(sp)
   1081c:	01012903          	lw	s2,16(sp)
   10820:	00c12983          	lw	s3,12(sp)
   10824:	00812a83          	lw	s5,8(sp)
   10828:	02010113          	addi	sp,sp,32
   1082c:	00008067          	ret

00010830 <test>:
   10830:	ff010113          	addi	sp,sp,-16
   10834:	00112623          	sw	ra,12(sp)
   10838:	01412423          	sw	s4,8(sp)

0001083c <loop>:
   1083c:	06090063          	beqz	s2,1089c <test_end>
   10840:	0ff47513          	zext.b	a0,s0
   10844:	00455293          	srli	t0,a0,0x4
   10848:	00f57513          	andi	a0,a0,15
   1084c:	01050513          	addi	a0,a0,16
   10850:	00551533          	sll	a0,a0,t0
   10854:	ff050513          	addi	a0,a0,-16
   10858:	00050a13          	mv	s4,a0
   1085c:	054000ef          	jal	108b0 <uf8_encode>
   10860:	0ff57513          	zext.b	a0,a0
   10864:	02a41263          	bne	s0,a0,10888 <set_fail>

00010868 <check_mono_inc>:
   10868:	0144c863          	blt	s1,s4,10878 <ok>
   1086c:	00000993          	li	s3,0
   10870:	00100e13          	li	t3,1
   10874:	178000ef          	jal	109ec <print_fail_msg>

00010878 <ok>:
   10878:	000a0493          	mv	s1,s4
   1087c:	00140413          	addi	s0,s0,1
   10880:	fff90913          	addi	s2,s2,-1
   10884:	fb9ff06f          	j	1083c <loop>

00010888 <set_fail>:
   10888:	00000993          	li	s3,0
   1088c:	00000e13          	li	t3,0
   10890:	00050e93          	mv	t4,a0
   10894:	158000ef          	jal	109ec <print_fail_msg>
   10898:	fd1ff06f          	j	10868 <check_mono_inc>

0001089c <test_end>:
   1089c:	00098513          	mv	a0,s3
   108a0:	00c12083          	lw	ra,12(sp)
   108a4:	00812a03          	lw	s4,8(sp)
   108a8:	01010113          	addi	sp,sp,16
   108ac:	00008067          	ret

000108b0 <uf8_encode>:
   108b0:	01000e13          	li	t3,16
   108b4:	01c55463          	bge	a0,t3,108bc <e_not_zero>
   108b8:	00008067          	ret

000108bc <e_not_zero>:
   108bc:	ff010113          	addi	sp,sp,-16
   108c0:	00112623          	sw	ra,12(sp)
   108c4:	00050e93          	mv	t4,a0
   108c8:	0a0000ef          	jal	10968 <clz>
   108cc:	01f00e13          	li	t3,31
   108d0:	40ae02b3          	sub	t0,t3,a0
   108d4:	000e8513          	mv	a0,t4
   108d8:	00c12083          	lw	ra,12(sp)
   108dc:	01010113          	addi	sp,sp,16
   108e0:	00000313          	li	t1,0
   108e4:	00000393          	li	t2,0
   108e8:	00500e13          	li	t3,5
   108ec:	05c2c263          	blt	t0,t3,10930 <find_exa_exp>
   108f0:	ffc28313          	addi	t1,t0,-4
   108f4:	01033e13          	sltiu	t3,t1,16
   108f8:	000e0463          	beqz	t3,10900 <set_exp_15>
   108fc:	0080006f          	j	10904 <build_of_once>

00010900 <set_exp_15>:
   10900:	00f00313          	li	t1,15

00010904 <build_of_once>:
   10904:	00100393          	li	t2,1
   10908:	006393b3          	sll	t2,t2,t1
   1090c:	fff38393          	addi	t2,t2,-1
   10910:	00439393          	slli	t2,t2,0x4
   10914:	0040006f          	j	10918 <adj_exp>

00010918 <adj_exp>:
   10918:	00605c63          	blez	t1,10930 <find_exa_exp>
   1091c:	00755a63          	bge	a0,t2,10930 <find_exa_exp>
   10920:	ff038393          	addi	t2,t2,-16
   10924:	0013d393          	srli	t2,t2,0x1
   10928:	fff30313          	addi	t1,t1,-1
   1092c:	fedff06f          	j	10918 <adj_exp>

00010930 <find_exa_exp>:
   10930:	01535e63          	bge	t1,s5,1094c <calc_m>
   10934:	00139293          	slli	t0,t2,0x1
   10938:	01028293          	addi	t0,t0,16
   1093c:	00554863          	blt	a0,t0,1094c <calc_m>
   10940:	00028393          	mv	t2,t0
   10944:	00130313          	addi	t1,t1,1
   10948:	fe9ff06f          	j	10930 <find_exa_exp>

0001094c <calc_m>:
   1094c:	407502b3          	sub	t0,a0,t2
   10950:	0062d2b3          	srl	t0,t0,t1
   10954:	005ad463          	bge	s5,t0,1095c <cmb_num>
   10958:	00f00293          	li	t0,15

0001095c <cmb_num>:
   1095c:	00431313          	slli	t1,t1,0x4
   10960:	00536533          	or	a0,t1,t0
   10964:	00008067          	ret

00010968 <clz>:
   10968:	04050e63          	beqz	a0,109c4 <clz_zero>
   1096c:	00000293          	li	t0,0
   10970:	01055313          	srli	t1,a0,0x10
   10974:	00031663          	bnez	t1,10980 <check_8_bits>
   10978:	01028293          	addi	t0,t0,16
   1097c:	01051513          	slli	a0,a0,0x10

00010980 <check_8_bits>:
   10980:	01855313          	srli	t1,a0,0x18
   10984:	00031663          	bnez	t1,10990 <check_4_bits>
   10988:	00828293          	addi	t0,t0,8
   1098c:	00851513          	slli	a0,a0,0x8

00010990 <check_4_bits>:
   10990:	01c55313          	srli	t1,a0,0x1c
   10994:	00031663          	bnez	t1,109a0 <check_2_bits>
   10998:	00428293          	addi	t0,t0,4
   1099c:	00451513          	slli	a0,a0,0x4

000109a0 <check_2_bits>:
   109a0:	01e55313          	srli	t1,a0,0x1e
   109a4:	00031663          	bnez	t1,109b0 <check_1_bit>
   109a8:	00228293          	addi	t0,t0,2
   109ac:	00251513          	slli	a0,a0,0x2

000109b0 <check_1_bit>:
   109b0:	01f55313          	srli	t1,a0,0x1f
   109b4:	00031463          	bnez	t1,109bc <clz_finish>
   109b8:	00128293          	addi	t0,t0,1

000109bc <clz_finish>:
   109bc:	00028513          	mv	a0,t0
   109c0:	00008067          	ret

000109c4 <clz_zero>:
   109c4:	02000513          	li	a0,32
   109c8:	00008067          	ret

000109cc <printstr_asm>:
   109cc:	00050313          	mv	t1,a0
   109d0:	00058393          	mv	t2,a1
   109d4:	04000893          	li	a7,64
   109d8:	00100513          	li	a0,1
   109dc:	00030593          	mv	a1,t1
   109e0:	00038613          	mv	a2,t2
   109e4:	00000073          	ecall
   109e8:	00008067          	ret

000109ec <print_fail_msg>:
   109ec:	ff010113          	addi	sp,sp,-16
   109f0:	00112623          	sw	ra,12(sp)
   109f4:	00812423          	sw	s0,8(sp)
   109f8:	00912223          	sw	s1,4(sp)
   109fc:	01412023          	sw	s4,0(sp)
   10a00:	040e1863          	bnez	t3,10a50 <t3_1>
   10a04:	00040513          	mv	a0,s0
   10a08:	9d1ff0ef          	jal	103d8 <print_dec>
   10a0c:	00000517          	auipc	a0,0x0
   10a10:	17250513          	addi	a0,a0,370 # 10b7e <str1>
   10a14:	01200593          	li	a1,18
   10a18:	fb5ff0ef          	jal	109cc <printstr_asm>
   10a1c:	000a0513          	mv	a0,s4
   10a20:	9b9ff0ef          	jal	103d8 <print_dec>
   10a24:	00000517          	auipc	a0,0x0
   10a28:	16c50513          	addi	a0,a0,364 # 10b90 <str2>
   10a2c:	01600593          	li	a1,22
   10a30:	f9dff0ef          	jal	109cc <printstr_asm>
   10a34:	000e8513          	mv	a0,t4
   10a38:	9a1ff0ef          	jal	103d8 <print_dec>
   10a3c:	00000517          	auipc	a0,0x0
   10a40:	18750513          	addi	a0,a0,391 # 10bc3 <str5>
   10a44:	00200593          	li	a1,2
   10a48:	f85ff0ef          	jal	109cc <printstr_asm>
   10a4c:	04c0006f          	j	10a98 <print_fail_end>

00010a50 <t3_1>:
   10a50:	00040513          	mv	a0,s0
   10a54:	985ff0ef          	jal	103d8 <print_dec>
   10a58:	00000517          	auipc	a0,0x0
   10a5c:	14e50513          	addi	a0,a0,334 # 10ba6 <str3>
   10a60:	00900593          	li	a1,9
   10a64:	f69ff0ef          	jal	109cc <printstr_asm>
   10a68:	000a0513          	mv	a0,s4
   10a6c:	96dff0ef          	jal	103d8 <print_dec>
   10a70:	00000517          	auipc	a0,0x0
   10a74:	13f50513          	addi	a0,a0,319 # 10baf <str4>
   10a78:	01400593          	li	a1,20
   10a7c:	f51ff0ef          	jal	109cc <printstr_asm>
   10a80:	00048513          	mv	a0,s1
   10a84:	955ff0ef          	jal	103d8 <print_dec>
   10a88:	00000517          	auipc	a0,0x0
   10a8c:	13b50513          	addi	a0,a0,315 # 10bc3 <str5>
   10a90:	00200593          	li	a1,2
   10a94:	f39ff0ef          	jal	109cc <printstr_asm>

00010a98 <print_fail_end>:
   10a98:	00c12083          	lw	ra,12(sp)
   10a9c:	00812403          	lw	s0,8(sp)
   10aa0:	00412483          	lw	s1,4(sp)
   10aa4:	00012a03          	lw	s4,0(sp)
   10aa8:	01010113          	addi	sp,sp,16
   10aac:	00008067          	ret

00010ab0 <print_suc_msg>:
   10ab0:	00000517          	auipc	a0,0x0
   10ab4:	11550513          	addi	a0,a0,277 # 10bc5 <str6>
   10ab8:	01200593          	li	a1,18
   10abc:	f11ff0ef          	jal	109cc <printstr_asm>
   10ac0:	d51ff06f          	j	10810 <main_c>
