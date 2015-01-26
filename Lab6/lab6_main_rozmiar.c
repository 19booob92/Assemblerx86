#include "stdio.h"

extern unsigned long long int rdtsc(void);
unsigned long long int pocz, koniec;

double tab[1<<20],x;
int i;
int main()
{
for(i=0;i<(1<<8) ;i++)
{
pocz = rdtsc();
	x=tab[i];
	tab[i*8]=x++;
koniec = rdtsc();
if ((i%4096) == 0)
printf("%d, %lld \n",i, (koniec-pocz));


}

return 0;
}
