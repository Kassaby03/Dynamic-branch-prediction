	.file	1 "test.c"

 # GNU C 2.7.2.3 [AL 1.1, MM 40, tma 0.1] SimpleScalar running sstrix compiled by GNU C

 # Cc1 defaults:
 # -mgas -mgpOPT

 # Cc1 arguments (-G value = 8, Cpu = default, ISA = 1):
 # -quiet -dumpbase -O0 -o

gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	random_branch
	.rdata
	.align	2
$LC0:
	.ascii	"Iteration %d: Branch 1 taken\n\000"
	.align	2
$LC1:
	.ascii	"Iteration %d: Branch 1 not taken\n\000"
	.align	2
$LC2:
	.ascii	"Iteration %d: Branch 2 taken\n\000"
	.align	2
$LC3:
	.ascii	"Iteration %d: Branch 2 not taken\n\000"
	.align	2
$LC4:
	.ascii	"Iteration %d: Branch 3 taken\n\000"
	.align	2
$LC5:
	.ascii	"Iteration %d: Branch 3 not taken\n\000"
	.align	2
$LC6:
	.ascii	"Iteration %d: Branch 4 taken\n\000"
	.align	2
$LC7:
	.ascii	"Iteration %d: Branch 4 not taken\n\000"
	.align	2
$LC8:
	.ascii	"Iteration %d: Branch 5 taken\n\000"
	.align	2
$LC9:
	.ascii	"Iteration %d: Branch 5 not taken\n\000"
	.align	2
$LC10:
	.ascii	"   Inner Loop %d: Branch taken\n\000"
	.align	2
$LC11:
	.ascii	"   Inner Loop %d: Branch not taken\n\000"
	.text
	.align	2
	.globl	complex_branching
	.rdata
	.align	2
$LC12:
	.ascii	"Advanced Branch Prediction Test\n\000"
	.align	2
$LC13:
	.ascii	"Simulating complex branching with random decisions...\n\000"
	.text
	.align	2
	.globl	main

	.text

	.loc	1 6
	.ent	random_branch
random_branch:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	jal	rand
	sra	$3,$2,31
	srl	$4,$3,31
	addu	$5,$2,$4
	sra	$3,$5,1
	move	$4,$3
	sll	$3,$4,1
	subu	$4,$2,$3
	move	$2,$4
	j	$L1
$L1:
	move	$sp,$fp			# sp not trusted here
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	random_branch

	.loc	1 11
	.ent	complex_branching
complex_branching:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$0,16($fp)
$L3:
	lw	$2,16($fp)
	lw	$3,40($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L6
	j	$L4
$L6:
	lw	$2,16($fp)
	li	$6,0x66666667		# 1717986919
	mult	$2,$6
	mfhi	$5
	mflo	$4
	srl	$6,$5,0
	move	$7,$0
	sra	$3,$6,1
	sra	$4,$2,31
	subu	$3,$3,$4
	move	$5,$3
	sll	$4,$5,2
	addu	$4,$4,$3
	subu	$2,$2,$4
	bne	$2,$0,$L7
	jal	random_branch
	sw	$2,24($fp)
	lw	$2,24($fp)
	beq	$2,$0,$L8
	la	$4,$LC0
	lw	$5,16($fp)
	jal	printf
	j	$L9
$L8:
	la	$4,$LC1
	lw	$5,16($fp)
	jal	printf
$L9:
	j	$L10
$L7:
	lw	$2,16($fp)
	li	$6,0x66666667		# 1717986919
	mult	$2,$6
	mfhi	$5
	mflo	$4
	srl	$6,$5,0
	move	$7,$0
	sra	$3,$6,1
	sra	$4,$2,31
	subu	$3,$3,$4
	move	$5,$3
	sll	$4,$5,2
	addu	$4,$4,$3
	subu	$2,$2,$4
	li	$3,0x00000001		# 1
	bne	$2,$3,$L11
	jal	random_branch
	sw	$2,24($fp)
	lw	$2,24($fp)
	beq	$2,$0,$L12
	la	$4,$LC2
	lw	$5,16($fp)
	jal	printf
	j	$L13
$L12:
	la	$4,$LC3
	lw	$5,16($fp)
	jal	printf
$L13:
	j	$L14
$L11:
	lw	$2,16($fp)
	li	$6,0x66666667		# 1717986919
	mult	$2,$6
	mfhi	$5
	mflo	$4
	srl	$6,$5,0
	move	$7,$0
	sra	$3,$6,1
	sra	$4,$2,31
	subu	$3,$3,$4
	move	$5,$3
	sll	$4,$5,2
	addu	$4,$4,$3
	subu	$2,$2,$4
	li	$3,0x00000002		# 2
	bne	$2,$3,$L15
	jal	random_branch
	sw	$2,24($fp)
	lw	$2,24($fp)
	beq	$2,$0,$L16
	la	$4,$LC4
	lw	$5,16($fp)
	jal	printf
	j	$L17
$L16:
	la	$4,$LC5
	lw	$5,16($fp)
	jal	printf
$L17:
	j	$L18
$L15:
	lw	$2,16($fp)
	li	$6,0x66666667		# 1717986919
	mult	$2,$6
	mfhi	$5
	mflo	$4
	srl	$6,$5,0
	move	$7,$0
	sra	$3,$6,1
	sra	$4,$2,31
	subu	$3,$3,$4
	move	$5,$3
	sll	$4,$5,2
	addu	$4,$4,$3
	subu	$2,$2,$4
	li	$3,0x00000003		# 3
	bne	$2,$3,$L19
	jal	random_branch
	sw	$2,24($fp)
	lw	$2,24($fp)
	beq	$2,$0,$L20
	la	$4,$LC6
	lw	$5,16($fp)
	jal	printf
	j	$L21
$L20:
	la	$4,$LC7
	lw	$5,16($fp)
	jal	printf
$L21:
	j	$L22
$L19:
	jal	random_branch
	sw	$2,24($fp)
	lw	$2,24($fp)
	beq	$2,$0,$L23
	la	$4,$LC8
	lw	$5,16($fp)
	jal	printf
	j	$L24
$L23:
	la	$4,$LC9
	lw	$5,16($fp)
	jal	printf
$L24:
$L22:
$L18:
$L14:
$L10:
	.set	noreorder
	nop
	.set	reorder
	sw	$0,20($fp)
$L25:
	lw	$2,20($fp)
	slt	$3,$2,3
	bne	$3,$0,$L28
	j	$L26
$L28:
	jal	random_branch
	sw	$2,24($fp)
	lw	$2,24($fp)
	beq	$2,$0,$L29
	la	$4,$LC10
	lw	$5,20($fp)
	jal	printf
	j	$L30
$L29:
	la	$4,$LC11
	lw	$5,20($fp)
	jal	printf
$L30:
$L27:
	lw	$3,20($fp)
	addu	$2,$3,1
	move	$3,$2
	sw	$3,20($fp)
	j	$L25
$L26:
$L5:
	lw	$3,16($fp)
	addu	$2,$3,1
	move	$3,$2
	sw	$3,16($fp)
	j	$L3
$L4:
$L2:
	move	$sp,$fp			# sp not trusted here
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addu	$sp,$sp,40
	j	$31
	.end	complex_branching

	.loc	1 71
	.ent	main
main:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	jal	__main
	move	$4,$0
	jal	time
	move	$4,$2
	jal	srand
	li	$2,0x00000064		# 100
	sw	$2,16($fp)
	la	$4,$LC12
	jal	printf
	la	$4,$LC13
	jal	printf
	lw	$4,16($fp)
	jal	complex_branching
	move	$2,$0
	j	$L31
$L31:
	move	$sp,$fp			# sp not trusted here
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addu	$sp,$sp,32
	j	$31
	.end	main
