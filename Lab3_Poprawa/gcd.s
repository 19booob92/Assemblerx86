.global _gcd
.type	_gcd, @function
_gcd:
movl %edi, %eax
licz:
movl $0, %edx

divl %esi	#dziele 9/6
xchgl %eax, %esi
xchgl %edx, %esi

andl %esi, %esi
jnz licz




ret


