.bss
.lcomm iteratory, 8
.text
.global calka_double
.type calka_double, @function
calka_double:

movq $0x00000000000000000, %rax
movd %rax, %xmm5

#na edi mam ilosc potrzebnych iteracji
subpd %xmm0, %xmm1	# xk-xp
divpd %xmm2, %xmm1	# ()/n
#na %xmm1 mam dx
punpcklqdq %xmm1, %xmm1  	#wypelnianie rejestru stala wartoscia

#kolejne propagowanie, tym razem wartości xp
movsd %xmm0, %xmm2
punpcklqdq %xmm2, %xmm2  	#rozpropagowanie wartości po rejestrze (wartości double)


xorl %eax, %eax
xorl %esi, %esi #licznik petli

incl %eax
movl %eax, iteratory		#przenosze pierwszą wartość

incl %eax
movl %eax, iteratory + 4	#przenoszę druga wartość

cvtdq2pd iteratory, %xmm3

#wypelneine jedynkami w celu pozniejszego podzielenia
movq $0x3ff0000000000000, %rbx
movd %rbx, %xmm4

punpcklqdq %xmm4, %xmm4  	#wypelnianie rejestru stala wartoscia

#######################################################
petla_for: 
movupd %xmm3, %xmm7		#kopia iteratorow
mulpd %xmm1, %xmm7    		#wynik mno?enia mam na xmm7, mnoze przez dx
addpd %xmm2, %xmm7		
movupd %xmm4, %xmm6		#kopia jedynek
divpd %xmm7, %xmm6		#dziele przez uzyskny wczensije wynik
addpd %xmm6, %xmm5		#sumowanie
addpd %xmm4, %xmm3		#dodaje 1 czyli mam 2,3 / 4, 5
addpd %xmm4, %xmm3		#dodaje 1 czyli mam 2,3 / 4, 5

decl %edi
jnz petla_for
########################################################
haddpd %xmm5, %xmm5

movsd %xmm1, %xmm0

mulpd %xmm5, %xmm0

ret
