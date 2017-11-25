#include <stdio.h>
#include <math.h>
#include <gsl/gsl_errno.h>
#include <gsl/gsl_fft_real.h>

int main()
{
	int N = 256;
	double data[N];
	for(int i=0; i<N; i++) data[i] = cos(4*M_PI*i/N) + cos(16*M_PI*i/N)/5 + cos(32*M_PI*i/N)/8 + cos(128*M_PI*i/N)/16; 
	gsl_fft_real_radix2_transform(data, 1, N);
	
	FILE *gnuplot = popen("gnuplot", "w");
	fprintf(gnuplot, "plot '-' with boxes\n");

	for(int i=0; i<N; i++) fprintf(gnuplot, "%d %f\n", i,  data[i]);
	fprintf(gnuplot, "e\n");	
	fflush(gnuplot);
	getc(stdin);

	return 0;
}
