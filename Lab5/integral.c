 #include "stdio.h"
 #include <time.h> 
 #include <math.h>
//gdize xp to początek przedziału całkowania, xk -
//koniec tego przeziału, n ilość prosotkątów, (przekłada się na dokładność)
//x zmienna całkowania, dx odległość między kolejnymi
//punktami
 	
double xp = 0.001, xk = 1000, dx, wynik, n = 1000000;   
unsigned long long int pocz, koniec;   
extern unsigned long long int rdtsc(void);				
extern float calka(float xp_, float xk_, float n_,int iner);//funkcja
extern double calka_fpu(double xp_, double xk_, double n);//funkcja
extern double calka_double(double xp_, double xk_,double n_, int iter);//funkcja
double pomoc;
float pomoc2;
extern unsigned short int set_fpu();

int main()
{	

//funkcja SIMD Single
	pocz = rdtsc();			//początek pomiaru czasu
	pomoc2 = (float)calka(xp, xk, n, (int)(n/4));
	koniec = rdtsc();		//data, gdy czas przestał być mierzony

	printf("Wynik wynosi (SINGLE): %f \n",pomoc2);
	
	printf("Czas obliczania całki z funkcji 1 / x  : %lld \n\n", (koniec-pocz));

//funkcja SIMD Single
	pocz = rdtsc();			//początek pomiaru czasu
	pomoc2 = (float)calka(xp, xk, n, (int)(n/4));
	koniec = rdtsc();		//data, gdy czas przestał być mierzony

	printf("Wynik wynosi (SINGLE): %f \n",pomoc2);
	
	printf("Czas obliczania całki z funkcji 1 / x  : %lld \n\n", (koniec-pocz));


 
//funkcja SIMD Double

	pocz = rdtsc();			//początek pomiaru czasu
	pomoc = calka_double(xp, xk, n, (int)(n/2)); //powinno byc n/2
	koniec = rdtsc();		//data, gdy czas przestał być mierzony

	printf("Wynik wynosi (DOUBLE): %f \n",pomoc);
 
	printf("Czas obliczania całki z funkcji 1 / x  : %lld \n\n", (koniec-pocz)); 


//funkcja SIMD Double

	pocz = rdtsc();			//początek pomiaru czasu
	pomoc = calka_double(xp, xk, n, (int)(n/2)); //powinno byc n/2
	koniec = rdtsc();		//data, gdy czas przestał być mierzony

	printf("Wynik wynosi (DOUBLE): %f \n",pomoc);
 
	printf("Czas obliczania całki z funkcji 1 / x  : %lld \n\n", (koniec-pocz)); 



//funckja na FPU

	pocz = rdtsc();			//początek pomiaru czasu
	pomoc =calka_fpu(xp, xk, n); 
	koniec = rdtsc();		//data, gdy czas przestał być mierzony

	printf("Wynik wynosi calka na FPU: %f \n",pomoc);
 
	printf("Czas obliczania całki z funkcji 1 / x  : %lld \n\n", (koniec-pocz)); 

return 0;
}
