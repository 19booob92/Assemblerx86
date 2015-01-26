 #include <stdio.h>

double tab1[1<<23];
extern unsigned long long int rdtsc(void);

int main()
{
	unsigned long long int start, koniec,czas;
	
	double ile,n,x=0, i,h=0;

		

	for(i=0;i<1000;i++)
	{
		x=tab1[1<<19];
		x++;
		tab1[1<<19]=x;
	}

koniec = rdtsc();
	
  printf("%f   ----   %lld\n ",h,  koniec-start);

			




	for(i=0;i<1000;i++)
	{
		x=tab1[1<<20];
		x++;
		tab1[1<<20]=x;
	}

koniec = rdtsc();
	
  printf("%f   ----   %lld\n ",h,  koniec-start);





		

	for(i=0;i<1000;i++)
	{
		x=tab1[1<<21];
		x++;
		tab1[1<<21]=x;
	}
	
koniec = rdtsc();
	
  printf("%f   ----   %lld\n ",h,  koniec-start);





	for(i=0;i<1000;i++)
	{
		x=tab1[1<<22];
		x++;
		tab1[1<<22]=x;
	}
	
koniec = rdtsc();
	
  printf("%f   ----   %lld\n ",h,  koniec-start);


	




	for(i=0;i<1000;i++)
	{
		x=tab1[1<<23];
		x++;
		tab1[1<<23]=x;
	}
	
koniec = rdtsc();
	
  printf("%f   ----   %lld\n ",h,  koniec-start);




	return 0;
}
