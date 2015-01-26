all:
	@echo "kompilacja:"
	gcc -g -o lab4 integral.c calki_funk.s set_fpu.s rdtsc.c
	@echo "kompilacja programu z funkcja w C"
	gcc -o lab4_funkcjacwC calki.c
test: lab4
	@echo "test:"
	./lab4
test2: lab4_funkcjacwC
	@echo "testowanie programu z funckja napisana w C"
	./lab4_funkcjacwC

clean:
	@echo "czyszczenie katalogu:"
	rm lab4
	rm lab4_funkcjacwC
