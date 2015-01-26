.globl	calka_fpu
.type	calka_fpu, @function

calka_fpu:
pushq	%rbp
movq	%rsp, %rbp
movsd 	%xmm0, -8(%rbp)		#xp
movsd	%xmm1, -16(%rbp)	#xk
movsd	%xmm2, -24(%rbp)	#n

fldl	-24(%rbp)				
fldl	-16(%rbp)		
fsubl	-8(%rbp)
fdivl	-24(%rbp)		#tutaj mam dx st(0)
fstpl	-56(%rbp)		#zrzucam dx na pamieć
fldl	-56(%rbp)		#dx na stos
fld1				
fld1				
fldl	-8(%rbp)		#xp
fld1				
fldz				#wrzucam zero
jmp 	petla_ite

petla_for:
fxch	%st(3)		#zamineianie st z st3
petla_ite:
fxch	%st(5) 		#mnożenie dx * iterator 
fmul	%st(3)
fxch	%st(5)
fxch	%st(2)
fadd	%st(5)
fxch	%st(2)
fxch	%st(1)		#1 / wynik aktualny
fdiv	%st(2)
fxch	%st(1)

fadd	%st(1)

fxch	%st(5) 		#ponowne wczytanie wartości
fstpl	-40(%rbp)
fldl	-56(%rbp)
fxch	%st(5)
fxch	%st(2)
fstpl	-40(%rbp)
fldl	-8(%rbp)
fxch	%st(2)
	
fxch	%st(1)
fstpl	-40(%rbp)
fld1
fxch	%st(1)
	
fxch	%st(3)
fadd	%st(4)
fcomi	%st(6)
jbe	petla_for
fxch	%st(3) 		#czyszczenie stosu
fmull	-56(%rbp) 	#ostaeczny wynik

fstpl	-40(%rbp)
movsd	-40(%rbp), %xmm0 #zwracanie wyniku

popq	%rbp
ret
	
