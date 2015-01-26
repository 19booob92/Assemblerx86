    .globl	set_fpu
	.type	set_fpu, @function
set_fpu:
	pushq	%rbp
	movq	%rsp, %rbp
	fstcw	-8(%rbp)
	movw    $0x7f, -8(%rbp)
	FLDCW   -8(%rbp)
        fstcw 	-8(%rbp)
	movw 	-8(%rbp), %ax
	popq	%rbp
	ret
