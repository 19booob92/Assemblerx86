.data
	witaj: .ascii "podaj liczbe: \n"
	witaj_len = .- witaj

	bin: .ascii "podałeś liczbę w formacie binarnym\n"
	bin_len = .- bin
	
	hex: .ascii "Podałeś liczbę w formacie hexadecymalnym\n"
	hex_len = .- hex

	dec: .ascii "Podałeś liczbę w formacie dziesiętnym\n"
	dec_len = .- dec

	pytanie: .ascii "Wpisz d - wyrównaj do Uppercase, m - lowercase\n"
	pytanie_len= .- pytanie	

	zly_znak: .ascii "Tekst zawiera błedny znak/znaki, spróbuj jeszcze raz:\n"
	zly_znak_len = .- zly_znak

	oct: .ascii "Podałeś liczbę w formacie ósemkowym\n"
	oct_len = .- oct	

	binarna: .ascii "Reprezentacja binarna"
	binarna_len= .-binarna

	octal: .ascii "Reprezentacja octalna"
	octal_len= .-octal

	decimal: .ascii "Reprezentacja decymala"
	decimal_len= .-decimal
	
	hexadecimal: .ascii "Reprezentacja hexdecymalna"
	hexadecimal_len= .-hexadecimal

	enter: .ascii "\n"
	ent_len= .-enter

.bss
	.lcomm zmienna, 1000	#zmienna przechowuje podane dane (buffor)
	.lcomm wybor, 1		#buffor na wybor user' a
	.lcomm output 1000	#wynik w postaci ascii
	.lcomm output_oct 1000  #wynik kolejnej konwersjii w ascii
	.lcomm output_dec 1000  #wynik kolejnej konwersjii w ascii

.text
#stałe
MALE = 'm'
DUZE = 'd'
PRZERWANIE = 0x80
SYS_EXIT = 1
SYS_WRITE = 4
STDOUT = 1
SYS_READ = 3
STDIN = 0
ZNAK_LF = 10
#koniec stałych

.global _start
_start:
#powitanie			#tutaj używanm funkcji
pushl $witaj_len		#w odwrotnej kolejności relatywnie do 
				#kolejności rejestrów, bo rzucam na stos
pushl $witaj
call wyswietl
addl $8, %esp			#oba "stringi" mają po 4Bajty
#koniec powitania

#wczytanie danych
wczytywanie:
	movl $SYS_READ, %eax
	movl $STDIN, %ebx
	movl $zmienna, %ecx
	movl $500, %edx
	int $PRZERWANIE
#koniec wczytywania

#sprawdzanie poprawności podanych znaków mogą to być tylko znaki E <0, 9> 
#u <A, F> u <a, f>
#przeniesienie "stałych" na rejestry (ograniczenia związane z przenoszeniem
# danych)
movb $'a', %ah
movb $'f', %al
movb $'0', %bh
movb $'9', %bl
movb $'A', %ch
movb $'F', %cl
movb $'x', %dh
movb $10, %dl			#kod końca linii w UNIX/LINUX, "Line Feed"

xorl %edi, %edi

	petla_spr:				
		cmpb zmienna(%edi), %dl	#jeśli znak końca lini to idź do 
					#etykiety, wykonującej dalsze części
					# programu
			je spr_typ

		cmpb zmienna(%edi), %bh	#jesli znak < '0' to na pewno podano 
					#zły znak
			ja zly_koniec	

		cmpb zmienna(%edi), %bl	#jesli znak > '9' jest szansa, że
					# znak mieści się w innym przedziale
			jb zly		#skok do dalszego sprawdzania
dobry:					#skok do etykiety gdy wszysko jest ok 					        #i można przejść do nastepnego znaku
		incl %edi			
		jmp petla_spr		#zapętlaj (warunek wyjścia z pętli 					        #znajduje się wyżej)

zly:					#sprawdzenie 2-ego przedziału
		cmpb zmienna(%edi), %ch	#jeżeli znak < 'A' to wiemy już że na
					#pewno lezy w nie poprawnym przedziale
			ja zly_koniec	#wczytujemy ponownie
		cmpb zmienna(%edi), %cl	#jeżeli znak > 'F' to jest on zły ale 
					#nadal ma szansę znaleźć się w 
					#poprawnym przedziale <a, f>
			jb zly_nadal
			jmp dobry	#jeśli jest ok: skocz

zly_nadal:				#sprawdzenie 3-ego przedziału
		cmpb zmienna(%edi), %ah	#jeśli znak < 'a', wiemy już że musi
					# być zły bo nie mieścił się 
					#poprzednich przedziałach
			ja zly_koniec
		cmpb zmienna(%edi), %dh	#jeśli znak < 'f', wiemy już że musi 
					#być zły bo nie mieścił się poprzednich 					#przedziałach
			je dobry
		cmpb zmienna(%edi), %al	#jeśli znak < 'f' to jest ok
			jae dobry
zly_koniec:			
		pushl $zly_znak_len
  		pushl $zly_znak
   		call wyswietl
   		addl $8, %esp

		jmp wczytywanie		#skok do dalszego wczytywania danych, 
					#aż będą one poprawne
#koniec: sprawdzanie poprawności podanych znaków mogą to być znak
# E <0, 9> u <A, F> u <a, f>

spr_typ:
#sprawdzanie typu liczby
xorl %edi, %edi				#zerowanie edi

#blok szukanych wartości
movb $'0', %ah
movb $'x', %bh
movb $'b', %ch
movb $'c', %al
movb $'9', %bl
movb $10 , %dl
movb $'7', %cl
movb $'1', %dh

#koniec bloku szukanych wartości
movl $2, %esi
cmpb zmienna(%edi), %ah			#sprawdzam czy pierwszy znak podanego 
					#ciągu to '0', (numer znaku '0' jest 
					#w ah - 1 B rejestrze)
	je spr_dalej			#jeżeli mamy '0' to sprawszamy dalej

	jmp wys_dec			#jeżeli znak jest inny, dalsza detekcja 					#nie ma sensu, informuje że podana 
					#liczba jest typu dec

		spr_dalej:			
			movl $1, %edi	#teraz interesuje nas 2 znak
			cmpb zmienna(%edi), %bh
				je wys_hex#jeżeli jest = 'x' to skaczemy do 
					  #etykiety gdzie wyświetlamy adekwatną 					  #informację
			cmpb zmienna(%edi), %ch
				je wys_bin#jeżeli jest = 'b' to skaczemy do 
					  #etykiety gdzie wyświetlamy adekwatną 					  #informację
			cmpb zmienna(%edi), %al
				je wys_oct
wys_dec:				#jeżeli 2 znak nie jest jednym spośród 
					#szukanych to liczba jest dec
	cmpb zmienna(%esi), %dl		#szukanie końca łańcucha
		je skacz
			cmpb zmienna(%esi), %bl#sprawdzanie czy tekst zawiera 
					#błędne znaki tj inne niż 0 - 9
				incl %esi
				ja wys_dec
					jmp zly_koniec
		
		skacz:			#wypisywanie informacje o typie liczby
			pushl $dec_len
  			pushl $dec
   			call wyswietl
   			addl $8, %esp
			jmp wyjdz

#koniec sprawdzania typu
wys_oct:
cmpb zmienna(%esi), %dl			#szukanie końca łańcucha
		je skacz_oc
			cmpb zmienna(%esi), %cl#sprawdzanie czy tekst zawiera 
					#błędne znaki tj inne niż > 7
				incl %esi
				ja wys_oct
					jmp zly_koniec#skacze do wyświetlania
					#informacji o błędnym znaku
skacz_oc:				#jak wcześniej, jeśli wszstkie znaki
					#poprwane to wypisz info
	 pushl $oct_len
  	 pushl $oct
	 call wyswietl
	 addl $8, %esp
	 
loop1_2:				#liczenie dlugosci lancucha
	movb zmienna(%esi), %al		#przeniesienie znaku na rejestr
	cmpb $10, %al			#czy koniec lini ?
		je dalej_o		#jesli tak to idz dalej
	xorl %edi, %edi			
	incl %esi			#jeśli nie zwiększamy esi ktory zawiera
					#ilość znaków
	jmp loop1_2

dalej_o:
	decl %esi
	movl $2, %edi			#pomijam 2 pierwsze znaki ktore 
					#określają jedynie typ liczby
	xorl %ecx, %ecx
	xorl %eax, %eax

z_oct_o:			
	shll $3, %ecx			#przesuwam bity (mnoże liczbe)
	movb zmienna(%edi), %al		#przerzucam znak

	subl $'0', %eax			#zamieniam znak ascii na wartość liczby

nastepna_o:
	AND $7, %eax 			#nałożenie maski dla każdego przypadku
	addl %eax, %ecx 		#sumowanie
	cmpl %esi, %edi 		
	incl %edi			#dopuki nie prekroczę dlugosci lancucha
	jbe z_oct_o

	# w %ecx mam wynik
	xorl %esi, %esi 		#tutaj będę przechowywał pozycję do 
					#wstawiania 0/1
	movl %ecx, %eax 		#liczba musi być na eax
	pushl %eax			#na stos

na_bin_o:
	movl $2, %ebx 			#dzielna musi być na ebx
	xorl %edx, %edx
	divl %ebx			
	movl %edx, %ecx			#w ecx przechowuje wynik
	addl $'0', %ecx			#zamieniam wartosc liczbowa na ascii
					#zeby mozna bylo wypisac
	movl %ecx, output(%esi)
	incl %esi

	cmpl $1, %eax			#jesli wynik = 1 nie dziele dalej
					#(wynika z algorytmu zamiany  systemow)
	jae na_bin_o			#zapetlaj

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output(%esi) 			#oznaczanie końca klinii
#koniec konwersji na BIN

#początek zamiany kolejności
xorl %esi, %esi

loop_o:					#liczenie długości
	movb output(%esi), %al
	cmpb $10, %al
	je zamien_o
	xorl %edi, %edi 	
	incl %esi
	jmp loop_o

zamien_o:
	# tutaj %esi ma wartość = długośctekstu
	movb output(%esi), %cl		
	xchgb %cl, output(%edi)		#zamienianie miejscami
	movb %cl, output(%esi)
	incl %edi
	decl %esi
	cmpl %esi, %edi			#dopuki rejestry się nie "spotkaja"
	jb zamien_o

pushl $binarna_len			#wyswietlanie info
pushl $binarna
call wyswietl
addl $8, %esp

pushl $1000				#wyswietlnaie liczby po konwersji
pushl $output
call wyswietl
addl $8, %esp

# wypisanie przejscia do nowej linii
pushl $ent_len
pushl $enter
call wyswietl
addl $8, %esp
#początek konwersji na HEx

xorl %esi, %esi

movl (%esp), %eax

na_hex_o2:
	movl $16, %ebx 			#dzielna musi być na ebx albo ecx 
					#poniewaz jest to system hexdec
	xorl %edx, %edx
	divl %ebx
	movl %edx, %ecx
	cmpl $9, %ecx			#przypadek gdy litera
		ja _literka
			addl $'0', %ecx
			jmp dodaj_do_wyniku
_literka:
	addl $'A', %ecx	
	subl $10, %ecx

dodaj_do_wyniku:
	movl %ecx, output_oct(%esi)
	incl %esi

	cmpl $1, %eax
	jae na_hex_o2

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output_oct(%esi) 		#oznaczanie końca klinii
#koniec konwersji na OCT

#początek zamiany kolejności
xorl %esi, %esi

loopo_o2:
	movb output_oct(%esi), %al
	cmpb $10, %al
	je zamieno_o2
	xorl %edi, %edi 		#zerowanie %edi zaraz przed przejściem						# do zamieniania
	incl %esi
	jmp loopo_o2

zamieno_o2:
	# tutaj %esi ma wartość = długośctekstu
	movb output_oct(%esi), %cl
	xchgb %cl, output_oct(%edi)
	movb %cl, output_oct(%esi)
	incl %edi
	decl %esi
	cmpl %esi, %edi
	jb zamieno_o2

pushl $hexadecimal_len
pushl $hexadecimal
call wyswietl
addl $8, %esp

pushl $1000
pushl $output_oct
call wyswietl
addl $8, %esp

# wypisanie przejscia do nowej linii
pushl $ent_len
pushl $enter
call wyswietl
addl $8, %esp


#zamiana na DEC (wypisywanie czyli DEC w ascii)

xorl %esi, %esi

popl %eax

na_dec2:
movl $10, %ebx 				#dzielna musi być na ebx albo ecx
xorl %edx, %edx
divl %ebx
movl %edx, %ecx
	addl $'0', %ecx

	movl %ecx, output_dec(%esi)
	incl %esi

cmpl $1, %eax
jae na_dec2

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output_dec(%esi) 		#oznaczanie końca klinii
#koniec konwersji na HEX

#początek zamiany kolejności
xorl %esi, %esi

loopd2:

movb output_dec(%esi), %al
cmpb $10, %al
je zamiend2
xorl %edi, %edi 			#zerowanie %edi zaraz przed przejściem
					# do zamieniania
incl %esi
jmp loopd2

zamiend2:

# tutaj %esi ma wartość = długośctekstu
movb output_dec(%esi), %cl
xchgb %cl, output_dec(%edi)
movb %cl, output_dec(%esi)
incl %edi
decl %esi
cmpl %esi, %edi
jb zamiend2


movl $4, %eax
movl $1, %ebx
movl $decimal, %ecx
movl $decimal_len, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
movl $output_dec, %ecx
movl $128, %edx
int $0x80

# wypisanie przejscia do nowej linii
movl $4, %eax
movl $1, %ebx
movl $enter, %ecx
movl $ent_len, %edx
int $0x80
#koniec wypisywanie DEC



   jmp wyjdz

wys_hex:				#wyswietlnie komunikatu hex
   pushl $hex_len
   pushl $hex
   call wyswietl
   addl $8, %esp

#pytanie o konwersje na male/duze   (należy do WYS_HEX)
	pushl $pytanie_len
  	pushl $pytanie
   	call wyswietl
   	addl $8, %esp

	movl $SYS_READ, %eax
	movl $STDIN, %ebx
	movl $wybor, %ecx
	movl $1, %edx
	
	int $PRZERWANIE
#komniec pytanie o konwersje
   xor %esi, %esi
   movb $'d', %al			#przeniesienie wartości z wyżej
					# zadeklarowanej stałej
   movb $'m', %cl
   cmpb wybor(%esi), %al
	je na_duze
   cmpb wybor(%esi), %cl
	je na_male
#konwersja na male	(należy do WYS_HEX)
	na_male:
	movl $1, %edi			#ponieważ opuszczamy dwa pierwsze znaki 					#które światczą tylko o typie liczby
	movb $'a', %cl			
	movb $'9', %ch	
	petla_na_male:			#petla zamienia na male litery 
		incl %edi
		cmpb zmienna(%edi), %cl
			ja zamien_m

			jmp petla_na_male

		zamien_m:
			cmpb zmienna(%edi), %ch
			   ja tut 
			movl zmienna(%edi), %ebx
			addl $32, %ebx
			movl %ebx, zmienna(%edi)
		tut:
		cmpl $ZNAK_LF, %edi		
			jb petla_na_male

	pushl $1000			#prezentacja wyniku
   	pushl $zmienna
   	call wyswietl
   	addl $8, %esp

	jmp konwertuj
#koniec na_male	
	
#zamiana na UPPERCASE	
    na_duze:	
	movb $'a', %cl			
	petla_na_duze:			#petla zamienia na 
		incl %edi
		cmpb zmienna(%edi), %cl
			jbe zamien_d
			jmp petla_na_duze	
			
		zamien_d:
			movl zmienna(%edi), %ebx
			subl $32, %ebx
			movl %ebx, zmienna(%edi)
		
		
		cmpl $ZNAK_LF, %edi		
		jb petla_na_duze
    prezentuj:
	pushl $1000			#prezentacja wyniku
   	pushl $zmienna
   	call wyswietl
   	addl $8, %esp

	jmp konwertuj
#koniec na duze

   					#przeskakujemy informacje, "bin",
					# tutaj kończy się "wys_hex"
wys_bin: 				#wyswietlnie komunikatu bin
cmpb zmienna(%esi), %dl			#szukanie końca łańcucha
		je skacz_bin
			cmpb zmienna(%esi), %dh#sprawdzanie czy tekst zawiera 
					#błędne znaki tj > 1 
				incl %esi
				ja wys_bin
					jmp zly_koniec
		
		skacz_bin:		
		
   wypisuj:
	 pushl $bin_len
	 pushl $bin
	 call wyswietl
	 addl $8, %esp

loop1d:
	movb zmienna(%esi), %al
	cmpb $10, %al
	je dalej_bd			#wszystko jak wyżej
	xorl %edi, %edi
	incl %esi
	jmp loop1d

dalej_bd:
	decl %esi
	movl $2, %edi
	xorl %ecx, %ecx
	xorl %eax, %eax

z_bin_od:
	shll $1, %ecx
	movb zmienna(%edi), %al
	
	subl $'0', %eax

nastepna_od:
	AND $1, %eax 			#nałożenie maski dla każdego przypadku
	addl %eax, %ecx 		#sumowanie
	cmpl %esi, %edi 
	incl %edi	
	jbe z_bin_od
	
	# w %ecx mam wynik
	xorl %esi, %esi 		#tutaj będę przechowywał pozycję 
					#do wstawiania 0/1
	movl %ecx, %eax 		#liczba musi być na eax
	pushl %eax

na_oct_od:
	movl $8, %ebx 			#dzielna musi być na ebx
	xorl %edx, %edx
	divl %ebx
	movl %edx, %ecx
	addl $'0', %ecx
	movl %ecx, output(%esi)
	incl %esi

	cmpl $1, %eax
	jae na_oct_od

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output(%esi) 			#oznaczanie końca klinii
#koniec konwersji na BIN

#początek zamiany kolejności
xorl %esi, %esi

loop_od:
	movb output(%esi), %al
	cmpb $10, %al
	je zamien_od
	xorl %edi, %edi 		#zerowanie %edi zaraz przed przejściem 
					#do zamieniania
	incl %esi
	jmp loop_od
zamien_od:
	# tutaj %esi ma wartość = długośctekstu
	movb output(%esi), %cl
	xchgb %cl, output(%edi)
	movb %cl, output(%esi)
	incl %edi
	decl %esi
	cmpl %esi, %edi
	jb zamien_od


pushl $octal_len
pushl $octal
call wyswietl
addl $8, %esp

pushl $1000
pushl $output
call wyswietl
addl $8, %esp

# wypisanie przejscia do nowej linii
pushl $ent_len
pushl $enter
call wyswietl
addl $8, %esp
#początek konwersji na HEx

xorl %esi, %esi

movl (%esp), %eax

na_hex_o2d:
	movl $16, %ebx 			#dzielna musi być na ebx albo ecx
	xorl %edx, %edx
	divl %ebx
	movl %edx, %ecx
	cmpl $9, %ecx
		ja _literkas
			addl $'0', %ecx
			jmp dodaj_do_wynikus
_literkas:
	addl $'A', %ecx	
	subl $10, %ecx

dodaj_do_wynikus:
	movl %ecx, output_oct(%esi)
	incl %esi

	cmpl $1, %eax
	jae na_hex_o2d

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output_oct(%esi) 		#oznaczanie końca klinii
#koniec konwersji na OCT

#początek zamiany kolejności
xorl %esi, %esi

loopo_o2ds:
	movb output_oct(%esi), %al
	cmpb $10, %al
	je zamieno_o2ds
	xorl %edi, %edi 		#zerowanie %edi zaraz przed przejściem 
					#do zamieniania
	incl %esi
	jmp loopo_o2ds

zamieno_o2ds:
	# tutaj %esi ma wartość = długośctekstu
	movb output_oct(%esi), %cl
	xchgb %cl, output_oct(%edi)
	movb %cl, output_oct(%esi)
	incl %edi
	decl %esi
	cmpl %esi, %edi
	jb zamieno_o2ds

pushl $hexadecimal_len
pushl $hexadecimal
call wyswietl
addl $8, %esp

pushl $1000
pushl $output_oct
call wyswietl
addl $8, %esp

# wypisanie przejscia do nowej linii
pushl $ent_len
pushl $enter
call wyswietl
addl $8, %esp


#zamiana na DEC (wypisywanie czyli DEC w ascii)

xorl %esi, %esi

popl %eax

na_dec2d:
movl $10, %ebx 				#dzielna musi być na ebx albo ecx
xorl %edx, %edx
divl %ebx
movl %edx, %ecx
	addl $'0', %ecx

	movl %ecx, output_dec(%esi)
	incl %esi

cmpl $1, %eax
jae na_dec2d

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output_dec(%esi) 		#oznaczanie końca klinii
#koniec konwersji na HEX

#początek zamiany kolejności
xorl %esi, %esi

loopd2ds:

movb output_dec(%esi), %al
cmpb $10, %al
je zamiend2d
xorl %edi, %edi 			#zerowanie %edi zaraz przed przejściem 
					#do zamieniania
incl %esi
jmp loopd2ds

zamiend2d:

# tutaj %esi ma wartość = długośctekstu
movb output_dec(%esi), %cl
xchgb %cl, output_dec(%edi)
movb %cl, output_dec(%esi)
incl %edi
decl %esi
cmpl %esi, %edi
jb zamiend2d


pushl $decimal_len
pushl $decimal
call wyswietl
addl $8, %esp

pushl $1000
pushl $output_dec
call wyswietl
addl $8, %esp


# wypisanie przejscia do nowej linii
pushl $ent_len
pushl $enter
call wyswietl
addl $8, %esp
#koniec wypisywanie DEC

   jmp wyjdz
konwertuj:
#w tym momencie zaczyna się konwersja najpierw na BIN następnie na OCT
loop1:
	movb zmienna(%esi), %al
	cmpb $10, %al
	je dalej
	xorl %edi, %edi
	incl %esi
	jmp loop1

dalej:
	decl %esi
	movl $2, %edi
	xorl %ecx, %ecx
	xorl %eax, %eax

z_hex_:
	shll $4, %ecx
	movb zmienna(%edi), %al
	cmpb $'9', %al
	jbe _op_cyfry
	cmpb $'A', %al
	jae _spr_min_F

_spr_min_F:
	cmpb $'F', %al
	jb _op_duze
	cmpb $'a', %al
	ja _op_male

_op_duze:
	subb $'A', %al
	addb $10, %al
	jmp nastepna
	
_op_male:
	subl $'a', %eax
	addl $10, %eax
	jmp nastepna

_op_cyfry:
	subl $'0', %eax

nastepna:
	AND $0x0F, %eax 		#nałożenie maski dla każdego przypadku
	addl %eax, %ecx 		#sumowanie
	cmpl %esi, %edi
	incl %edi	
	jbe z_hex_

	# w %ecx mam wynik
	xorl %esi, %esi			#tutaj będę przechowywał pozycję do 
					#wstawiania 0/1
	movl %ecx, %eax 		#liczba musi być na eax
	pushl %eax

na_bin:
	movl $2, %ebx 			#dzielna musi być na ebx
	xorl %edx, %edx
	divl %ebx
	movl %edx, %ecx
	addl $'0', %ecx
	movl %ecx, output(%esi)
	incl %esi

	cmpl $1, %eax
	jae na_bin

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output(%esi) 			#oznaczanie końca klinii
#koniec konwersji na BIN

#początek zamiany kolejności
xorl %esi, %esi

loop:
	movb output(%esi), %al
	cmpb $10, %al
	je zamien
	xorl %edi, %edi 		#zerowanie %edi zaraz przed przejściem 
					#do zamieniania
	incl %esi
	jmp loop

zamien:
	# tutaj %esi ma wartość = długośctekstu
	movb output(%esi), %cl
	xchgb %cl, output(%edi)
	movb %cl, output(%esi)
	incl %edi
	decl %esi
	cmpl %esi, %edi
	jb zamien


pushl $binarna_len
pushl $binarna
call wyswietl
addl $8, %esp

pushl $1000
pushl $output
call wyswietl
addl $8, %esp

# wypisanie przejscia do nowej linii
pushl $ent_len
pushl $enter
call wyswietl
addl $8, %esp
#początek konwersji na OCT

xorl %esi, %esi

movl (%esp), %eax

na_oct:
	movl $8, %ebx 			#dzielna musi być na ebx albo ecx
	xorl %edx, %edx
	divl %ebx
	movl %edx, %ecx
	addl $'0', %ecx
	movl %ecx, output_oct(%esi)
	incl %esi

	cmpl $1, %eax
	jae na_oct

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output_oct(%esi) 		#oznaczanie końca klinii
#koniec konwersji na OCT

#początek zamiany kolejności
xorl %esi, %esi

loopo:
	movb output_oct(%esi), %al
	cmpb $10, %al
	je zamieno
	xorl %edi, %edi 		#zerowanie %edi zaraz przed przejściem 
					#do zamieniania
	incl %esi
	jmp loopo

zamieno:
	# tutaj %esi ma wartość = długośctekstu
	movb output_oct(%esi), %cl
	xchgb %cl, output_oct(%edi)
	movb %cl, output_oct(%esi)
	incl %edi
	decl %esi
	cmpl %esi, %edi
	jb zamieno

pushl $octal_len
pushl $octal
call wyswietl
addl $8, %esp

pushl $1000
pushl $output_oct
call wyswietl
addl $8, %esp

# wypisanie przejscia do nowej linii
pushl $ent_len
pushl $enter
call wyswietl
addl $8, %esp
#zamiana na DEC (wypisywanie czyli DEC w ascii)

xorl %esi, %esi

popl %eax

na_dec:
movl $10, %ebx #dzielna musi być na ebx albo ecx
xorl %edx, %edx
divl %ebx
movl %edx, %ecx
	addl $'0', %ecx

	movl %ecx, output_dec(%esi)
	incl %esi

cmpl $1, %eax
jae na_dec

movb $10 , %al 				#oznaczanie końca klinii
movb %al, output_dec(%esi) 		#oznaczanie końca klinii
#koniec konwersji na HEX

#początek zamiany kolejności
xorl %esi, %esi

loopd:

movb output_dec(%esi), %al
cmpb $10, %al
je zamiend
xorl %edi, %edi 			#zerowanie %edi zaraz przed przejściem 
					#do zamieniania
incl %esi
jmp loopd

zamiend:

# tutaj %esi ma wartość = długośctekstu
movb output_dec(%esi), %cl
xchgb %cl, output_dec(%edi)
movb %cl, output_dec(%esi)
incl %edi
decl %esi
cmpl %esi, %edi
jb zamiend


movl $4, %eax
movl $1, %ebx
movl $decimal, %ecx
movl $decimal_len, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
movl $output_dec, %ecx
movl $128, %edx
int $0x80

# wypisanie przejscia do nowej linii
movl $4, %eax
movl $1, %ebx
movl $enter, %ecx
movl $ent_len, %edx
int $0x80
#koniec wypisywanie DEC

#koniec komunikatu NA_HEX	

wyjdz:						#oddanie władzy do systemu (
						#ostateczne), albo w sposób 							#"naturalny" albo przez skok
	movl $SYS_EXIT, %eax
	int $PRZERWANIE

#funcja wyswietlajaca tekst, na podstawie podanych 2 parametrów, które funkcja 
#pobiera ze stosu	
.type wyswietl,@function
wyswietl:
	movl $SYS_WRITE, %eax
	movl $STDOUT,  %ebx
	movl 4(%esp), %ecx
	movl 8(%esp), %edx
	int $PRZERWANIE
ret
#koniec funckji, poraz programu

