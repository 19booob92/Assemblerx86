.text

.global na_bin
.type na_bin, @function
na_bin:
movl 4(%esp), %ecx	#przekazanie wskaxnika na "dane"

movl 8(%esp), %ebx	#wskzanik na "buff"

xorl %edi, %edi		#zmienna k, zerowanie
pushl %ecx		#kopia zapasowa ecx

#petla while

petla_while:
movb (%ecx), %eax	#przeniesienie znaku z pod adresu
cmpb $0, %eax		#sprawdzam czy to nie koniec linii //albo $10
je idz_do_for		#jesli zero to koniec konwersji
#zakladam ze znak jest poprawny

cmpb $'0', %eax
jb koniec_z_bledem	#bledny znak

cmpb $'9', %eax		#jesli to cyfra...
jbe liczba		#...skacz do konwersji 


cmpb $'A', %eax
jb koniec_z_bledem

cmpb $'Z', %eax
jbe duza_lit


cmpb $'a', %eax		
jb koniec_z_bledem

cmpb $'z', %eax
jbe mala_lit
jmp koniec_z_bledem

duza_lit:
	subl $'A', %eax
	addl $10, %eax
	movb %eax, (%ecx)
	jmp nastepny_znak

mala_lit:
	subl $'a', %eax
	addl $10, %eax
	movb %eax, (%ecx)
	jmp nastepny_znak

liczba:
	subl $'0', %eax	#zamiana na wartosc liczbowa
	movb %eax, (%ecx)#wrzucam do tablicy wartosc liczbowa znaku
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

		movb (%edi, %ecx, 1), %eax
		
		xorl %edx, %edx
	pushl %ebx
		movl $2, %ebx
		divl %ebx
	popl %ebx
		
		movl %edi, %eax
		imull $4, %eax		#i * 4
		addl %esi, %eax		#p + ()

		movb %edx, (%eax ,%ebx, 1)	#przenoszenie reszty
#dzielenie liczby
		movb (%edi, %ecx, 1), %eax
		xorl %edx, %edx
	pushl %ebx
		movl $2, %ebx
		divl %ebx
		movb %eax, (%edi,%ecx, 1)
	popl %ebx
#koniec petli wewnetrznej

		cmpl $0, %esi	#esi = p
		ja petla_for_dwa

cmpl $0, %edi			#jesli edi >= 0

ja petla_for_jeden
popl %eax			#sciagam ze stosu kopie licznika
koniec_z_bledem:
ret
