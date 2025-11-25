
test.elf:     file format elf32-littleriscv


Disassembly of section .text:

00010000 <_start>:
   10000:	00002117          	auipc	sp,0x2
   10004:	86010113          	addi	sp,sp,-1952 # 11860 <__stack_top>
   10008:	00001297          	auipc	t0,0x1
   1000c:	84e28293          	addi	t0,t0,-1970 # 10856 <__bss_end>
   10010:	00001317          	auipc	t1,0x1
   10014:	84630313          	addi	t1,t1,-1978 # 10856 <__bss_end>
   10018:	0062d863          	bge	t0,t1,10028 <_start+0x28>
   1001c:	0002a023          	sw	zero,0(t0)
   10020:	00428293          	addi	t0,t0,4
   10024:	ff5ff06f          	j	10018 <_start+0x18>
   10028:	4bc000ef          	jal	104e4 <main>
   1002c:	05d00893          	li	a7,93
   10030:	00000513          	li	a0,0
   10034:	00000073          	ecall
   10038:	0000006f          	j	10038 <_start+0x38>

0001003c <memcpy>:
   1003c:	fff60813          	addi	a6,a2,-1
   10040:	08060e63          	beqz	a2,100dc <memcpy+0xa0>
   10044:	00600793          	li	a5,6
   10048:	00158713          	addi	a4,a1,1
   1004c:	0707fa63          	bgeu	a5,a6,100c0 <memcpy+0x84>
   10050:	00b567b3          	or	a5,a0,a1
   10054:	0037f793          	andi	a5,a5,3
   10058:	00158713          	addi	a4,a1,1
   1005c:	06079263          	bnez	a5,100c0 <memcpy+0x84>
   10060:	40e507b3          	sub	a5,a0,a4
   10064:	0037b793          	sltiu	a5,a5,3
   10068:	04079c63          	bnez	a5,100c0 <memcpy+0x84>
   1006c:	ffc67893          	andi	a7,a2,-4
   10070:	011586b3          	add	a3,a1,a7
   10074:	00050793          	mv	a5,a0
   10078:	0005a703          	lw	a4,0(a1)
   1007c:	00458593          	addi	a1,a1,4
   10080:	00478793          	addi	a5,a5,4
   10084:	fee7ae23          	sw	a4,-4(a5)
   10088:	feb698e3          	bne	a3,a1,10078 <memcpy+0x3c>
   1008c:	41180833          	sub	a6,a6,a7
   10090:	011507b3          	add	a5,a0,a7
   10094:	05160463          	beq	a2,a7,100dc <memcpy+0xa0>
   10098:	0006c703          	lbu	a4,0(a3)
   1009c:	00e78023          	sb	a4,0(a5)
   100a0:	02080e63          	beqz	a6,100dc <memcpy+0xa0>
   100a4:	0016c603          	lbu	a2,1(a3)
   100a8:	00100713          	li	a4,1
   100ac:	00c780a3          	sb	a2,1(a5)
   100b0:	02e80663          	beq	a6,a4,100dc <memcpy+0xa0>
   100b4:	0026c703          	lbu	a4,2(a3)
   100b8:	00e78123          	sb	a4,2(a5)
   100bc:	00008067          	ret
   100c0:	00c50633          	add	a2,a0,a2
   100c4:	00050793          	mv	a5,a0
   100c8:	fff74683          	lbu	a3,-1(a4)
   100cc:	00178793          	addi	a5,a5,1
   100d0:	00170713          	addi	a4,a4,1
   100d4:	fed78fa3          	sb	a3,-1(a5)
   100d8:	fec798e3          	bne	a5,a2,100c8 <memcpy+0x8c>
   100dc:	00008067          	ret

000100e0 <__mulsi3>:
   100e0:	00050713          	mv	a4,a0
   100e4:	00000513          	li	a0,0
   100e8:	02058263          	beqz	a1,1010c <__mulsi3+0x2c>
   100ec:	0015f793          	andi	a5,a1,1
   100f0:	40f007b3          	neg	a5,a5
   100f4:	00e7f7b3          	and	a5,a5,a4
   100f8:	0015d593          	srli	a1,a1,0x1
   100fc:	00f50533          	add	a0,a0,a5
   10100:	00171713          	slli	a4,a4,0x1
   10104:	fe0594e3          	bnez	a1,100ec <__mulsi3+0xc>
   10108:	00008067          	ret
   1010c:	00008067          	ret

00010110 <print_dec>:
   10110:	fe010113          	addi	sp,sp,-32
   10114:	02051a63          	bnez	a0,10148 <print_dec+0x38>
   10118:	03000793          	li	a5,48
   1011c:	00f10fa3          	sb	a5,31(sp)
   10120:	01f10313          	addi	t1,sp,31
   10124:	02010793          	addi	a5,sp,32
   10128:	406787b3          	sub	a5,a5,t1
   1012c:	04000893          	li	a7,64
   10130:	00100513          	li	a0,1
   10134:	006005b3          	add	a1,zero,t1
   10138:	00078613          	mv	a2,a5
   1013c:	00000073          	ecall
   10140:	02010113          	addi	sp,sp,32
   10144:	00008067          	ret
   10148:	01f10313          	addi	t1,sp,31
   1014c:	00900593          	li	a1,9
   10150:	fff00613          	li	a2,-1
   10154:	00100893          	li	a7,1
   10158:	01f00713          	li	a4,31
   1015c:	00000793          	li	a5,0
   10160:	00e556b3          	srl	a3,a0,a4
   10164:	00179793          	slli	a5,a5,0x1
   10168:	0016f693          	andi	a3,a3,1
   1016c:	00f6e7b3          	or	a5,a3,a5
   10170:	fff70713          	addi	a4,a4,-1
   10174:	00f5f463          	bgeu	a1,a5,1017c <print_dec+0x6c>
   10178:	ff678793          	addi	a5,a5,-10
   1017c:	fec712e3          	bne	a4,a2,10160 <print_dec+0x50>
   10180:	03078793          	addi	a5,a5,48
   10184:	00f30023          	sb	a5,0(t1)
   10188:	fff30e13          	addi	t3,t1,-1
   1018c:	00000813          	li	a6,0
   10190:	01f00713          	li	a4,31
   10194:	00000793          	li	a5,0
   10198:	00e556b3          	srl	a3,a0,a4
   1019c:	0016f693          	andi	a3,a3,1
   101a0:	00179793          	slli	a5,a5,0x1
   101a4:	00f6e7b3          	or	a5,a3,a5
   101a8:	00e896b3          	sll	a3,a7,a4
   101ac:	fff70713          	addi	a4,a4,-1
   101b0:	00f5f663          	bgeu	a1,a5,101bc <print_dec+0xac>
   101b4:	ff678793          	addi	a5,a5,-10
   101b8:	00d86833          	or	a6,a6,a3
   101bc:	fcc71ee3          	bne	a4,a2,10198 <print_dec+0x88>
   101c0:	f60802e3          	beqz	a6,10124 <print_dec+0x14>
   101c4:	000e0313          	mv	t1,t3
   101c8:	00080513          	mv	a0,a6
   101cc:	f8dff06f          	j	10158 <print_dec+0x48>

000101d0 <get_cycles>:
   101d0:	c80025f3          	rdcycleh	a1
   101d4:	c0002573          	rdcycle	a0
   101d8:	c8002673          	rdcycleh	a2
   101dc:	fec59ae3          	bne	a1,a2,101d0 <get_cycles>
   101e0:	00008067          	ret

000101e4 <get_instret>:
   101e4:	c82025f3          	rdinstreth	a1
   101e8:	c0202573          	rdinstret	a0
   101ec:	c8202673          	rdinstreth	a2
   101f0:	fec59ae3          	bne	a1,a2,101e4 <get_instret>
   101f4:	00008067          	ret

000101f8 <run_q1_uf8>:
   101f8:	fe010113          	addi	sp,sp,-32
   101fc:	00112e23          	sw	ra,28(sp)
   10200:	00812c23          	sw	s0,24(sp)
   10204:	00912a23          	sw	s1,20(sp)
   10208:	01212823          	sw	s2,16(sp)
   1020c:	01312623          	sw	s3,12(sp)
   10210:	01512423          	sw	s5,8(sp)
   10214:	00000413          	li	s0,0
   10218:	fff00493          	li	s1,-1
   1021c:	10000913          	li	s2,256
   10220:	00100993          	li	s3,1
   10224:	00f00a93          	li	s5,15
   10228:	028000ef          	jal	10250 <test>
   1022c:	2a051263          	bnez	a0,104d0 <print_suc_msg>

00010230 <main_c>:
   10230:	01c12083          	lw	ra,28(sp)
   10234:	01812403          	lw	s0,24(sp)
   10238:	01412483          	lw	s1,20(sp)
   1023c:	01012903          	lw	s2,16(sp)
   10240:	00c12983          	lw	s3,12(sp)
   10244:	00812a83          	lw	s5,8(sp)
   10248:	02010113          	addi	sp,sp,32
   1024c:	00008067          	ret

00010250 <test>:
   10250:	ff010113          	addi	sp,sp,-16
   10254:	00112623          	sw	ra,12(sp)
   10258:	01412423          	sw	s4,8(sp)

0001025c <loop>:
   1025c:	06090063          	beqz	s2,102bc <test_end>
   10260:	0ff47513          	zext.b	a0,s0
   10264:	00455293          	srli	t0,a0,0x4
   10268:	00f57513          	andi	a0,a0,15
   1026c:	01050513          	addi	a0,a0,16
   10270:	00551533          	sll	a0,a0,t0
   10274:	ff050513          	addi	a0,a0,-16
   10278:	00050a13          	mv	s4,a0
   1027c:	054000ef          	jal	102d0 <uf8_encode>
   10280:	0ff57513          	zext.b	a0,a0
   10284:	02a41263          	bne	s0,a0,102a8 <set_fail>

00010288 <check_mono_inc>:
   10288:	0144c863          	blt	s1,s4,10298 <ok>
   1028c:	00000993          	li	s3,0
   10290:	00100e13          	li	t3,1
   10294:	178000ef          	jal	1040c <print_fail_msg>

00010298 <ok>:
   10298:	000a0493          	mv	s1,s4
   1029c:	00140413          	addi	s0,s0,1
   102a0:	fff90913          	addi	s2,s2,-1
   102a4:	fb9ff06f          	j	1025c <loop>

000102a8 <set_fail>:
   102a8:	00000993          	li	s3,0
   102ac:	00000e13          	li	t3,0
   102b0:	00050e93          	mv	t4,a0
   102b4:	158000ef          	jal	1040c <print_fail_msg>
   102b8:	fd1ff06f          	j	10288 <check_mono_inc>

000102bc <test_end>:
   102bc:	00098513          	mv	a0,s3
   102c0:	00c12083          	lw	ra,12(sp)
   102c4:	00812a03          	lw	s4,8(sp)
   102c8:	01010113          	addi	sp,sp,16
   102cc:	00008067          	ret

000102d0 <uf8_encode>:
   102d0:	01000e13          	li	t3,16
   102d4:	01c55463          	bge	a0,t3,102dc <e_not_zero>
   102d8:	00008067          	ret

000102dc <e_not_zero>:
   102dc:	ff010113          	addi	sp,sp,-16
   102e0:	00112623          	sw	ra,12(sp)
   102e4:	00050e93          	mv	t4,a0
   102e8:	0a0000ef          	jal	10388 <clz>
   102ec:	01f00e13          	li	t3,31
   102f0:	40ae02b3          	sub	t0,t3,a0
   102f4:	000e8513          	mv	a0,t4
   102f8:	00c12083          	lw	ra,12(sp)
   102fc:	01010113          	addi	sp,sp,16
   10300:	00000313          	li	t1,0
   10304:	00000393          	li	t2,0
   10308:	00500e13          	li	t3,5
   1030c:	05c2c263          	blt	t0,t3,10350 <find_exa_exp>
   10310:	ffc28313          	addi	t1,t0,-4
   10314:	01033e13          	sltiu	t3,t1,16
   10318:	000e0463          	beqz	t3,10320 <set_exp_15>
   1031c:	0080006f          	j	10324 <build_of_once>

00010320 <set_exp_15>:
   10320:	00f00313          	li	t1,15

00010324 <build_of_once>:
   10324:	00100393          	li	t2,1
   10328:	006393b3          	sll	t2,t2,t1
   1032c:	fff38393          	addi	t2,t2,-1
   10330:	00439393          	slli	t2,t2,0x4
   10334:	0040006f          	j	10338 <adj_exp>

00010338 <adj_exp>:
   10338:	00605c63          	blez	t1,10350 <find_exa_exp>
   1033c:	00755a63          	bge	a0,t2,10350 <find_exa_exp>
   10340:	ff038393          	addi	t2,t2,-16
   10344:	0013d393          	srli	t2,t2,0x1
   10348:	fff30313          	addi	t1,t1,-1
   1034c:	fedff06f          	j	10338 <adj_exp>

00010350 <find_exa_exp>:
   10350:	01535e63          	bge	t1,s5,1036c <calc_m>
   10354:	00139293          	slli	t0,t2,0x1
   10358:	01028293          	addi	t0,t0,16
   1035c:	00554863          	blt	a0,t0,1036c <calc_m>
   10360:	00028393          	mv	t2,t0
   10364:	00130313          	addi	t1,t1,1
   10368:	fe9ff06f          	j	10350 <find_exa_exp>

0001036c <calc_m>:
   1036c:	407502b3          	sub	t0,a0,t2
   10370:	0062d2b3          	srl	t0,t0,t1
   10374:	005ad463          	bge	s5,t0,1037c <cmb_num>
   10378:	00f00293          	li	t0,15

0001037c <cmb_num>:
   1037c:	00431313          	slli	t1,t1,0x4
   10380:	00536533          	or	a0,t1,t0
   10384:	00008067          	ret

00010388 <clz>:
   10388:	04050e63          	beqz	a0,103e4 <clz_zero>
   1038c:	00000293          	li	t0,0
   10390:	01055313          	srli	t1,a0,0x10
   10394:	00031663          	bnez	t1,103a0 <check_8_bits>
   10398:	01028293          	addi	t0,t0,16
   1039c:	01051513          	slli	a0,a0,0x10

000103a0 <check_8_bits>:
   103a0:	01855313          	srli	t1,a0,0x18
   103a4:	00031663          	bnez	t1,103b0 <check_4_bits>
   103a8:	00828293          	addi	t0,t0,8
   103ac:	00851513          	slli	a0,a0,0x8

000103b0 <check_4_bits>:
   103b0:	01c55313          	srli	t1,a0,0x1c
   103b4:	00031663          	bnez	t1,103c0 <check_2_bits>
   103b8:	00428293          	addi	t0,t0,4
   103bc:	00451513          	slli	a0,a0,0x4

000103c0 <check_2_bits>:
   103c0:	01e55313          	srli	t1,a0,0x1e
   103c4:	00031663          	bnez	t1,103d0 <check_1_bit>
   103c8:	00228293          	addi	t0,t0,2
   103cc:	00251513          	slli	a0,a0,0x2

000103d0 <check_1_bit>:
   103d0:	01f55313          	srli	t1,a0,0x1f
   103d4:	00031463          	bnez	t1,103dc <clz_finish>
   103d8:	00128293          	addi	t0,t0,1

000103dc <clz_finish>:
   103dc:	00028513          	mv	a0,t0
   103e0:	00008067          	ret

000103e4 <clz_zero>:
   103e4:	02000513          	li	a0,32
   103e8:	00008067          	ret

000103ec <printstr_asm>:
   103ec:	00050313          	mv	t1,a0
   103f0:	00058393          	mv	t2,a1
   103f4:	04000893          	li	a7,64
   103f8:	00100513          	li	a0,1
   103fc:	00030593          	mv	a1,t1
   10400:	00038613          	mv	a2,t2
   10404:	00000073          	ecall
   10408:	00008067          	ret

0001040c <print_fail_msg>:
   1040c:	ff010113          	addi	sp,sp,-16
   10410:	00112623          	sw	ra,12(sp)
   10414:	00812423          	sw	s0,8(sp)
   10418:	00912223          	sw	s1,4(sp)
   1041c:	01412023          	sw	s4,0(sp)
   10420:	040e1863          	bnez	t3,10470 <t3_1>
   10424:	00040513          	mv	a0,s0
   10428:	ce9ff0ef          	jal	10110 <print_dec>
   1042c:	00000517          	auipc	a0,0x0
   10430:	3d150513          	addi	a0,a0,977 # 107fd <str1>
   10434:	01200593          	li	a1,18
   10438:	fb5ff0ef          	jal	103ec <printstr_asm>
   1043c:	000a0513          	mv	a0,s4
   10440:	cd1ff0ef          	jal	10110 <print_dec>
   10444:	00000517          	auipc	a0,0x0
   10448:	3cb50513          	addi	a0,a0,971 # 1080f <str2>
   1044c:	01600593          	li	a1,22
   10450:	f9dff0ef          	jal	103ec <printstr_asm>
   10454:	000e8513          	mv	a0,t4
   10458:	cb9ff0ef          	jal	10110 <print_dec>
   1045c:	00000517          	auipc	a0,0x0
   10460:	3e650513          	addi	a0,a0,998 # 10842 <str5>
   10464:	00200593          	li	a1,2
   10468:	f85ff0ef          	jal	103ec <printstr_asm>
   1046c:	04c0006f          	j	104b8 <print_fail_end>

00010470 <t3_1>:
   10470:	00040513          	mv	a0,s0
   10474:	c9dff0ef          	jal	10110 <print_dec>
   10478:	00000517          	auipc	a0,0x0
   1047c:	3ad50513          	addi	a0,a0,941 # 10825 <str3>
   10480:	00900593          	li	a1,9
   10484:	f69ff0ef          	jal	103ec <printstr_asm>
   10488:	000a0513          	mv	a0,s4
   1048c:	c85ff0ef          	jal	10110 <print_dec>
   10490:	00000517          	auipc	a0,0x0
   10494:	39e50513          	addi	a0,a0,926 # 1082e <str4>
   10498:	01400593          	li	a1,20
   1049c:	f51ff0ef          	jal	103ec <printstr_asm>
   104a0:	00048513          	mv	a0,s1
   104a4:	c6dff0ef          	jal	10110 <print_dec>
   104a8:	00000517          	auipc	a0,0x0
   104ac:	39a50513          	addi	a0,a0,922 # 10842 <str5>
   104b0:	00200593          	li	a1,2
   104b4:	f39ff0ef          	jal	103ec <printstr_asm>

000104b8 <print_fail_end>:
   104b8:	00c12083          	lw	ra,12(sp)
   104bc:	00812403          	lw	s0,8(sp)
   104c0:	00412483          	lw	s1,4(sp)
   104c4:	00012a03          	lw	s4,0(sp)
   104c8:	01010113          	addi	sp,sp,16
   104cc:	00008067          	ret

000104d0 <print_suc_msg>:
   104d0:	00000517          	auipc	a0,0x0
   104d4:	37450513          	addi	a0,a0,884 # 10844 <str6>
   104d8:	01200593          	li	a1,18
   104dc:	f11ff0ef          	jal	103ec <printstr_asm>
   104e0:	d51ff06f          	j	10230 <main_c>

Disassembly of section .text.startup:

000104e4 <main>:
   104e4:	fa010113          	addi	sp,sp,-96
   104e8:	000107b7          	lui	a5,0x10
   104ec:	04812c23          	sw	s0,88(sp)
   104f0:	74478793          	addi	a5,a5,1860 # 10744 <main+0x260>
   104f4:	00410413          	addi	s0,sp,4
   104f8:	04112e23          	sw	ra,92(sp)
   104fc:	04912a23          	sw	s1,84(sp)
   10500:	05312823          	sw	s3,80(sp)
   10504:	05412623          	sw	s4,76(sp)
   10508:	05512423          	sw	s5,72(sp)
   1050c:	03078693          	addi	a3,a5,48
   10510:	00040713          	mv	a4,s0
   10514:	0007a803          	lw	a6,0(a5)
   10518:	0047a503          	lw	a0,4(a5)
   1051c:	0087a583          	lw	a1,8(a5)
   10520:	00c7a603          	lw	a2,12(a5)
   10524:	01072023          	sw	a6,0(a4)
   10528:	00a72223          	sw	a0,4(a4)
   1052c:	00b72423          	sw	a1,8(a4)
   10530:	00c72623          	sw	a2,12(a4)
   10534:	01078793          	addi	a5,a5,16
   10538:	01070713          	addi	a4,a4,16
   1053c:	fcd79ce3          	bne	a5,a3,10514 <main+0x30>
   10540:	0007a603          	lw	a2,0(a5)
   10544:	0047a683          	lw	a3,4(a5)
   10548:	0087c783          	lbu	a5,8(a5)
   1054c:	00c72023          	sw	a2,0(a4)
   10550:	00d72223          	sw	a3,4(a4)
   10554:	00f70423          	sb	a5,8(a4)
   10558:	03800793          	li	a5,56
   1055c:	04000893          	li	a7,64
   10560:	00100513          	li	a0,1
   10564:	008005b3          	add	a1,zero,s0
   10568:	00078613          	mv	a2,a5
   1056c:	00000073          	ecall
   10570:	c61ff0ef          	jal	101d0 <get_cycles>
   10574:	00050a13          	mv	s4,a0
   10578:	c6dff0ef          	jal	101e4 <get_instret>
   1057c:	00050993          	mv	s3,a0
   10580:	c79ff0ef          	jal	101f8 <run_q1_uf8>
   10584:	00050493          	mv	s1,a0
   10588:	c49ff0ef          	jal	101d0 <get_cycles>
   1058c:	00050a93          	mv	s5,a0
   10590:	c55ff0ef          	jal	101e4 <get_instret>
   10594:	414a8a33          	sub	s4,s5,s4
   10598:	413509b3          	sub	s3,a0,s3
   1059c:	18049e63          	bnez	s1,10738 <main+0x254>
   105a0:	000107b7          	lui	a5,0x10
   105a4:	78078793          	addi	a5,a5,1920 # 10780 <main+0x29c>
   105a8:	0007a303          	lw	t1,0(a5)
   105ac:	0047a883          	lw	a7,4(a5)
   105b0:	0087a803          	lw	a6,8(a5)
   105b4:	00c7a503          	lw	a0,12(a5)
   105b8:	0107a583          	lw	a1,16(a5)
   105bc:	0147a603          	lw	a2,20(a5)
   105c0:	0187a683          	lw	a3,24(a5)
   105c4:	01c7c783          	lbu	a5,28(a5)
   105c8:	00612223          	sw	t1,4(sp)
   105cc:	01112423          	sw	a7,8(sp)
   105d0:	02f10023          	sb	a5,32(sp)
   105d4:	01012623          	sw	a6,12(sp)
   105d8:	00a12823          	sw	a0,16(sp)
   105dc:	00b12a23          	sw	a1,20(sp)
   105e0:	00c12c23          	sw	a2,24(sp)
   105e4:	00d12e23          	sw	a3,28(sp)
   105e8:	01c00793          	li	a5,28
   105ec:	04000893          	li	a7,64
   105f0:	00100513          	li	a0,1
   105f4:	008005b3          	add	a1,zero,s0
   105f8:	00078613          	mv	a2,a5
   105fc:	00000073          	ecall
   10600:	000107b7          	lui	a5,0x10
   10604:	7a078793          	addi	a5,a5,1952 # 107a0 <main+0x2bc>
   10608:	0007a583          	lw	a1,0(a5)
   1060c:	0047a603          	lw	a2,4(a5)
   10610:	0087d683          	lhu	a3,8(a5)
   10614:	00a7c783          	lbu	a5,10(a5)
   10618:	00b12223          	sw	a1,4(sp)
   1061c:	00c12423          	sw	a2,8(sp)
   10620:	00d11623          	sh	a3,12(sp)
   10624:	00f10723          	sb	a5,14(sp)
   10628:	00a00493          	li	s1,10
   1062c:	04000893          	li	a7,64
   10630:	00100513          	li	a0,1
   10634:	008005b3          	add	a1,zero,s0
   10638:	00048613          	mv	a2,s1
   1063c:	00000073          	ecall
   10640:	000a0513          	mv	a0,s4
   10644:	acdff0ef          	jal	10110 <print_dec>
   10648:	000107b7          	lui	a5,0x10
   1064c:	7ac78793          	addi	a5,a5,1964 # 107ac <main+0x2c8>
   10650:	0007a583          	lw	a1,0(a5)
   10654:	0047a603          	lw	a2,4(a5)
   10658:	0087a683          	lw	a3,8(a5)
   1065c:	00c7a703          	lw	a4,12(a5)
   10660:	0107c783          	lbu	a5,16(a5)
   10664:	00b12223          	sw	a1,4(sp)
   10668:	00c12423          	sw	a2,8(sp)
   1066c:	00f10a23          	sb	a5,20(sp)
   10670:	00d12623          	sw	a3,12(sp)
   10674:	00e12823          	sw	a4,16(sp)
   10678:	01000793          	li	a5,16
   1067c:	04000893          	li	a7,64
   10680:	00100513          	li	a0,1
   10684:	008005b3          	add	a1,zero,s0
   10688:	00078613          	mv	a2,a5
   1068c:	00000073          	ecall
   10690:	00098513          	mv	a0,s3
   10694:	a7dff0ef          	jal	10110 <print_dec>
   10698:	00100793          	li	a5,1
   1069c:	00911223          	sh	s1,4(sp)
   106a0:	04000893          	li	a7,64
   106a4:	00100513          	li	a0,1
   106a8:	008005b3          	add	a1,zero,s0
   106ac:	00078613          	mv	a2,a5
   106b0:	00000073          	ecall
   106b4:	000107b7          	lui	a5,0x10
   106b8:	7c078793          	addi	a5,a5,1984 # 107c0 <main+0x2dc>
   106bc:	0007a883          	lw	a7,0(a5)
   106c0:	0047a803          	lw	a6,4(a5)
   106c4:	0087a503          	lw	a0,8(a5)
   106c8:	00c7a583          	lw	a1,12(a5)
   106cc:	0107a603          	lw	a2,16(a5)
   106d0:	0147a683          	lw	a3,20(a5)
   106d4:	0187a703          	lw	a4,24(a5)
   106d8:	01c7d783          	lhu	a5,28(a5)
   106dc:	01112223          	sw	a7,4(sp)
   106e0:	01012423          	sw	a6,8(sp)
   106e4:	02f11023          	sh	a5,32(sp)
   106e8:	00a12623          	sw	a0,12(sp)
   106ec:	00b12823          	sw	a1,16(sp)
   106f0:	00c12a23          	sw	a2,20(sp)
   106f4:	00d12c23          	sw	a3,24(sp)
   106f8:	00e12e23          	sw	a4,28(sp)
   106fc:	01d00793          	li	a5,29
   10700:	04000893          	li	a7,64
   10704:	00100513          	li	a0,1
   10708:	008005b3          	add	a1,zero,s0
   1070c:	00078613          	mv	a2,a5
   10710:	00000073          	ecall
   10714:	05c12083          	lw	ra,92(sp)
   10718:	05812403          	lw	s0,88(sp)
   1071c:	05412483          	lw	s1,84(sp)
   10720:	05012983          	lw	s3,80(sp)
   10724:	04c12a03          	lw	s4,76(sp)
   10728:	04812a83          	lw	s5,72(sp)
   1072c:	00000513          	li	a0,0
   10730:	06010113          	addi	sp,sp,96
   10734:	00008067          	ret
   10738:	000107b7          	lui	a5,0x10
   1073c:	7e078793          	addi	a5,a5,2016 # 107e0 <main+0x2fc>
   10740:	e69ff06f          	j	105a8 <main+0xc4>
