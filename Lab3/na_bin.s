.text
.global na_bin
na_bin:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
#l=k=0
	movl	$0, l(%rip)
	movl	l(%rip), %eax
	movl	%eax, k(%rip)
	jmp	.petla_while
.petla_for_poczatek:
	movl	$0, p(%rip)
	jmp	.petla_for_warunek
.warunek_cyfry:
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$47, %al
	jle	.warunek_duze_litery
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$57, %al
	jg	.warunek_duze_litery
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
	jmp	.wydobywanie_reszty
.warunek_duze_litery:
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$64, %al
	jle	.warunek_male_litery
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$70, %al
	jg	.warunek_male_litery
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
	jmp	.wydobywanie_reszty
.warunek_male_litery:
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$96, %al
	jle	.wydobywanie_reszty
	movl	k(%rip), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$102, %al
#skacz jeśłi większe
	jg	.wydobywanie_reszty
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
.wydobywanie_reszty:
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
#arytmetyczne przesunięcie w prawo
	sarb	$7, %dl
#przesunięcie bitowe w prawo
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
.petla_for_warunek:
	movl	p(%rip), %eax
	cmpl	$3, %eax
	jle	.warunek_cyfry
	movl	k(%rip), %eax
	addl	$1, %eax
	movl	%eax, k(%rip)
.petla_while:
	movl	k(%rip), %eax
	movslq	%eax, %rdx
#pierwszy parametr funkcji na rax
	movq	-8(%rbp), %rax
#poruszanie się po elementach wczytanej tablicy
	addq	%rdx, %rax
	movzbl	(%rax), %eax
#nie zmienia watości rejestru ale ustawia flagi
#identycznie jak funkcja AND
	testb	%al, %al
	jne	.petla_for_poczatek
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
