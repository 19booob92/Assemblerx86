#include <stdio.h>
#include <string.h>

unsigned char liczba_1[1000], liczba_2[1000],*wynik;
int liczba_1_len, liczba_2_len;

extern unsigned char* gcd(unsigned char* liczba_1, int l_liczba_1, unsigned char* liczba_2, int l_liczba_2);

unsigned char* wynik;
int i,j=0;
	
int main()
{

	printf("Podaj pierwszą liczbe w hex: ");
	scanf("%s", liczba_1);
	
	printf("Podaj drugą liczbe w hex: ");
	scanf("%s", liczba_2);

	wynik = gcd(liczba_1, liczba_1_len=strlen(liczba_1), liczba_2, liczba_2_len=strlen(liczba_2));	
	
	while (wynik[j] == 0)
	{
		j++;
	}
	for (i = j; i < 100; i++)
	{
		
		printf("%02x", wynik[i]);
	}
	printf("\n");
	
	
	return 0;
}
