.bss

.lcomm zmienna, 55
.text
.global _start
_start:

	movl $3, %eax
	movl $0, %ebx
	movl $zmienna, %ecx
	movl $3, %edx		 
	int $0x80



movl $-1, %esi			#bo cchę od 0

BAZA_10 = 10
xorl %eax, %eax		#tuaj przechiowuje liczba *10
movl $10, %ecx
petla:  
	incl %esi
	
	#przygotowanie liczby

	subl $48, zmienna(%esi)
	
	imull %ecx
	addl zmienna(%esi), %eax


	cmpl $2, %esi 	#zależy od wykrytej ilości znaków (zapisanej na stosie)
	
	jb petla		#jeśli jeszcze nie przekroczyło to dalej
ex:
	addl $4, %esp
	movl %eax, %ebx	#wynik mam w ecx więc muszę przerzucić

  mov $1, %eax
  int $0x80
