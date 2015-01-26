#wykrywanie czy nie ma spacji albo nie porządanych znaków
#litery można wpisywać różenj wielkości ale mamy zamienić wszyskito na jedną
#wielkość

#		//kolejne etapy
#wczytywanie ze STD IN (może być to plik)
#(!!!!!!!sprawdź co jeśłi nie poda się ządnego pliku do wczytania a z w programie spróbuje wczytać jego zawartość)
#wpisywanie co robi kod ( informowanie usera)
#sprawdzanie (chyba czy nie ma nieporządanych znaków)
#podać wartość w dec podanej liczby

#buffor .lcomm zmienna, 1000
#wczytywanie liczby z std   (systemowe READ)
#w 1 petli spr czy liczba jest poprawna
#w 2 petli wyrownanie liter do UPPercase v LowerCase
#obliczenie wartości dziesiętnej

#najpierw jedna konwersja (żeby sprawdzić czy to mi wyjdzie)
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

	zly_znak: .ascii "Ten tekst zawiera nieprawidłowy znak/znaki, spróbuj jeszcze raz:\n"
	zly_znak_len = .- zly_znak	

.bss
	.lcomm zmienna, 500			#zmienna przechowuje podane dane (buffor)
	.lcomm wybor, 1			#buffor na wybor user' a

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
#powitanie
pushl $witaj_len				#w odwrotnej kolejności relatywnie do kolejności rejestrów, bo rzucam na stos
pushl $witaj
call wyswietl
addl $8, %esp					#oba "stringi" mają po 4 B
#koniec powitania

#wczytanie danych
wczytywanie:
	movl $SYS_READ, %eax
	movl $STDIN, %ebx
	movl $zmienna, %ecx
	movl $500, %edx
	int $PRZERWANIE
#koniec wczytywania

#sprawdzanie poprawności podanych znaków mogą to być znak E <0, 9> u <A, F> u <a, f>
movb $'a', %ah
movb $'f', %al
movb $'0', %bh
movb $'9', %bl
movb $'A', %ch
movb $'F', %cl
movb $'x', %dh
movb $10, %dl					#kod końca linii w UNIX/LINUX, "Line Feed"

xorl %edi, %edi

	petla_spr:				
		cmpb zmienna(%edi), %dl	#jeśli znak końca lini to idź do etykiety, wykonującej dalsze części programu
			je spr_typ

		cmpb zmienna(%edi), %bh	#jesli znak < '0' to na pewno podano zły znak
			ja zly_koniec	

		cmpb zmienna(%edi), %bl	#jesli znak > '9' jest szansa, że znak mieści się w innym przedziale
			jb zly			#skok do dalszego sprawdzania
dobry:						#skok do etykiety gdy wszysko jest ok i można przejść do nastepnego znaku
		incl %edi			
		jmp petla_spr			#zapętlaj (warunek wyjścia z pętli znajduje się wyżej)

zly:						#sprawdzenie 2-ego przedziału
		cmpb zmienna(%edi), %ch	#jeżeli znak < 'A' to wiemy już że na pewno lezy w nie poprawnym przedziale
			ja zly_koniec		#wczytujemy ponownie
		cmpb zmienna(%edi), %cl	#jeżeli znak > 'F' to jest on zły ale nadal ma szansę znaleźć się w poprawnym przedziale <a, f>
			jb zly_nadal
			jmp dobry		#jeśli jest ok: skocz

zly_nadal:					#sprawdzenie 3-ego przedziału
		cmpb zmienna(%edi), %ah	#jeśli znak < 'a', wiemy już że musi być zły bo nie mieścił się poprzednich przedziałach
			ja zly_koniec
		cmpb zmienna(%edi), %dh	#jeśli znak < 'a', wiemy już że musi być zły bo nie mieścił się poprzednich przedziałach
			je dobry
		cmpb zmienna(%edi), %al	#jeśli znak < 'f' to jest ok
			jae dobry
zly_koniec:			
		pushl $zly_znak_len
  		pushl $zly_znak
   		call wyswietl
   		addl $8, %esp

		jmp wczytywanie			#skok do dalszego wczytywania danych, aż będą one poprawne
#koniec: sprawdzanie poprawności podanych znaków mogą to być znak E <0, 9> u <A, F> u <a, f>

spr_typ:
#sprawdzanie typu liczby
xorl %edi, %edi				#zerowanie edi

#blok szukanych wartości
movb $'0', %ah
movb $'x', %bh
movb $'b', %ch
#koniec bloku szukanych wartości

cmpb zmienna(%edi), %ah			#sprawdzam czy pierwszy znak podanego ciągu to '0', (numer znaku '0' jest w ah - 1 B rejestrze)
	je spr_dalej				#jeżeli mamy '0' to sprawszamy dalej

	jmp wys_dec				#jeżeli znak jest inny, dalsza detekcja nie ma sensu, informuje że podana liczba jest typu dec

		spr_dalej:			
			movl $1, %edi		#teraz interesuje nas 2 znak
			cmpb zmienna(%edi), %bh
				je wys_hex	#jeżeli jest = 'x' to skaczemy do etykiety gdzie wyświetlamy adekwatną informację
			cmpb zmienna(%edi), %ch
				je wys_bin	#jeżeli jest = 'b' to skaczemy do etykiety gdzie wyświetlamy adekwatną informację
wys_dec:					#jeżeli 2 znak nie jest jednym spośród szukanych to liczba jest dec
	pushl $dec_len
  	pushl $dec
   	call wyswietl
   	addl $8, %esp
        jmp wyjdz
			
#koniec sprawdzania typu

wys_hex:					#wyswietlnie komunikatu hex
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
   movb $DUZE, %al				#przeniesienie wartości z wyżej zadeklarowanej stałej
   movb $MALE, %cl
   cmpb wybor(%esi), %al
	je na_duze
   cmpb wybor(%esi), %cl
	je na_male
#konwersja na male	(należy do WYS_HEX)
	na_male:
	movl $1, %edi				#ponieważ opuszczamy dwa pierwsze znaki które światczą tylko o typie liczby
	movb $'a', %cl				
	petla_na_male:				#petla zamienia na 
		incl %edi
		cmpb zmienna(%edi), %cl
			ja zamien

			jmp petla_na_male

		zamien:
			movl zmienna(%edi), %ebx
			addl $32, %ebx
			movl %ebx, zmienna(%edi)
		cmpl $ZNAK_LF, %edi		
			jb petla_na_male

	pushl $500				#prezentacja wyniku
   	pushl $zmienna
   	call wyswietl
   	addl $8, %esp

	jmp wyjdz
#koniec na_male	
	
#zamiana an UPPERCASE	
    na_duze:	
	movb $'a', %cl				
	petla_na_duze:				#petla zamienia na 
		incl %edi
		cmpb zmienna(%edi), %cl
			jbe zamien_d
			jmp prezentuj
			
		zamien_d:
			movl zmienna(%edi), %ebx
			subl $32, %ebx
			movl %ebx, zmienna(%edi)
		
		
		cmpl $ZNAK_LF, %edi		
		jb petla_na_duze
    prezentuj:
	pushl $500				#prezentacja wyniku
   	pushl $zmienna
   	call wyswietl
   	addl $8, %esp

	jmp wyjdz
#koniec na duze

   					#przeskakujemy informacje, "bin", tutaj kończy się "wys_hex"
wys_bin: 					#wyswietlnie komunikatu bin
   pushl $bin_len
   pushl $bin
   call wyswietl
   addl $8, %esp

   





























#koniec komunikatu NA_HEX	

wyjdz:						#oddanie władzy do systemu (ostateczne), albo w sposób "naturalny" albo przez skok
movl $SYS_EXIT, %eax
int $PRZERWANIE

#funcja wyswietlajaca tekst, na podstawie podanych 2 parametrów, które funkcja pobiera ze stosu	
.type wyswietl,@function
wyswietl:
	movl $SYS_WRITE, %eax
	movl $STDOUT,  %ebx
	movl 4(%esp), %ecx
	movl 8(%esp), %edx
	int $PRZERWANIE
ret
#koniec funckji

