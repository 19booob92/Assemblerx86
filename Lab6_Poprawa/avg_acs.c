#include <stdio.h>
unsigned long long int rdtsc(void);


//duża tablica znaków (każdy element to 1 B)
char tab[1<<22];
unsigned long long int start, czas_zapisu, czas_odczytu;
int taktowanie_mojego_CPU = 2200000;
int main()
{

  int  j, z = 0;
  double potega = 0, i = 1;


//czas zapisu
    start = rdtsc();

    for(z = 0; z <= (1<<15); z++)
    {
    
	    tab[rand()%(int)((1<<15)+1)] += (('a')/100)+155;
 
    }
    czas_zapisu = rdtsc() - start;
    printf("sredni czas zapisu %lld\n",(czas_zapisu/(1<<15)));
    
    //czas odczytu
    
      start = rdtsc();

    for(z = 0; z <= (1<<15); z++)
    {
	    j = tab[rand()%((1<<15)+1)];
            j += (('a')/100)+155;
    }
    czas_odczytu = rdtsc() - start;
    printf("sredni czas odczytu %lld\n",(czas_odczytu/(1<<15)));
    
    
        printf("Średni czas dostępu do pamieci L1 wynosi: %lld *1e-5 s\n\n\n", 
        	100000*((czas_odczytu+czas_zapisu)/(2*(1<<15)))/taktowanie_mojego_CPU);
      
//dla L2****************************************************************************

    start = rdtsc();

    for(z = 0; z <= (1<<20); z++)
    {
    
	    tab[rand()%(int)((1<<20)+1)] += (('a')/100)+155;
 
    }
    czas_zapisu = rdtsc() - start;
    printf("sredni czas zapisu %lld\n",(czas_zapisu/(1<<20)));
    
    //czas odczytu
    
      start = rdtsc();

    for(z = 0; z <= (1<<20); z++)
    {
	    j = tab[rand()%((1<<20)+1)];
            j += (('a')/100)+155;
    }
    czas_odczytu = rdtsc() - start;
    printf("sredni czas odczytu %lld\n",(czas_odczytu/(1<<20)));
    
    
    printf("Średni czas dostępu do pamieci L2 wynosi: %lld *1e-5 s\n", 
    		100000*((czas_odczytu+czas_zapisu)/(2*(1<<20)))/taktowanie_mojego_CPU);
           
      
    return 0;
    
}

