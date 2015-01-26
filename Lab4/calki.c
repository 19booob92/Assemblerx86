 #include "stdio.h"
 #include <time.h> 
 #include <math.h>
 #include "rdtsc.c"
//gdize xp to początek przedziału całkowania, xk -
//koniec tego przeziału, n ilość prosotkątów, (przekłada się na dokładność)
//x zmienna całkowania, dx odległość między kolejnymi
//punktami
time_t pocz, koniec; 			//zmienne do przechowywania wartośći czasu
 
double xp = 0.001, xk = 1000, dx,i,wynik, n = 99999999;      
					
double integral(double xp_, double xk_, double n_)	//funkcja
{	
 	dx = (xk_ - xp_)/n_;		//odejmuję warość punktu końcowego
 	for (i = 1; i <= n_; i++)
 		wynik += 1/(xp_+(i*dx));//druga część to funckja w tym //przypaku 1 / x
	
 	wynik *= dx;
 	return wynik;
}
 
main()
{	
	pocz = clock();									//początek pomiaru czasu
 	printf("Wynik wynosi: %f \n", (double)integral(xp, xk, n));
	koniec = clock();									//data, gdy czas przestał być mierzony
 
	printf("Czas obliczania całki z funkcji 1 / x dużą dokładnością wynosi: %f s\n", (double)(koniec-pocz)/CLOCKS_PER_SEC); 
}
 
