//maksimum dla (4, 3)
#include <stdio.h>
#include <stdlib.h>

int main()
{
	FILE* gnuplot = popen("gnuplot", "w");
	//fprintf(gnuplot,"set view map\n");
	fprintf(gnuplot,"splot \"dane2.txt\" with lines  \n");
	fflush(gnuplot);
	getc(stdin);
	return 0;
}
