all:
	@echo "kompilacja:"
	gcc -g -o lab6 test.c rdtsc.c
	gcc -o lab6_cache lab6_main_rozmiar.c rdtsc.c
test: lab6
	@echo "test:"
	./lab6
test2: lab6_cache
	./lab6_cache
clean:
	@echo "czyszczenie katalogu:"
	rm lab6 lab6_cache
