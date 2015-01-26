.text

.global dodawanie
.type dodawanie, @function
#dane wejsciowe
dodawanie:
xorb %bh, %bh		#bh - carry

cmpl %eax, %edx
#pierwszy waruenk
jb dl1_wieksze
	movl %edx, %esi	#ebx zmienna pomocnicza-mam tam dl2
	incl %esi
	pushl %esi	#kopia dla ret'a
	movl %edx, %edi
	subl %eax, %edi #r√znica ABS
        
	
	jmp petla_for

dl1_wieksze:
	movl %eax, %esi
	incl %esi	#esi to moje a
	pushl %esi	#zapisuje zeby ret
	movl %eax, %edi #uzyskiwanie ABSa
	subl %edx, %edi
#konicec pirwszego if'a

petla_for:		#iterator jest ustawiony
	cmpl %eax, %edx #znowu poruwnuje
	jb suma_dl2_wieksze#jesli edx wiekszy to

#jesli eax wieksze:
	addb %bh, %bl	#suma na bl + carry
	addl $4, %esp	#cofniecie przed pushl/moze byc 8(%esp) chyba
	movl 4(%esp), %ecx#na ecx mam adres
	addb (%esi, %ecx,1), %bl # +buff1
	movl 8(%esp), %ecx#buffor 2 na ecx
pushl %edx
	movl %esi, %edx
	subl %edi, %edx
	addb (%edx ,%ecx, 1), %bl
popl %edx
	
jmp warunek_equ_0	#skocz dalej

suma_dl2_wieksze:
	addb %bh, %bl	#suma na bl + carry
	addl $4, %esp	#cofniecie przed pushl/moze byc 8(%esp) chyba
	movl 8(%esp), %ecx#na ecx mam adres
	addb (%esi, %ecx,1), %bl # +buff1
	movl 4(%esp), %ecx
pushl %edx
	movl %esi, %edx
	subl %edi, %edx
	addb (%edx ,%ecx, 1), %bl
popl %edx		#znowu ma wartosc dl2

warunek_equ_0:
#4 jest dodana do esp bo robilem pushla ktorego nie sciagnalem
cmpb $0, %bl	
jne warunek_equ_1
movl 12(%esp), %ecx
movb $0, (%esi, %ecx, 1)
movb $0, %bh			#ustawienie carry
jmp koniec

warunek_equ_1:
cmpb $1, %bl
jne warunek_equ_2
movl 12(%esp), %ecx
movb $1, (%esi, %ecx, 1)
movb $0, %bh
jmp koniec

warunek_equ_2:
cmpb $2, %bl
jne warunek_equ_3
movl 12(%esp), %ecx
movb $0, (%esi, %ecx, 1)
movb $1, %bh
jmp koniec

warunek_equ_3:
cmpb $3, %bl			#czy suma = 3
jne warunek_equ_2
movl 12(%esp), %ecx
movb $1, (%esi, %ecx, 1)
movb $1, %bh

koniec:
cmpl $-1, %esi
decl %esi
ja petla_for


subl $4, %esp			#bo dodawalem
popl %eax

ret
