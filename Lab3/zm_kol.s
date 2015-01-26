.text
.global zm_kol
zm_kol:
#inicjalizuje wewneŧrzne struktury danych dla
#funkcji
	.cfi_startproc
	pushq	%rbp
#nakazanie CFA używania danego offsetu 
	.cfi_def_cfa_offset 16
#przekazuje informację, że wartość '6' jest
#zapisana pod adresem -16 względem CFA
	.cfi_offset 6, -16
	movq	%rsp, %rbp
#nakazuje CFA przyjęcie wartości '6'
	.cfi_def_cfa_register 6
#zrzucenie rdi pod odpowienie miejsce na stosie
	movq	%rdi, -8(%rbp)
#n = l
	movl	l(%rip), %eax
	movl	%eax, n(%rip)
#a = 0
	movl	$0, a(%rip)
	jmp	.petla_while
.petla_for:
#deklaracja zmiennej z wartością domyślną 0
	movl	$0, i(%rip)
	jmp	.petla_for_i
.mEQn:
#przepisanie wartosci n na zmienną m
	movl	n(%rip), %eax
	movl	%eax, m(%rip)
	jmp	.zamiana_sasiednich_bitow
.zamiana_ost_bit:
	movl	m(%rip), %eax
#rozszerzenie do 64 bit
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
.zamiana_sasiednich_bitow:
	movl	m(%rip), %edx
	movl	a(%rip), %eax
	cmpl	%eax, %edx
	jg	.zamiana_ost_bit
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
#wypełnia zerami rejestr, w przypadku gdy nie jest
#w pełni uzupełniony
	movzbl	tmp(%rip), %eax
#rozszerzenie znakiem bajtu
	movsbl	%al, %eax
	movl	%eax, (%rdx)
	movl	i(%rip), %eax
	addl	$1, %eax
	movl	%eax, i(%rip)
.petla_for_i:
#przepisanie zmiennej i na EAX
	movl	i(%rip), %eax
#porównanie wartosći zmiennej i z 3
	cmpl	$3, %eax
#jeśli i <= 3 powtarzaj pętle
	jle	.mEQn
#jeśli i przekroczyło 3 to dodaj '4' do a
	movl	a(%rip), %eax
	addl	$4, %eax
	movl	%eax, a(%rip)
.petla_while:
	movl	l(%rip), %eax
	leal	-4(%rax), %edx
	movl	a(%rip), %eax
	cmpl	%eax, %edx
#jeśli wartość przeniesiona na edx > eax skacz do
#poczatku petli
	jg	.petla_for
#ponieważ każda funkcja wrzuca na stos ebp
#32 bity, lub rbp (64 bit)
	popq	%rbp
#obliczanie CFA = 7 + 8
	.cfi_def_cfa 7, 8
#powrót do miejsca gdzie została wywołana funkcja
	ret
	.cfi_endproc
