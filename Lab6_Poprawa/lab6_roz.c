#include <stdio.h>
unsigned long long int rdtsc(void);

//duża tablica znaków (każdy element to 1 B)
char* tab[1<<28];
unsigned long long int start,pomiar, koniec;

void main()
{
//iteratory
  int  j, z = 0;
  double potega = 0, i = 1;

//pomar czasu obejmuje wykonanie wszystkich obliczeń
//potęgi od 8 do 27
    for(z = 8; z <= 27; z++)
    {
	    potega = 1<<z;
	    start = rdtsc();
//aby czas był uśredniony wykonuje 100 pomiarów
	    for(j = 0; j <= 100; j++)
//poruszam się po losowych polach pamięci (w sensie abstrakcyjnym - tablicy)
		    for(i = 0; i <= potega; i++)
	   	    	tab[rand()%(int)potega+1] += (('a')/100)+155;
       koniec=rdtsc(); 
     	    pomiar = koniec -  start;
//wypisuję wielkość obszaru po którym się poruszam oraz czas (uśredniony)
            printf("2^%d   %f\n",z, (pomiar/(potega*j)));
    }
}

