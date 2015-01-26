all:
	@echo "kompilacja:"
	gcc -g -o lab6 avg_acs.c rdtsc.c
	gcc -g -o lab6_dro lab6_droznosc.c rdtsc.c
	gcc -g -o lab6_roz lab6_roz.c rdtsc.c
test: lab6
	@echo "test: "
	./lab6

test1: lab6_dro
	@echo "test droznosc: "
	./lab6_dro

test2: lab6_roz
	@echo "test rozmiar cache"
	./lab6_roz

clean:
	@echo "czyszczenie katalogu:"
	rm lab6
	rm lab6_dro
	rm lab6_roz
