.data
#przekazane z C:
#w ecx mam adres tablicy z pierwszą liczbą 
#w edx mam adres tablicy liczba_2
#w edi, adres pamieci gdzie bede przechowywal NWD	
	
#dzieki .space  nie zapisuja się zera wiec łatwiej jest zamienić na liczbe przeciwną
liczba_: .space 100, 0
dlugosc_liczba_: .long 0

liczba2_: .space 100, 0
dlugosc_liczba2_: .long 0
	
wynik: .space 101, 0
	
liczba_przeciwna: 	.space 100, 0
liczba0: 		.space 100, 0
dzielnik:		.space 100, 0  #miejsce na dzielnik

jedna: 	.space 99, 0
.byte 1
	
.lcomm liczba_tab, 10			#10 B na tablice pomocnicza
.lcomm liczba_2_tab, 10
	
.text
.globl gcd
.type gcd, @function
gcd:

pushq %rbp
movq %rsp, %rbp	

movl $liczba_, %eax
call czysc_tab				#dla pewnosci że jest pusta

movl $liczba2_, %eax
call czysc_tab

movl $wynik, %eax
call czysc_tab


movl $liczba_1, %eax
movl (liczba_1_len), %ebx
movl $liczba_2, %ecx
movl (liczba_2_len), %edx

movl %ebx, (dlugosc_liczba_)
movl %edx, (dlugosc_liczba2_)

	pushq %rcx
#konwersja liczby pierwszej
movl $liczba_, %ecx
movl (dlugosc_liczba_), %esi


decl %esi				#zmniejszamy bo zaczynamy od max wartości
movl $99, %edi				#zaczynamy od najmłodszego bajtu
	
na_dec:

cmpl $0, %esi
jl dalej
movb (%eax, %esi, 1), %bl
cmpb $'9', %bl	
jg litera 				#znak jest literą
andb $0xF, %bl  			#odcięcie kodu ascii
jmp zapis2
	
litera:
andb $0xF, %bl
addb $0x9, %bl  			#konwersja na litere
	
zapis2:
movb %bl, (%ecx, %edi, 1)		#zapisujemy przekonwertowane 4 pierwsze bity do tablicy na liczbe
decl %esi
	
#pobranie drugiego znaku, uzupelniam bajt drugim nibble bajtu liczby liczba_
cmp $0,%esi
jl dalej
movb (%eax, %esi, 1), %bl
cmpb $'9', %bl
jg zapis3
subb $'0', %bl
jmp zapis4

zapis3:
andb $0xF, %bl
addb $0x9, %bl  			#konwersja na litere
	
zapis4:
shlb $4,%bl 				#przesuwam do starszej części (mnoże razy bazę)
orb %bl, (%ecx,%edi,1)			#suma logiczna
decl %esi  
decl %edi 
jmp na_dec
	
dalej:

popq %rcx
#konwersja 2 liczby
movl %ecx, %eax			
movl $liczba2_, %ecx
movl (dlugosc_liczba2_), %esi

decl %esi		
movl $99, %edi	
	
na_dec_a:
cmpl $0, %esi
jl dalej2
movb (%eax, %esi, 1), %bl
cmpb $'9', %bl	
jg litera_a
andb $0xF, %bl  			#odcięcie kodu ascii
jmp zapis2_a
	
litera_a:
andb $0xF, %bl
addb $0x9, %bl  			#konwersja na litere
	
zapis2_a:
movb %bl, (%ecx, %edi, 1)
decl %esi
	
#pobranie drugiego znaku w celu uzupe³nienie ca³ego pierwszego bajtu liczby liczba_
cmp $0,%esi
jl dalej2
movb (%eax, %esi, 1), %bl
cmpb $'9', %bl
jg zapis3_a
subb $'0', %bl
jmp zapis4_a

zapis3_a:
andb $0xF, %bl
addb $0x9, %bl  			#konwersja na litere
	
zapis4_a:
shlb $4,%bl  				#przesuwam do starszej części (mnoże razy bazę)
orb %bl, (%ecx,%edi,1)			#dodajemy logicznie 4 starsze bity do aktualnie 
					#kodowanego bajta w tablicy liczby	
decl %esi  
decl %edi 
jmp na_dec_a
	
dalej2:
#przerzucam podawane jako parametry wartości
movl $liczba_, %ecx
movl $liczba2_, %edx
movl $wynik, %edi

popq %rbp

gcd_faza_pierwsza:
pushq %rbp
	
#liczba 2 > dzielnik
movl $dzielnik, %eax   	
movl %edx, %ebx
call kopiuj_tab				#dzielnik = liczba2_ = druga liczba

gcd_faza_2:
movl %edi, %eax
call czysc_tab
	
call minus				#wynik = liczba1 - liczba2
jc gcd1					#jeśli B > A to CF = 1	

movl %edi, %eax
movl $liczba0, %ebx
call cmp_tab				#spr czy liczba A > B
je gdc_znalezione			#jeśli równe nie wykonujemy dalszej czesci algorytmu

#w przeciwnym wypadku	
movl %edi, %eax
call czysc_tab
	
#jelsi liczba1 > liczb2 to:
movl $dzielnik, %eax
#dzielnik = 2*dzielnik
pushq %rax
pushq %rsi
#należy wyzerować flagę przeniesienia
clc
movl $99, %esi 

pushf
mul2_tab0:
cmpl $0,%esi    
jl mul2_tab_dalej 
popf
rclb $1, (%eax, %esi, 1)
pushf
decl %esi
jmp mul2_tab0
mul2_tab_dalej:
popf
popq %rsi
popq %rax
#koniec mnożenia

#odejmowanie żeby sprawdzić czy liczba liczba1 > 2*liczba_pom
pushq %rdx
movl $dzielnik, %edx		
call minus				#wynik = A - dzielnik
popq %rdx				#przywracamy do %edx adres liczba2_ = B
#if dzielnik > A to CF = 1
jc gcd2
#sprawdzamy czy wynik == 0, je¿eli tak to znaczy że liczba liczba_pom jest wielokrotnością liczby liczba1 -> GCD = liczba2
movl %edi, %eax
movl $liczba0, %ebx
call cmp_tab
je gcd2					#jeżeli są równe to mamy wynik GCD 

jmp gcd_faza_2
	
gcd1:
#przypadek gdy B > A xchg dzielnik = liczba1
movl $dzielnik, %eax
movl %ecx, %ebx
call kopiuj_tab   			#dzielnik = liczba1
# B -> A
movl %ecx, %eax
movl %edx, %ebx
call kopiuj_tab   			#A = B
#dzielnik -> B
movl %edx, %eax
movl $dzielnik, %ebx
call kopiuj_tab  			#B = dzielnik = A
jmp gcd_faza_2
	
gcd2:
#gdy 2*dzielnik > A, dzielimy dzielnik /= 2
movl $dzielnik, %eax
#dzielnik = dzielnik/2
#funkcja przesuwa o 1 bit liczbê w prawo
#w eax mam adres do tablicy, która nalezy wyzerowac
pushq %rax				#kopia 	
pushq %rsi
clc  					#należy wyzerować flagę przeniesienia
movl $0, %esi 

pushf					#zapisuje flagi na stosie
dzielenie_tab:
cmpl $99, %esi    
jg dzieleni_dalej 
popf
rcrb $1, (%eax, %esi, 1)		#rotacja z flagą
pushf
incl %esi
jmp dzielenie_tab

dzieleni_dalej:
popf
popq %rsi
popq %rax
	
# A -= dzielnik
pushq %rdx
movl $dzielnik, %edx
call minus				#wynik = A - dzielnik
popq %rdx
	
#wynik l¹duje w (wynik -> A)
movl %ecx, %eax
movl %edi, %ebx
call kopiuj_tab   			#A = wynik
	
# B < A, przekopiowujemy B -> dzielnik
movl $dzielnik, %eax
movl %edx, %ebx
call kopiuj_tab   			#dzielnik = B
jmp gcd_faza_2
	
gdc_znalezione:
#gcd znajduje siê w liczbie A wiec przekopiowujemy ja do wyniku pod adresem edi
movl %edi, %eax
movl %ecx, %ebx
call kopiuj_tab
movl %edi, %eax  			#zwracamy adres do miejsca w pamięci 
			 		#gdzie zapisany jest wynik, N W D
popq %rbp
ret
	
minus:	
movl $wynik, %eax			#przeniesienie adresu wyniku do eax - u³atwienie do odejmowania
call czysc_tab				#zerujemy tablice przeciwn¹ bo tam bêdzie wynik tej operacji

movl $99, %esi 
clc

minus0:
pushfq
cmpl $0, %esi
jl minus_ret 
	
popfq
movb (%ecx, %esi, 1), %al
sbbb (%edx, %esi, 1), %al  		 #al = (al-C) - liczba2_   sbb - odejmowanie z zapo¿yczeniem 
movb %al, (%edi, %esi, 1)
decl %esi
jmp  minus0

minus_ret:
popfq
ret	
	
#eax - adres tablicy któr¹ chcemy odwróciæ
przeciwne:
#odwracamy po 4 bajty wiec potrzebujemy iteratora na 24
movl $24, %esi 
	
przeciwne0:
cmpl $0, %esi    
jl przeciwne_ret 
notl (%eax, %esi, 4) 			 #negowanie bitów
decl %esi
jmp przeciwne0

przeciwne_ret:
#aby by³a liczba liczba_przeciwna trzeba zanegowaæ wszystkie bity i dodaæ 1
	
movl %eax, %ecx
movl $liczba_przeciwna, %eax
call czysc_tab				#zerujemy tablice przeciwn¹ bo tam bêdzie wynik tej operacji
	
movl $jedna, %edx
movl $liczba_przeciwna, %edi
ret

#funkcja zeruj¹ca tablice jest specjalnie stworzona do zerowania śmieci powstaj¹cych przy dzia³aniach na tablicach
#eax adres do tablicy która musi byæ wyzerowana
czysc_tab:
pushq %rax
pushq %rsi

movl $24, %esi 

czysc_tab0:
cmpl $0, %esi    
jl czysc_tab_zwracana 
movl $0, (%eax, %esi, 4)
decl %esi
jmp czysc_tab0

czysc_tab_zwracana:
popq %rsi
popq %rax
ret

kopiuj_tab:	
pushq %rax
pushq %rbx
pushq %rdx
pushq %rsi

movl $24, %esi 

kopiuj_tab0:
cmpl $0, %esi    
jl kopiuj_tab_ret 
movl (%ebx, %esi, 4), %edx
movl %edx, (%eax, %esi, 4)
decl %esi
jmp kopiuj_tab0
	
kopiuj_tab_ret:
popq %rsi
popq %rdx
popq %rbx
popq %rax
ret
	
cmp_tab:
pushq %rax
pushq %rbx
pushq %rdx
pushq %rsi

movl $24,%esi 

cmp_tab0:
pushfq					 #wrzucenie na stos rejestru flag bo cmp zmienia flagi
cmpl $0, %esi
jl cmp_tab_ret
popfq
movl (%ebx, %esi, 4), %edx
cmpl %edx, (%eax, %esi, 4)
pushfq 					#wrzucenie na stos gdy¿ dec zmienia flagi
jne cmp_tab_ret
decl %esi
popfq
jmp cmp_tab0
	
cmp_tab_ret:
popfq
	
popq %rsi
popq %rdx
popq %rbx
popq %rax
ret	
	
