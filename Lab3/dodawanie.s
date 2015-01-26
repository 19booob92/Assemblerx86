.text
.global dodawanie
dodawanie:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#sprawdzanie co jest większe
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	dl1(%rip), %edx
	movl	dl2(%rip), %eax
	cmpl	%eax, %edx
	jle	.aEQdl2PLUS1
	movl	dl1(%rip), %eax
	addl	$1, %eax
	movl	%eax, a(%rip)
	jmp	.zmienna_m
.aEQdl2PLUS1:
	movl	dl2(%rip), %eax
	addl	$1, %eax
	movl	%eax, a(%rip)
.zmienna_m:
	movl	$0, m(%rip)
	jmp	.petla_for
.obliczanie_sumy:
	movl	m(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	movl	m(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	movq	-16(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %eax
	addl	%eax, %edx
	movl	carry(%rip), %eax
	addl	%edx, %eax
	movl	%eax, suma(%rip)
	movl	suma(%rip), %eax
	testl	%eax, %eax
	jne	.warunek_sumaEQ1
	movl	m(%rip), %eax
	cltq
	movl	$0, wynik(,%rax,4)
	movl	$0, carry(%rip)
.warunek_sumaEQ1:
	movl	suma(%rip), %eax
	cmpl	$1, %eax
	jne	.warunek_sumaEQ2
	movl	m(%rip), %eax
	cltq
	movl	$1, wynik(,%rax,4)
	movl	$0, carry(%rip)
.warunek_sumaEQ2:
	movl	suma(%rip), %eax
	cmpl	$2, %eax
	jne	.warunek_sumaEQ3
	movl	m(%rip), %eax
	cltq
	movl	$0, wynik(,%rax,4)
	movl	$1, carry(%rip)
.warunek_sumaEQ3:
	movl	suma(%rip), %eax
	cmpl	$3, %eax
	jne	.petla_for_mPLUS
	movl	m(%rip), %eax
	cltq
	movl	$1, wynik(,%rax,4)
	movl	$1, carry(%rip)
.petla_for_mPLUS:
	movl	m(%rip), %eax
	addl	$1, %eax
	movl	%eax, m(%rip)
.petla_for:
	movl	m(%rip), %edx
	movl	a(%rip), %eax
	cmpl	%eax, %edx
	jle	.obliczanie_sumy
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
