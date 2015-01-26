#include <stdio.h>
unsigned long long int rdtsc(void);

char* tab[1<<28];
unsigned long long int start, end, result;

void main()
{
  int  j, z = 1;
  double help = 0, i = 1;


  start = rdtsc();
    for(z = 0; z <= 28; z++)
    {
    help = 1<<z;
  start = rdtsc();
  for(j = 0; j <= 200; j++)
    for(i = 0; i <= help; i++)
    	tab[rand()%(int)help] += (('a')/15);
        
        
     result = rdtsc() - start;
       printf("2^%d   %f\n",z-1, (result/(help*2)/200));
    }
    }

