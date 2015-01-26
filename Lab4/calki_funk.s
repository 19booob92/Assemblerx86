.data
.equ n, 1000000
.text
.global calka
.type calka, @function
calka:
pushq %rbp
movq %rsp, %rbp
movsd %xmm0, -8(%rbp) #tutaj mam xp
movsd %xmm1, -16(%rbp) #a tu xk
movq $n, -24(%rbp) #zmienna n
movq $0, -48(%rbp) #zeruje pamięć na akumulator

fldl -16(%rbp)	 #wrzucam na st(0) xp
fsubl -8(%rbp)	 #xk - xp, wynik mam na st(0)

fildl -24(%rbp)	 #st0 <= n, a wynik na st1
fdivr %st(0), %st(1) #st(1) / n ,wynik na st(1)

fistpl -16(%rbp) #i z powrotrem
fstl -32(%rbp)
fstl -56(%rbp)	 #kopia zapasowa zmiennej (dx)

movl $1, %esi 	#licznik pętli
petla_for: 
movq %rsi, -40(%rbp)#przenoszę i na pamięć
fildl -40(%rbp)

fmul %st(0), %st(1)#na st(1) wynik z mnożenia
fxch %st(1) 	#zamiana z st(0)

faddl -8(%rbp)

fstpl -32(%rbp) #ściągamgam dzielnik (xp+(i*dx))

fld1 		#wrzucam '1' na st
fdivl -32(%rbp) #dzienie przez (xp+(i*dx))

fldl -48(%rbp)
fadd %st(1), %st(0)#dodanie do wyniku dzielenia
fstpl -48(%rbp) #Żeby można bylo dodawnac wyniki

fstpl -16(%rbp) #śmieci (zrzucenie ze stosu)
fstpl -16(%rbp) #smieci (zrzucenie ze stosu)

fldl -56(%rbp)  #wczytanie na st zmiennje dx

cmpq -24(%rbp), %rsi
incq %rsi
jbe petla_for   #skacz jeśili licznik <= n

fldl -48(%rbp)  #wrzucam na st(0) ostaeczney WYNIK
fmull -56(%rbp) #wynik *= dx

fstpl -8(%rbp)  #ostateczny wynik mam na -8(%rbp)

movsd -8(%rbp), %xmm0
popq %rbp 	

ret
