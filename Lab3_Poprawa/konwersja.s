.text
.global _konwert
.type	_konwert, @function
_konwert:
pushl %edi
pushl %esi
movl 12(%esp), %ecx	#adres tablicy char'ow na ecx

xorl %ebx, %ebx		#i
xorl %edi, %edi
xorl %edx, %edx

while:
movb (%ebx, %ecx, 1), %dl
incl %ebx
cmpb $0, %dl		#poruszam sie po tablicy 
jne while

subl $2, %ebx		#i
xorl %edx, %edx

for:

cmpb $'9', (%ebx, %ecx, 1)
ja moze_litera
cmpb $'0', (%ebx, %ecx, 1)

movb $4, %al
imulb %dh
movl $1, %esi

for_potega:
cmpb $0, %al

jne przesun
jmp dalej

przesun:
	shl $1, %esi		#przesuwan o dh
	decb %al 
	jmp for_potega
dalej:
xorl %eax, %eax
movb  (%ebx, %ecx, 1), %al
andb $0xF, %al
imul %esi
addl %eax, %edi
jb moze_litera


moze_litera:
#podobnie jak wyzej


decl %ebx
xorl %eax, %eax
movb %dh, %ah
xor %edx, %edx
movb %ah , %dh
incb %dh


cmpl $-2, %ebx

#to chyba tu nie moze byc
jne for
#koniec for'a

movl %edi, %eax		#wynik dzialania
popl %esi
popl %edi
ret

