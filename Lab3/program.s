	.file	"program.c"
	.comm	tmp,1,1
	.comm	liczba,10000,32
	.comm	liczba2,10000,32
	.comm	buffor_bin,40000,32
	.comm	buffor_bin2,40000,32
	.comm	wynik,40000,32
	.comm	j,4,4
	.comm	k,4,4
	.comm	p,4,4
	.comm	i,4,4
	.comm	l,4,4
	.comm	o,4,4
	.comm	m,4,4
	.comm	a,4,4
	.comm	n,4,4
	.globl	carry
	.bss
	.align 4
	.type	carry, @object
	.size	carry, 4
carry:
	.zero	4
	.globl	suma
	.align 4
	.type	suma, @object
	.size	suma, 4
suma:
	.zero	4
	.comm	dl1,4,4
	.comm	dl2,4,4
	.text
	.globl	na_bin
	.type	na_bin, @function
na_bin:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$0, l(%rip)
	movl	l(%rip), %eax
	movl	%eax, k(%rip)
	jmp	.L2
.L8:
	movl	$0, p(%rip)
	jmp	.L3
.L7:
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$47, %al
	jle	.L4
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$57, %al
	jg	.L4
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	k(%rip), %eax
	movslq	%eax, %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	subl	$48, %eax
	movb	%al, (%rdx)
	jmp	.L5
.L4:
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$64, %al
	jle	.L6
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$70, %al
	jg	.L6
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	k(%rip), %eax
	movslq	%eax, %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	subl	$65, %eax
	movb	%al, (%rdx)
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	k(%rip), %eax
	movslq	%eax, %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	addl	$10, %eax
	movb	%al, (%rdx)
	jmp	.L5
.L6:
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$96, %al
	jle	.L5
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$102, %al
	jg	.L5
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	k(%rip), %eax
	movslq	%eax, %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	subl	$97, %eax
	movb	%al, (%rdx)
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	k(%rip), %eax
	movslq	%eax, %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	addl	$10, %eax
	movb	%al, (%rdx)
.L5:
	movl	l(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-16(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movl	%eax, %edx
	sarb	$7, %dl
	shrb	$7, %dl
	addl	%edx, %eax
	andl	$1, %eax
	subl	%edx, %eax
	movsbl	%al, %eax
	movl	%eax, (%rcx)
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	k(%rip), %eax
	movslq	%eax, %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movl	%eax, %ecx
	shrb	$7, %cl
	addl	%ecx, %eax
	sarb	%al
	movb	%al, (%rdx)
	movl	l(%rip), %eax
	addl	$1, %eax
	movl	%eax, l(%rip)
	movl	p(%rip), %eax
	addl	$1, %eax
	movl	%eax, p(%rip)
.L3:
	movl	p(%rip), %eax
	cmpl	$3, %eax
	jle	.L7
	movl	k(%rip), %eax
	addl	$1, %eax
	movl	%eax, k(%rip)
.L2:
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L8
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	na_bin, .-na_bin
	.globl	zm_kol
	.type	zm_kol, @function
zm_kol:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	l(%rip), %eax
	movl	%eax, n(%rip)
	movl	$0, a(%rip)
	jmp	.L10
.L15:
	movl	$0, i(%rip)
	jmp	.L11
.L14:
	movl	n(%rip), %eax
	movl	%eax, m(%rip)
	jmp	.L12
.L13:
	movl	m(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movb	%al, tmp(%rip)
	movl	m(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movl	m(%rip), %eax
	cltq
	subq	$1, %rax
	leaq	0(,%rax,4), %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %eax
	movl	%eax, (%rdx)
	movl	m(%rip), %eax
	cltq
	subq	$1, %rax
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movzbl	tmp(%rip), %eax
	movsbl	%al, %eax
	movl	%eax, (%rdx)
	movl	m(%rip), %eax
	subl	$1, %eax
	movl	%eax, m(%rip)
.L12:
	movl	m(%rip), %edx
	movl	a(%rip), %eax
	cmpl	%eax, %edx
	jg	.L13
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
	movl	a(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %eax
	movl	%eax, (%rdx)
	movl	a(%rip), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rax, %rdx
	movzbl	tmp(%rip), %eax
	movsbl	%al, %eax
	movl	%eax, (%rdx)
	movl	i(%rip), %eax
	addl	$1, %eax
	movl	%eax, i(%rip)
.L11:
	movl	i(%rip), %eax
	cmpl	$3, %eax
	jle	.L14
	movl	a(%rip), %eax
	addl	$4, %eax
	movl	%eax, a(%rip)
.L10:
	movl	l(%rip), %eax
	leal	-4(%rax), %edx
	movl	a(%rip), %eax
	cmpl	%eax, %edx
	jg	.L15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	zm_kol, .-zm_kol
	.globl	odw
	.type	odw, @function
odw:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, m(%rip)
	movl	-12(%rbp), %eax
	movl	%eax, n(%rip)
	jmp	.L17
.L18:
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
.L17:
	movl	m(%rip), %edx
	movl	n(%rip), %eax
	cmpl	%eax, %edx
	jl	.L18
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	odw, .-odw
	.globl	dodawanie
	.type	dodawanie, @function
dodawanie:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	dl1(%rip), %edx
	movl	dl2(%rip), %eax
	cmpl	%eax, %edx
	jle	.L20
	movl	dl1(%rip), %eax
	addl	$1, %eax
	movl	%eax, a(%rip)
	jmp	.L21
.L20:
	movl	dl2(%rip), %eax
	addl	$1, %eax
	movl	%eax, a(%rip)
.L21:
	movl	$0, m(%rip)
	jmp	.L22
.L27:
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
	jne	.L23
	movl	m(%rip), %eax
	cltq
	movl	$0, wynik(,%rax,4)
	movl	$0, carry(%rip)
.L23:
	movl	suma(%rip), %eax
	cmpl	$1, %eax
	jne	.L24
	movl	m(%rip), %eax
	cltq
	movl	$1, wynik(,%rax,4)
	movl	$0, carry(%rip)
.L24:
	movl	suma(%rip), %eax
	cmpl	$2, %eax
	jne	.L25
	movl	m(%rip), %eax
	cltq
	movl	$0, wynik(,%rax,4)
	movl	$1, carry(%rip)
.L25:
	movl	suma(%rip), %eax
	cmpl	$3, %eax
	jne	.L26
	movl	m(%rip), %eax
	cltq
	movl	$1, wynik(,%rax,4)
	movl	$1, carry(%rip)
.L26:
	movl	m(%rip), %eax
	addl	$1, %eax
	movl	%eax, m(%rip)
.L22:
	movl	m(%rip), %edx
	movl	a(%rip), %eax
	cmpl	%eax, %edx
	jle	.L27
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	dodawanie, .-dodawanie
	.section	.rodata
.LC0:
	.string	"Podaj liczb\304\231 w HEX: "
.LC1:
	.string	"Podaj drug\304\205 liczb\304\231 w HEX: "
.LC2:
	.string	"Liczba bin: "
.LC3:
	.string	"%d"
.LC4:
	.string	"druga liczba bin: "
	.text
	.globl	main
	.type	main, @function
main:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$.LC0, %edi
	call	puts
	movl	$liczba, %edi
	call	gets
	movl	$liczba, %edi
	call	puts
	movl	$.LC1, %edi
	call	puts
	movl	$liczba2, %edi
	call	gets
	movl	$liczba2, %edi
	call	puts
	movl	$buffor_bin, %esi
	movl	$liczba, %edi
	call	na_bin
	movl	l(%rip), %eax
	movl	%eax, dl1(%rip)
	movl	$buffor_bin, %edi
	call	zm_kol
	movl	$buffor_bin2, %esi
	movl	$liczba2, %edi
	call	na_bin
	movl	l(%rip), %eax
	movl	%eax, dl2(%rip)
	movl	$buffor_bin2, %edi
	call	zm_kol
	movl	$buffor_bin2, %esi
	movl	$buffor_bin, %edi
	call	dodawanie
	movl	a(%rip), %eax
	movl	%eax, k(%rip)
	movl	l(%rip), %eax
	subl	$1, %eax
	movl	%eax, %esi
	movl	$buffor_bin2, %edi
	call	odw
	movl	dl1(%rip), %eax
	subl	$1, %eax
	movl	%eax, %esi
	movl	$buffor_bin, %edi
	call	odw
	movl	$.LC2, %edi
	call	puts
	movl	$0, j(%rip)
	jmp	.L29
.L30:
	movl	j(%rip), %eax
	cltq
	movl	buffor_bin(,%rax,4), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	j(%rip), %eax
	addl	$1, %eax
	movl	%eax, j(%rip)
.L29:
	movl	j(%rip), %edx
	movl	dl1(%rip), %eax
	cmpl	%eax, %edx
	jl	.L30
	movl	$10, %edi
	call	putchar
	movl	$.LC4, %edi
	call	puts
	movl	$0, j(%rip)
	jmp	.L31
.L32:
	movl	j(%rip), %eax
	cltq
	movl	buffor_bin2(,%rax,4), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	j(%rip), %eax
	addl	$1, %eax
	movl	%eax, j(%rip)
.L31:
	movl	j(%rip), %edx
	movl	dl2(%rip), %eax
	cmpl	%eax, %edx
	jl	.L32
	movl	a(%rip), %eax
	subl	$1, %eax
	movl	%eax, %esi
	movl	$wynik, %edi
	call	odw
	movl	$10, %edi
	call	putchar
	movl	$0, j(%rip)
	jmp	.L33
.L34:
	movl	j(%rip), %eax
	cltq
	movl	wynik(,%rax,4), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	j(%rip), %eax
	addl	$1, %eax
	movl	%eax, j(%rip)
.L33:
	movl	j(%rip), %edx
	movl	k(%rip), %eax
	cmpl	%eax, %edx
	jl	.L34
	movl	$10, %edi
	call	putchar
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.7.2-2ubuntu1) 4.7.2"
	.section	.note.GNU-stack,"",@progbits
