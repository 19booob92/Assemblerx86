 #include <stdio.h>
 #include <math.h>

char tmp, liczba[1000000], liczba2[1000000];
int buffor_bin[1000000];
int buffor_bin2[1000000];
int wynik[1000000];

int j, k, p, l, o, m, a,n, carry=0, suma=0, dl1, dl2, liczba_dec, liczba_dec2;
extern int _gcd(int a, int b);
//extern int _konwert(char* dana);




int konwertuj_na_dec(char *liczba)
{
suma = 0;
int i=0,m= 0,n;
	while (liczba[i] != '\0')
		i++;
	for (m = i-1,n=0 ; m >= 0; m--, n++)
	{
		if (liczba[m] <= '9' && liczba[m] >= '0')
			suma += (liczba[m] & 0xF)*(1<<(n*4));
		else
		{
			suma += ((liczba[m] & 0xF)+9)*(1<<(n*4));
		}
		
	 }
	 return suma;
}


 int main ()
 {
  	   
   printf ("Podaj liczbę w HEX: \n");
   gets(liczba);




   printf ("Podaj drugą liczbę w HEX: \n");
   gets(liczba2);
   	

   	
      //liczba_dec = konwertuj_na_dec(liczba);
      
   printf("%dfunckja w asmie\n", _konwert(liczba));	      
      	
   //liczba_dec2 = konwertuj_na_dec(liczba2);
   

   	
   	
   //printf("\n\nGCD = %d \n\n" ,  _gcd(liczba_dec, liczba_dec2));	

   return 0;
 }
