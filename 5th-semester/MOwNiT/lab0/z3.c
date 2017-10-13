#include <stdio.h>
#include <stdlib.h>


double x_eval_double(int n)
{
	if(n == 0) return (double)0.01;
	double tmp = x_eval_double(n-1);
	return 4 * tmp - 3 * tmp * tmp;
}

double x_eval_float(int n)
{
	if(n == 0) return (float)0.01;
	float tmp = x_eval_float(n-1);
	return 4 * tmp - 3 * tmp * tmp;
}

int main(int argc, char *argv[])
{
	if(argc != 2) {
		printf("usage: program <number>\n");
		return 1;
	}
	
	double x1 = x_eval_double((double)atoi(argv[1]));
	float x2 = x_eval_float((float)atoi(argv[1]));
	printf("double: %f\nfloat: %f\n", x1, x2);
}
