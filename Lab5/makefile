lab5:
	@echo "kompilacja"	
	gcc -g -o lab5 integral.c calki_funk_simd.s calki_funk.s calki_funk_simd_double.s rdtsc.c

test: lab5
	@echo "test programu"
	./lab5

clean:
	@echo "usuwanie exe"
	rm lab5
