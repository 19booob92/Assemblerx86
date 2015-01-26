.global _sw
.type _sw, @function 
_sw:

pushq %rbp
movq %rsp, %rbp


fstsw -8(%rbp)
movw $0x0, -8(%rbp)    #kasuje ustawienia

#fldsw -8(%rbp)
popq %rbp

ret
