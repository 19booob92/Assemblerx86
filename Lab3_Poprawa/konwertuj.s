.text

.global na_bin
.type na_bin, @function
na_bin:
movl 4(%esp), %ecx	#przekazanie wskaxnika na "dane"

movl 8(%esp), %ebx	#wskzanik na "buff":
xorl %edi, %edi		#zmienna k, zerowanie
pushl %ecx		#kopia zapasowa ecx

#petla while

petla_while:
movb (%ecx), %al	#przeniesienie znaku z pod adresu
cmpb $0, %al		#sprawdzam czy to nie koniec linii //albo $10
je idz_do_for		#jesli zero to koniec konwersji
#zakladam ze znak jest poprawny

cmpb $'0', %al
jb koniec_z_bledem	#bledny znak

cmpb $'9', %al		#jesli to cyfra...
jbe liczba		#...skacz do konwersji 


cmpb $'A', %al
jb koniec_z_bledem

cmpb $'Z', %al
jbe duza_lit


cmpb $'a', %al		
jb koniec_z_bledem

cmpb $'z', %al
jbe mala_lit
jmp koniec_z_bledem

duza_lit:
	subb $'A', %al
	addb $10, %al
	movb %al, (%ecx)
	jmp nastepny_znak

mala_lit:
	subb $'a', %al
	addb $10, %al
	movb %al, (%ecx)
	jmp nastepny_znak

liczba:
	subb $'0', %al	#zamiana na wartosc liczbowa
	movb %al, (%ecx)#wrzucam do tablicy wartosc liczbowa znaku
	jmp nastepny_znak

nastepny_znak:
incl %ecx		#kolejny element tablicy
incl %edi		#zwiekszam licznik znakow
jmp petla_while
#koniec petli while
idz_do_for:

popl %ecx		#mam pierwotny ecx
pushl %edi		#k = %edi
petla_for_jeden:	#petla rpzechodzi po znakach
decl %edi		#zmniejszaj przy kazdym obiegu petli

	movl $4, %esi	#4 bity wiec petla ma 4 iteracje na znak esi - p
	petla_for_dwa:		
	decl %esi

		movb (%edi, %ecx, 1), %al	
		
		xorl %edx, %edx
	pushl %ebx
		movl $2, %ebx
		divl %ebx
	popl %ebx
		
		movl %edi, %eax
		imull $4, %eax		#i * 4
		addl %esi, %eax		#p + ()

		movb %dl, (%eax ,%ebx, 1)	#przenoszenie reszty
#dzielenie liczby
		movb (%edi, %ecx, 1), %al
		xorl %edx, %edx
	pushl %ebx
		movl $2, %ebx
		divl %ebx
		movb %al, (%edi,%ecx, 1)
	popl %ebx
#koniec petli wewnetrznej

		cmpl $0, %esi	#esi = p
		ja petla_for_dwa

cmpl $0, %edi			#jesli edi >= 0

ja petla_for_jeden
popl %eax			#sciagam ze stosu kopie licznika
koniec_z_bledem:
ret
