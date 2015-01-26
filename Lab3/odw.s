.text
.global odw
odw:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
#deklaracja zmeinnej m
	movl	$0, m(%rip)
#zrzucenie drugiego parametru na eax
	movl	-12(%rbp), %eax
	movl	%eax, n(%rip)
	jmp	.petla_while
.zamiana:
	movl	n(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movb	%al, tmp(%rip)
	movl	n(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	m(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %eax
	movl	%eax, (%rdx)
	movl	m(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movzbl	tmp(%rip), %eax
	movsbl	%al, %eax
	movl	%eax, (%rdx)
	movl	m(%rip), %eax
	addl	$1, %eax
	movl	%eax, m(%rip)
	movl	n(%rip), %eax
	subl	$1, %eax
	movl	%eax, n(%rip)
.petla_while:
	movl	m(%rip), %edx
	movl	n(%rip), %eax
	cmpl	%eax, %edx
	jl	.zamiana
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
