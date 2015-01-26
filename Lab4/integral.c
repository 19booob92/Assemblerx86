 #include "stdio.h"
 #include <math.h>
 
//gdize xp to początek przedziału całkowania, xk -
//koniec tego przeziału, n ilość prosotkątów, (przekłada się na dokładność)
//x zmienna całkowania, dx odległość między kolejnymi
//punktami
 	
double xp = 0.001, xk = 1000, dx, wynik;   
unsigned long long int pocz, koniec;   
extern unsigned long long int rdtsc(void);				
extern double calka(double xp_, double xk_);//funkcja
void set_fpu();
main()
{	
	pocz = rdtsc();			//początek pomiaru czasu
(double)calka(xp, xk);
	koniec = rdtsc();		//data, gdy czas przestał być mierzony
	printf("%f", (double)calka(xp,xk)); 
	printf("Czas obliczania całki z funkcji 1 / x przed zmainą: %lld \n", (koniec-pocz)); 
	
   	set_fpu();			//zmieniam ustawnienia bitów FPU (zmieniam dokładność)
	
	pocz = rdtsc();			//początek pomiaru czasu
 	printf("Wynik po zmianie bitów FPU wynosi: %f \n", (double)calka(xp, xk));
	koniec = rdtsc();		//data, gdy czas przestał być mierzony
 
	printf("Czas obliczania całki z funkcji 1 / x po zmainie dokładności: %lld\n", (koniec-pocz)); 	
	
}
