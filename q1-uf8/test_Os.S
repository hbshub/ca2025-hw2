
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00010000 <_start>:
   10000:	00001117          	auipc	sp,0x1
   10004:	70010113          	addi	sp,sp,1792 # 11700 <__stack_top>
   10008:	00000297          	auipc	t0,0x0
   1000c:	6f628293          	addi	t0,t0,1782 # 106fe <__bss_end>
   10010:	00000317          	auipc	t1,0x0
   10014:	6ee30313          	addi	t1,t1,1774 # 106fe <__bss_end>
   10018:	0062d863          	bge	t0,t1,10028 <_start+0x28>
   1001c:	0002a023          	sw	zero,0(t0)
   10020:	00428293          	addi	t0,t0,4
   10024:	ff5ff06f          	j	10018 <_start+0x18>
   10028:	43c000ef          	jal	10464 <main>
   1002c:	05d00893          	li	a7,93
   10030:	00000513          	li	a0,0
   10034:	00000073          	ecall
   10038:	0000006f          	j	10038 <_start+0x38>

0001003c <memcpy>:
   1003c:	00000793          	li	a5,0
   10040:	00f61463          	bne	a2,a5,10048 <memcpy+0xc>
   10044:	00008067          	ret
   10048:	00f58733          	add	a4,a1,a5
   1004c:	00074683          	lbu	a3,0(a4)
   10050:	00f50733          	add	a4,a0,a5
   10054:	00178793          	addi	a5,a5,1
   10058:	00d70023          	sb	a3,0(a4)
   1005c:	fe5ff06f          	j	10040 <memcpy+0x4>

00010060 <__mulsi3>:
   10060:	00050793          	mv	a5,a0
   10064:	00000513          	li	a0,0
   10068:	00059463          	bnez	a1,10070 <__mulsi3+0x10>
   1006c:	00008067          	ret
   10070:	0015f713          	andi	a4,a1,1
   10074:	40e00733          	neg	a4,a4
   10078:	00f77733          	and	a4,a4,a5
   1007c:	00e50533          	add	a0,a0,a4
   10080:	00179793          	slli	a5,a5,0x1
   10084:	0015d593          	srli	a1,a1,0x1
   10088:	fe1ff06f          	j	10068 <__mulsi3+0x8>

0001008c <print_dec>:
   1008c:	fe010113          	addi	sp,sp,-32
   10090:	0a051663          	bnez	a0,1013c <print_dec+0xb0>
   10094:	03000793          	li	a5,48
   10098:	00f10fa3          	sb	a5,31(sp)
   1009c:	01e10713          	addi	a4,sp,30
   100a0:	00170713          	addi	a4,a4,1
   100a4:	02010793          	addi	a5,sp,32
   100a8:	40e787b3          	sub	a5,a5,a4
   100ac:	04000893          	li	a7,64
   100b0:	00100513          	li	a0,1
   100b4:	00e005b3          	add	a1,zero,a4
   100b8:	00078613          	mv	a2,a5
   100bc:	00000073          	ecall
   100c0:	02010113          	addi	sp,sp,32
   100c4:	00008067          	ret
   100c8:	00d55633          	srl	a2,a0,a3
   100cc:	00179793          	slli	a5,a5,0x1
   100d0:	00167613          	andi	a2,a2,1
   100d4:	00f667b3          	or	a5,a2,a5
   100d8:	00f87463          	bgeu	a6,a5,100e0 <print_dec+0x54>
   100dc:	ff678793          	addi	a5,a5,-10
   100e0:	fff68693          	addi	a3,a3,-1
   100e4:	ff1692e3          	bne	a3,a7,100c8 <print_dec+0x3c>
   100e8:	03078793          	addi	a5,a5,48
   100ec:	00f70023          	sb	a5,0(a4)
   100f0:	00000613          	li	a2,0
   100f4:	fff70713          	addi	a4,a4,-1
   100f8:	01f00693          	li	a3,31
   100fc:	00000793          	li	a5,0
   10100:	00d555b3          	srl	a1,a0,a3
   10104:	00179793          	slli	a5,a5,0x1
   10108:	0015f593          	andi	a1,a1,1
   1010c:	00f5e7b3          	or	a5,a1,a5
   10110:	00f87863          	bgeu	a6,a5,10120 <print_dec+0x94>
   10114:	00d315b3          	sll	a1,t1,a3
   10118:	ff678793          	addi	a5,a5,-10
   1011c:	00b66633          	or	a2,a2,a1
   10120:	fff68693          	addi	a3,a3,-1
   10124:	fd169ee3          	bne	a3,a7,10100 <print_dec+0x74>
   10128:	f6060ce3          	beqz	a2,100a0 <print_dec+0x14>
   1012c:	00060513          	mv	a0,a2
   10130:	01f00693          	li	a3,31
   10134:	00000793          	li	a5,0
   10138:	f91ff06f          	j	100c8 <print_dec+0x3c>
   1013c:	01f10713          	addi	a4,sp,31
   10140:	00900813          	li	a6,9
   10144:	fff00893          	li	a7,-1
   10148:	00100313          	li	t1,1
   1014c:	fe5ff06f          	j	10130 <print_dec+0xa4>

00010150 <get_cycles>:
   10150:	c80025f3          	rdcycleh	a1
   10154:	c0002573          	rdcycle	a0
   10158:	c8002673          	rdcycleh	a2
   1015c:	fec59ae3          	bne	a1,a2,10150 <get_cycles>
   10160:	00008067          	ret

00010164 <get_instret>:
   10164:	c82025f3          	rdinstreth	a1
   10168:	c0202573          	rdinstret	a0
   1016c:	c8202673          	rdinstreth	a2
   10170:	fec59ae3          	bne	a1,a2,10164 <get_instret>
   10174:	00008067          	ret

00010178 <run_q1_uf8>:
   10178:	fe010113          	addi	sp,sp,-32
   1017c:	00112e23          	sw	ra,28(sp)
   10180:	00812c23          	sw	s0,24(sp)
   10184:	00912a23          	sw	s1,20(sp)
   10188:	01212823          	sw	s2,16(sp)
   1018c:	01312623          	sw	s3,12(sp)
   10190:	01512423          	sw	s5,8(sp)
   10194:	00000413          	li	s0,0
   10198:	fff00493          	li	s1,-1
   1019c:	10000913          	li	s2,256
   101a0:	00100993          	li	s3,1
   101a4:	00f00a93          	li	s5,15
   101a8:	028000ef          	jal	101d0 <test>
   101ac:	2a051263          	bnez	a0,10450 <print_suc_msg>

000101b0 <main_c>:
   101b0:	01c12083          	lw	ra,28(sp)
   101b4:	01812403          	lw	s0,24(sp)
   101b8:	01412483          	lw	s1,20(sp)
   101bc:	01012903          	lw	s2,16(sp)
   101c0:	00c12983          	lw	s3,12(sp)
   101c4:	00812a83          	lw	s5,8(sp)
   101c8:	02010113          	addi	sp,sp,32
   101cc:	00008067          	ret

000101d0 <test>:
   101d0:	ff010113          	addi	sp,sp,-16
   101d4:	00112623          	sw	ra,12(sp)
   101d8:	01412423          	sw	s4,8(sp)

000101dc <loop>:
   101dc:	06090063          	beqz	s2,1023c <test_end>
   101e0:	0ff47513          	zext.b	a0,s0
   101e4:	00455293          	srli	t0,a0,0x4
   101e8:	00f57513          	andi	a0,a0,15
   101ec:	01050513          	addi	a0,a0,16
   101f0:	00551533          	sll	a0,a0,t0
   101f4:	ff050513          	addi	a0,a0,-16
   101f8:	00050a13          	mv	s4,a0
   101fc:	054000ef          	jal	10250 <uf8_encode>
   10200:	0ff57513          	zext.b	a0,a0
   10204:	02a41263          	bne	s0,a0,10228 <set_fail>

00010208 <check_mono_inc>:
   10208:	0144c863          	blt	s1,s4,10218 <ok>
   1020c:	00000993          	li	s3,0
   10210:	00100e13          	li	t3,1
   10214:	178000ef          	jal	1038c <print_fail_msg>

00010218 <ok>:
   10218:	000a0493          	mv	s1,s4
   1021c:	00140413          	addi	s0,s0,1
   10220:	fff90913          	addi	s2,s2,-1
   10224:	fb9ff06f          	j	101dc <loop>

00010228 <set_fail>:
   10228:	00000993          	li	s3,0
   1022c:	00000e13          	li	t3,0
   10230:	00050e93          	mv	t4,a0
   10234:	158000ef          	jal	1038c <print_fail_msg>
   10238:	fd1ff06f          	j	10208 <check_mono_inc>

0001023c <test_end>:
   1023c:	00098513          	mv	a0,s3
   10240:	00c12083          	lw	ra,12(sp)
   10244:	00812a03          	lw	s4,8(sp)
   10248:	01010113          	addi	sp,sp,16
   1024c:	00008067          	ret

00010250 <uf8_encode>:
   10250:	01000e13          	li	t3,16
   10254:	01c55463          	bge	a0,t3,1025c <e_not_zero>
   10258:	00008067          	ret

0001025c <e_not_zero>:
   1025c:	ff010113          	addi	sp,sp,-16
   10260:	00112623          	sw	ra,12(sp)
   10264:	00050e93          	mv	t4,a0
   10268:	0a0000ef          	jal	10308 <clz>
   1026c:	01f00e13          	li	t3,31
   10270:	40ae02b3          	sub	t0,t3,a0
   10274:	000e8513          	mv	a0,t4
   10278:	00c12083          	lw	ra,12(sp)
   1027c:	01010113          	addi	sp,sp,16
   10280:	00000313          	li	t1,0
   10284:	00000393          	li	t2,0
   10288:	00500e13          	li	t3,5
   1028c:	05c2c263          	blt	t0,t3,102d0 <find_exa_exp>
   10290:	ffc28313          	addi	t1,t0,-4
   10294:	01033e13          	sltiu	t3,t1,16
   10298:	000e0463          	beqz	t3,102a0 <set_exp_15>
   1029c:	0080006f          	j	102a4 <build_of_once>

000102a0 <set_exp_15>:
   102a0:	00f00313          	li	t1,15

000102a4 <build_of_once>:
   102a4:	00100393          	li	t2,1
   102a8:	006393b3          	sll	t2,t2,t1
   102ac:	fff38393          	addi	t2,t2,-1
   102b0:	00439393          	slli	t2,t2,0x4
   102b4:	0040006f          	j	102b8 <adj_exp>

000102b8 <adj_exp>:
   102b8:	00605c63          	blez	t1,102d0 <find_exa_exp>
   102bc:	00755a63          	bge	a0,t2,102d0 <find_exa_exp>
   102c0:	ff038393          	addi	t2,t2,-16
   102c4:	0013d393          	srli	t2,t2,0x1
   102c8:	fff30313          	addi	t1,t1,-1
   102cc:	fedff06f          	j	102b8 <adj_exp>

000102d0 <find_exa_exp>:
   102d0:	01535e63          	bge	t1,s5,102ec <calc_m>
   102d4:	00139293          	slli	t0,t2,0x1
   102d8:	01028293          	addi	t0,t0,16
   102dc:	00554863          	blt	a0,t0,102ec <calc_m>
   102e0:	00028393          	mv	t2,t0
   102e4:	00130313          	addi	t1,t1,1
   102e8:	fe9ff06f          	j	102d0 <find_exa_exp>

000102ec <calc_m>:
   102ec:	407502b3          	sub	t0,a0,t2
   102f0:	0062d2b3          	srl	t0,t0,t1
   102f4:	005ad463          	bge	s5,t0,102fc <cmb_num>
   102f8:	00f00293          	li	t0,15

000102fc <cmb_num>:
   102fc:	00431313          	slli	t1,t1,0x4
   10300:	00536533          	or	a0,t1,t0
   10304:	00008067          	ret

00010308 <clz>:
   10308:	04050e63          	beqz	a0,10364 <clz_zero>
   1030c:	00000293          	li	t0,0
   10310:	01055313          	srli	t1,a0,0x10
   10314:	00031663          	bnez	t1,10320 <check_8_bits>
   10318:	01028293          	addi	t0,t0,16
   1031c:	01051513          	slli	a0,a0,0x10

00010320 <check_8_bits>:
   10320:	01855313          	srli	t1,a0,0x18
   10324:	00031663          	bnez	t1,10330 <check_4_bits>
   10328:	00828293          	addi	t0,t0,8
   1032c:	00851513          	slli	a0,a0,0x8

00010330 <check_4_bits>:
   10330:	01c55313          	srli	t1,a0,0x1c
   10334:	00031663          	bnez	t1,10340 <check_2_bits>
   10338:	00428293          	addi	t0,t0,4
   1033c:	00451513          	slli	a0,a0,0x4

00010340 <check_2_bits>:
   10340:	01e55313          	srli	t1,a0,0x1e
   10344:	00031663          	bnez	t1,10350 <check_1_bit>
   10348:	00228293          	addi	t0,t0,2
   1034c:	00251513          	slli	a0,a0,0x2

00010350 <check_1_bit>:
   10350:	01f55313          	srli	t1,a0,0x1f
   10354:	00031463          	bnez	t1,1035c <clz_finish>
   10358:	00128293          	addi	t0,t0,1

0001035c <clz_finish>:
   1035c:	00028513          	mv	a0,t0
   10360:	00008067          	ret

00010364 <clz_zero>:
   10364:	02000513          	li	a0,32
   10368:	00008067          	ret

0001036c <printstr_asm>:
   1036c:	00050313          	mv	t1,a0
   10370:	00058393          	mv	t2,a1
   10374:	04000893          	li	a7,64
   10378:	00100513          	li	a0,1
   1037c:	00030593          	mv	a1,t1
   10380:	00038613          	mv	a2,t2
   10384:	00000073          	ecall
   10388:	00008067          	ret

0001038c <print_fail_msg>:
   1038c:	ff010113          	addi	sp,sp,-16
   10390:	00112623          	sw	ra,12(sp)
   10394:	00812423          	sw	s0,8(sp)
   10398:	00912223          	sw	s1,4(sp)
   1039c:	01412023          	sw	s4,0(sp)
   103a0:	040e1863          	bnez	t3,103f0 <t3_1>
   103a4:	00040513          	mv	a0,s0
   103a8:	ce5ff0ef          	jal	1008c <print_dec>
   103ac:	00000517          	auipc	a0,0x0
   103b0:	2f950513          	addi	a0,a0,761 # 106a5 <str1>
   103b4:	01200593          	li	a1,18
   103b8:	fb5ff0ef          	jal	1036c <printstr_asm>
   103bc:	000a0513          	mv	a0,s4
   103c0:	ccdff0ef          	jal	1008c <print_dec>
   103c4:	00000517          	auipc	a0,0x0
   103c8:	2f350513          	addi	a0,a0,755 # 106b7 <str2>
   103cc:	01600593          	li	a1,22
   103d0:	f9dff0ef          	jal	1036c <printstr_asm>
   103d4:	000e8513          	mv	a0,t4
   103d8:	cb5ff0ef          	jal	1008c <print_dec>
   103dc:	00000517          	auipc	a0,0x0
   103e0:	30e50513          	addi	a0,a0,782 # 106ea <str5>
   103e4:	00200593          	li	a1,2
   103e8:	f85ff0ef          	jal	1036c <printstr_asm>
   103ec:	04c0006f          	j	10438 <print_fail_end>

000103f0 <t3_1>:
   103f0:	00040513          	mv	a0,s0
   103f4:	c99ff0ef          	jal	1008c <print_dec>
   103f8:	00000517          	auipc	a0,0x0
   103fc:	2d550513          	addi	a0,a0,725 # 106cd <str3>
   10400:	00900593          	li	a1,9
   10404:	f69ff0ef          	jal	1036c <printstr_asm>
   10408:	000a0513          	mv	a0,s4
   1040c:	c81ff0ef          	jal	1008c <print_dec>
   10410:	00000517          	auipc	a0,0x0
   10414:	2c650513          	addi	a0,a0,710 # 106d6 <str4>
   10418:	01400593          	li	a1,20
   1041c:	f51ff0ef          	jal	1036c <printstr_asm>
   10420:	00048513          	mv	a0,s1
   10424:	c69ff0ef          	jal	1008c <print_dec>
   10428:	00000517          	auipc	a0,0x0
   1042c:	2c250513          	addi	a0,a0,706 # 106ea <str5>
   10430:	00200593          	li	a1,2
   10434:	f39ff0ef          	jal	1036c <printstr_asm>

00010438 <print_fail_end>:
   10438:	00c12083          	lw	ra,12(sp)
   1043c:	00812403          	lw	s0,8(sp)
   10440:	00412483          	lw	s1,4(sp)
   10444:	00012a03          	lw	s4,0(sp)
   10448:	01010113          	addi	sp,sp,16
   1044c:	00008067          	ret

00010450 <print_suc_msg>:
   10450:	00000517          	auipc	a0,0x0
   10454:	29c50513          	addi	a0,a0,668 # 106ec <str6>
   10458:	01200593          	li	a1,18
   1045c:	f11ff0ef          	jal	1036c <printstr_asm>
   10460:	d51ff06f          	j	101b0 <main_c>

Disassembly of section .text.startup:

00010464 <main>:
   10464:	fa010113          	addi	sp,sp,-96
   10468:	04812c23          	sw	s0,88(sp)
   1046c:	000105b7          	lui	a1,0x10
   10470:	00410413          	addi	s0,sp,4
   10474:	03900613          	li	a2,57
   10478:	5ec58593          	addi	a1,a1,1516 # 105ec <main+0x188>
   1047c:	00040513          	mv	a0,s0
   10480:	04112e23          	sw	ra,92(sp)
   10484:	04912a23          	sw	s1,84(sp)
   10488:	05212823          	sw	s2,80(sp)
   1048c:	05312623          	sw	s3,76(sp)
   10490:	05412423          	sw	s4,72(sp)
   10494:	ba9ff0ef          	jal	1003c <memcpy>
   10498:	03800793          	li	a5,56
   1049c:	04000893          	li	a7,64
   104a0:	00100513          	li	a0,1
   104a4:	008005b3          	add	a1,zero,s0
   104a8:	00078613          	mv	a2,a5
   104ac:	00000073          	ecall
   104b0:	ca1ff0ef          	jal	10150 <get_cycles>
   104b4:	00050a13          	mv	s4,a0
   104b8:	cadff0ef          	jal	10164 <get_instret>
   104bc:	00050913          	mv	s2,a0
   104c0:	cb9ff0ef          	jal	10178 <run_q1_uf8>
   104c4:	00050993          	mv	s3,a0
   104c8:	c89ff0ef          	jal	10150 <get_cycles>
   104cc:	00050493          	mv	s1,a0
   104d0:	c95ff0ef          	jal	10164 <get_instret>
   104d4:	414484b3          	sub	s1,s1,s4
   104d8:	41250933          	sub	s2,a0,s2
   104dc:	01d00613          	li	a2,29
   104e0:	10098063          	beqz	s3,105e0 <main+0x17c>
   104e4:	000105b7          	lui	a1,0x10
   104e8:	62858593          	addi	a1,a1,1576 # 10628 <main+0x1c4>
   104ec:	00040513          	mv	a0,s0
   104f0:	b4dff0ef          	jal	1003c <memcpy>
   104f4:	01c00793          	li	a5,28
   104f8:	04000893          	li	a7,64
   104fc:	00100513          	li	a0,1
   10500:	008005b3          	add	a1,zero,s0
   10504:	00078613          	mv	a2,a5
   10508:	00000073          	ecall
   1050c:	000105b7          	lui	a1,0x10
   10510:	00b00613          	li	a2,11
   10514:	64858593          	addi	a1,a1,1608 # 10648 <main+0x1e4>
   10518:	00040513          	mv	a0,s0
   1051c:	b21ff0ef          	jal	1003c <memcpy>
   10520:	00a00993          	li	s3,10
   10524:	04000893          	li	a7,64
   10528:	00100513          	li	a0,1
   1052c:	008005b3          	add	a1,zero,s0
   10530:	00098613          	mv	a2,s3
   10534:	00000073          	ecall
   10538:	00048513          	mv	a0,s1
   1053c:	b51ff0ef          	jal	1008c <print_dec>
   10540:	000105b7          	lui	a1,0x10
   10544:	01100613          	li	a2,17
   10548:	65458593          	addi	a1,a1,1620 # 10654 <main+0x1f0>
   1054c:	00040513          	mv	a0,s0
   10550:	aedff0ef          	jal	1003c <memcpy>
   10554:	01000793          	li	a5,16
   10558:	04000893          	li	a7,64
   1055c:	00100513          	li	a0,1
   10560:	008005b3          	add	a1,zero,s0
   10564:	00078613          	mv	a2,a5
   10568:	00000073          	ecall
   1056c:	00090513          	mv	a0,s2
   10570:	b1dff0ef          	jal	1008c <print_dec>
   10574:	00100793          	li	a5,1
   10578:	01311223          	sh	s3,4(sp)
   1057c:	04000893          	li	a7,64
   10580:	00100513          	li	a0,1
   10584:	008005b3          	add	a1,zero,s0
   10588:	00078613          	mv	a2,a5
   1058c:	00000073          	ecall
   10590:	000105b7          	lui	a1,0x10
   10594:	01e00613          	li	a2,30
   10598:	66858593          	addi	a1,a1,1640 # 10668 <main+0x204>
   1059c:	00040513          	mv	a0,s0
   105a0:	a9dff0ef          	jal	1003c <memcpy>
   105a4:	01d00793          	li	a5,29
   105a8:	04000893          	li	a7,64
   105ac:	00100513          	li	a0,1
   105b0:	008005b3          	add	a1,zero,s0
   105b4:	00078613          	mv	a2,a5
   105b8:	00000073          	ecall
   105bc:	05c12083          	lw	ra,92(sp)
   105c0:	05812403          	lw	s0,88(sp)
   105c4:	05412483          	lw	s1,84(sp)
   105c8:	05012903          	lw	s2,80(sp)
   105cc:	04c12983          	lw	s3,76(sp)
   105d0:	04812a03          	lw	s4,72(sp)
   105d4:	00000513          	li	a0,0
   105d8:	06010113          	addi	sp,sp,96
   105dc:	00008067          	ret
   105e0:	000105b7          	lui	a1,0x10
   105e4:	68858593          	addi	a1,a1,1672 # 10688 <main+0x224>
   105e8:	f05ff06f          	j	104ec <main+0x88>
