int dodawanie(_Bool *buff1, _Bool *buff2, _Bool *wynik, int dl_1, int dl_2)
{	
	int i, a, carry=0, suma=0;
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
}
