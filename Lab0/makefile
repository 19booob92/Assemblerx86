asm0: asm0.o
	ld -o asm0 asm0.o
asm0.o: asm0.s
	as -o asm0.o asm0.s
.PHONY: clean 
clean:
	rm -f asm0 asm0.o
.PHONY: test
test:
	./asm0

