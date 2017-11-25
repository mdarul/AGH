#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <gsl/gsl_errno.h>
#include <gsl/gsl_fft_real.h>
#include <time.h>

int main()
{
	srand(time(NULL));
	int N = 256;
	double data[N];
	for(int i=0; i<N; i++) data[i] = cos(4*M_PI*i/N) + ((float)rand()/RAND_MAX)/8.0;
	//gsl_fft_real_radix2_transform(data, 1, N);
	//for(int i=0; i<N; i++)
	//	if(fabs(data[i]) < 50) 
	//		data[i] = 0;

	//gsl_fft_halfcomplex_radix2_inverse(data, 1, N);

	FILE *gnuplot = popen("gnuplot", "w");
	//fprintf(gnuplot,"set logscale x 10\n");
	fprintf(gnuplot, "plot '-' with boxes\n");

	for(int i=0; i<N; i++) fprintf(gnuplot, "%d %f\n", i,  data[i]);
	fprintf(gnuplot, "e\n");	
	fflush(gnuplot);
	getc(stdin);

	return 0;
}
