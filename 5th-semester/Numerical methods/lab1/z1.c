#include <stdio.h>
#include <stdlib.h>

int main()
{
	FILE* gnuplot = popen("gnuplot", "w");
	//fprintf(gnuplot,"set view map\n");
	fprintf(gnuplot,"set logscale x 10\n");
	fprintf(gnuplot,"plot \"dane1.txt\" with lines  \n");
	fflush(gnuplot);
	getc(stdin);
	return 0;
}
