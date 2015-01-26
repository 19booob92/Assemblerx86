#include <stdio.h>

int main()
{
        int i, rozm = 1<<28;
        unsigned long long g1, g2;
        char A[rozm];
	int x = 0;

        for (x = 0; x < 28; x++)
	{
	     	g1 = rdtsc();

	        for (i = 0; i < 1000; i++)
        	{
       	                A[1<<x] = 'a'+'c';
	        }

	}
        return 0;
}

