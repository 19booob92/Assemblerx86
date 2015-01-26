 #include <stdio.h>
 #include <math.h>

char tmp, liczba[10000], liczba2[10000];
_Bool buffor_bin[10000];
_Bool buffor_bin2[10000];
_Bool wynik[10000];

int dlugosc, p, l, dl1, dl2;

extern int dodawanie(_Bool *buff1, _Bool *buff2, _Bool *wyn, int dl_1, int dl_2);

extern int na_bin(char *dana, _Bool *buff);
/*{	
//podobnie jak w programie w ASM, operacje na ASCII
	int k = 0;
	while (dana[k] != '\0')
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
	k++;
	}
	
	for (i = k-1 ; i >= 0; i--)
		for (p = 3; p >= 0; p--)
		{		
			buff[p+4*i] = dana[i] % 2;
			dana[i] /= 2;
		}
	return k;	
}*/


/*{	
	int a, carry=0, suma=0;
	if (dl_1 > dl_2)
		a = dl_1+1;
	else	a = dl_2+1;
	
	for (i = a; i >=-1 ; i--)
	{
		if (dl_1 > dl_2)
		{
			suma=buff1[i]+buff2[i-abs(dl_1-dl_2)]+carry;	
		}
		else
		{
			suma=buff1[i-abs(dl_1-dl_2)]+buff2[i]+carry;
		}
                if (suma==0)
                {
	                wynik[i]=0;
                        carry=0;
                }
                if (suma==1)
                {
                        wynik[i]=1;
                        carry=0;
                }
                if (suma==2)
                {
                        wynik[i]=0;
                        carry=1;
                }
                if (suma==3)
                {
                        wynik[i]=1;
                        carry=1;
                }
        }	
return a;
}*/

 int main ()
 {
   printf ("Podaj liczbę w HEX: \n");
   gets(liczba);
   printf ("%s\n", liczba);

   printf ("Podaj drugą liczbę w HEX: \n");
   gets(liczba2);
   printf ("%s\n", liczba2); 
   int po = na_bin(liczba, buffor_bin); 	
   dl1  = 4*po;//na_bin(liczba, buffor_bin);			//zamiana pierwszej liczby
   //dl1 = 8; 

   dl2 = 4*na_bin(liczba2, buffor_bin2);		//zamiana drugiej liczby
   					//określenie długości ciągu 0/1
   
   dlugosc=dodawanie(buffor_bin, buffor_bin2,wynik,  dl1, dl2);		//wywołanei dodawania edytuje tablicę "wynik" zwraca długość
   					//określenia jak długi ma być ciąg zawierający wynik    
//wypisywanie wpsisanych liczb w postaci binarnej
   printf ("Liczba bin: \n");
   for (p = -1; p < dl1; p++)
   		printf("%d", buffor_bin[p]);

   printf("\n"); 
   
   printf ("druga liczba bin: \n");
   for (p = -1; p < dl2; p++)
   		printf("%d", buffor_bin2[p]);
   
   printf("\n"); 
   for (p = -1; p < dlugosc-1; p++)
   	printf("%d", wynik[p]);
	
   printf("\n");
   return 0;
 }
