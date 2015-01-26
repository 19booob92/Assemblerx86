.bss

.lcomm zmienna, 55
.text

.global _start

_start:
	movl $3, %eax
	movl $0, %ebx
	movl $zmienna, %ecx
	movl $15, %edx		 #zakładam że są 3 znaki
	int $0x80

xorl %edi, %edi
movb $10, %ah
petla_:
	incl %edi
	cmpb zmienna(%edi), %ah
		
		jne petla_
pushl %edi			#przeniesienie na stos ilości znaków

movb $'1', %al
xorl %ecx, %ecx
movl $1, %edi			#bo chcę zaczynać od 2 znaku
movl (%esp), %edx
xorl %ebx, %ebx


petla:  
	incl %edi
	decl %edx
	cmpb zmienna(%edi), %al  #jeśli 1 to 
	je podnies		  
	
	cmpl (%esp), %edi 		#zakładam że są 3 znaki
	jbe petla		#jeśli jeszcze nie przekroczyło to dalej
	jmp ex




podnies:xorl %esi, %esi
	movl $1, %ebx
	call potega
	addl %ebx, %ecx	#sumuje kolejne potegi
	jmp petla

ex:
	addl $4, %esp
	movl %ecx, %ebx	#wynik mam w ecx więc muszę przerzucić
  mov $1, %eax
  int $0x80


#funcka potegi
.type potega, @function
potega:
	pot:	
	cmpl %edx, %esi	 #edi jest zależne od tego u góry
	jae tu	
	imull $2, %ebx		

	incl %esi
	
	jmp pot
tu:
ret
