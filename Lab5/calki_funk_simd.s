.bss
.lcomm iteratory, 16
.data

.text
.global calka
.type calka, @function
calka:
pushq %rbp
movq %rsp, %rbp

movl $0x00000000000000000000000000000000, %eax
movd %eax, %xmm4

subps %xmm0, %xmm1			#od xk - xp
divps %xmm2, %xmm1			#divl 

punpckldq %xmm1, %xmm1	#propagacja na xmm1 wartosci dx
punpckldq %xmm1, %xmm1

movups %xmm0, %xmm2

punpcklqdq %xmm2, %xmm2

xorl %eax, %eax  #licznik pętli
xorl %esi, %esi

incl %eax
movl %eax, iteratory

incl %eax
movl %eax, iteratory + 4

incl %eax
movl %eax, iteratory + 8

incl %eax
movl %eax, iteratory +12

movupd iteratory, %xmm3  

cvtdq2ps %xmm3, %xmm3

movl $0x3F800000, %eax
movd %eax, %xmm5			#tu bedzie blad

punpckldq %xmm5, %xmm5
punpckldq %xmm5, %xmm5

#######################################################
petla_for: 
movaps %xmm3, %xmm7

mulps %xmm1, %xmm7

addps %xmm2, %xmm7

movaps %xmm5, %xmm6

divps %xmm7, %xmm6

addps %xmm6, %xmm4

addps %xmm5, %xmm3
addps %xmm5, %xmm3
addps %xmm5, %xmm3
addps %xmm5, %xmm3

decl %edi
jnz petla_for   #skacz jeśili licznik <= 
########################################################
haddps %xmm4, %xmm4
haddps %xmm4, %xmm4  #ostateczny wynik

movups %xmm1, %xmm0

mulps %xmm4, %xmm0

#cvtss2sd %xmm0, %xmm0 #konwersja z float na double

#MOVlhPS %xmm2, %xmm0

popq %rbp	

ret
