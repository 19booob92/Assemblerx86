 #include <stdio.h>
 #include <math.h>

#define stala 1000000; 

char tmp, liczba[stala], liczba2[stala];
int buffor_bin[stala];
int buffor_bin2[stala];
int wynik[stala];

int j, k, p, i, l, o, m, a,n, carry=0, suma=0, dl1, dl2;

void na_bin(char *dana, int *buff)
{	
//podobnie jak w programie w ASM, operacje na ASCII
	k = l = 0;
	while (dana[k] != '\0')
	{	
		for (p = 0; p < 4; p++)
		{		
			if (dana[k] >= '0' && dana[k] <= '9')
				dana[k] -= '0';
			else if (dana[k] >= 'A' && dana[k] <= 'F')
				{
					dana[k] -= 'A';
					dana[k] += 10;
				}
			else if (dana[k] >= 'a' && dana[k] <= 'f')
				{
					dana[k] -= 'a';
					dana[k] += 10;
				}	
			buff[l] = dana[k] % 2;
			dana[k] /= 2;
			l++;
		}
	k++;
	}
}


void zm_kol(int *buf)   //rotacja
{
n=l;
a=0;
	while (a < l - 4)
	{
		for (i = 0; i < 4; i++)
		{
			for  (m = n; m > a; m--)
			{
				tmp = buf[m];
				buf[m] = buf[m-1];
				buf[m-1] = tmp;
			}
			tmp = buf[n];
			buf[n] = buf[a];
			buf[a] = tmp;
		}
	a+=4;
	}	
}

void odw(int *bufor, int dlugosc)
{
	m=0;
	n=dlugosc;  
	while (m < n)
	{
		tmp = bufor[n];
		bufor[n] = bufor[m];
		bufor[m] = tmp;
		m++;
		n--;
	}
}

void dodawanie(int *buff1, int *buff2)
{	
	if (dl1 > dl2)
		a = dl1+1;
	else	a = dl2+1;
	
	for (m = 0; m <= a ; m++)
	{
		suma=buff1[m]+buff2[m]+carry;

                if (suma==0)
                {
	                wynik[m]=0;
                        carry=0;
                }
                if (suma==1)
                {
                        wynik[m]=1;
                        carry=0;
                }
                if (suma==2)
                {
                        wynik[m]=0;
                        carry=1;
                }
                if (suma==3)
                {
                        wynik[m]=1;
                        carry=1;
                }
        }	
}

 int main ()
 {
   printf ("Podaj liczbę w HEX: \n");
   gets(liczba);
   printf ("%s\n", liczba);

   printf ("Podaj drugą liczbę w HEX: \n");
   gets(liczba2);
   printf ("%s\n", liczba2); 
   	
   na_bin(liczba, buffor_bin);	
  
    dl1 = l;
    	zm_kol(buffor_bin);

   na_bin(liczba2, buffor_bin2);
   dl2 = l;
   zm_kol(buffor_bin2);

   dodawanie(buffor_bin, buffor_bin2);
   k = a;
     
//wypisywanie wpsisanych liczb w postaci binarnej
   odw(buffor_bin2, l-1);
   odw(buffor_bin, dl1-1);
   printf ("Liczba bin: \n");
   for (j = 0; j < dl1; j++)
   		printf("%d", buffor_bin[j]);
   printf("\n"); 
   
   printf ("druga liczba bin: \n");
   for (j = 0; j < dl2; j++)
   		printf("%d", buffor_bin2[j]);
   
   odw(wynik, a-1);  	
    
   printf("\n"); 
   for (j = 0; j < k; j++)
   	printf("%d", wynik[j]);
		
   printf("\n");
   return 0;
 }
