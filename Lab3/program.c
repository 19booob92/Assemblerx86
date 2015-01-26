 #include <stdio.h> 

char tmp, liczba[1000000], liczba2[1000000];
int buffor_bin[1000000];
int buffor_bin2[1000000];
int wynik[1000000];

int j, k, p, i, l, o, m, a,n, carry=0, suma=0, dl1, dl2;
//definicjcja odwołań do funkcji napisanych w ASM
extern void na_bin(char *dana, int *buff);
extern void zm_kol(int *buf);
extern void odw(int *bufor, int dlugosc);
extern void dodawanie(int *buff1, int *buff2);


int main ()
 {
//pytanie o liczbę
   printf ("Podaj liczbę w HEX: \n");
//pobranie liczby
   gets(liczba);
   printf ("%s\n", liczba);

   printf ("Podaj drugą liczbę w HEX: \n");
   gets(liczba2);
   printf ("%s\n", liczba2); 
//konwerjsa z HEX na BIN  	
   na_bin(liczba, buffor_bin);	
//zapisanie długości pierwszego ciągu  
    dl1 = l;
//zamianan kolejności bajtów
    zm_kol(buffor_bin);

   na_bin(liczba2, buffor_bin2);
   dl2 = l;
   zm_kol(buffor_bin2);
//wywołanie funkcji dodającej
   dodawanie(buffor_bin, buffor_bin2);
//zapisanie a, ponieważ zaraz bęzdie zmienieone
   k = a;

//odwrócenie kolejności bitów     
   odw(buffor_bin2, l-1);
   odw(buffor_bin, dl1-1);
   printf ("Liczba bin: \n");
//wypisywanie kolejnych bitów
   for (j = 0; j < dl1; j++)
   		printf("%d", buffor_bin[j]);
   printf("\n"); 
   
   printf ("druga liczba bin: \n");
   for (j = 0; j < dl2; j++)
   		printf("%d", buffor_bin2[j]);
//odwrócenei kolejności bitów wyniku
   odw(wynik, a-1); 
    
   printf("\n"); 
   for (j = 0; j < k; j++)
   	printf("%d", wynik[j]);
   	
   printf("\n");
   return 0;
 }
