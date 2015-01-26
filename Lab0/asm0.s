.align 32

SYSEXIT= 1
SYSEXIT_SUCCESS= 0
STD_OUT= 1
SYSWRITE= 4
SYSREAD= 3
STD_IN= 0
PRZERWANIE= 0X80

.text
.global _start
_start:
#wypisywanie "zachety"
	movl $SYSWRITE, %eax
	movl $STD_OUT, %ebx
	movl $hello, %ecx
	movl $hello_len, %edx

	int $PRZERWANIE
#wczytywanie danych
	movl $SYSREAD, %eax
	movl $STD_IN, %ebx
	movl $buffor, %ecx
	movl $15, %edx

	int $PRZERWANIE
#wypisywanie tekstu
	movl $SYSWRITE, %eax
	movl $STD_OUT, %ebx
	movl $napis, %ecx
	movl $napis_len, %edx

	int $PRZERWANIE
#wypisywanie podanego wczesniej imienia
	movl $SYSWRITE, %eax
	movl $STD_OUT, %ebx
	movl $buffor, %ecx
	movl $15, %edx
	
	int $0x80
#zakonczenie programu, oddanie (ostatecznie) wladzy systemowi
	movl $SYSEXIT,  %eax
	movl $SYSEXIT_SUCCESS, %ebx
	int $0x80
		

.data

.lcomm buffor, 15	#rezerwacja 15 bajtow na dane

napis: .ascii "Twoje imie to: "
napis_len = .- napis

hello: .ascii "Podaj imie: \n"
hello_len = .- hello
