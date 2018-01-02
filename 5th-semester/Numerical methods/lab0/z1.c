#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[])
{
	if(argc != 2) {
		printf("usage: program <number>\n");
		return 1;
	}

	double x1 = (double)atof(argv[1]);
	float x2 = (float)atof(argv[1]);
	
	printf("double: %.20llX\nfloat: %.20X\n", *(long long *)&x1, *(int*)&x2);
	return 0;
}
