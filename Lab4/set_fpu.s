    .globl	set_fpu
	.type	set_fpu, @function
set_fpu:
	pushq	%rbp
	movq	%rsp, %rbp
	fstcw	-8(%rbp)
	movw    $0x047f, -8(%rbp)
	FLDCW   -8(%rbp)
    	
	popq	%rbp
	ret
