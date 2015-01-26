 int na_bin(char *dana, _Bool *buff)
{	
//podobnie jak w programie w ASM, operacje na ASCII
	int i, p, k = 0;
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
}
