#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <sys/time.h>
#include <gsl/gsl_linalg.h>

const double EPSILON = 0.001;

int main(int argc, char *argv[])
{
	srand(time(NULL));
	if(argc != 2) {
		printf("usage: program <N>");
		exit(1);
	}
	int N = atoi(argv[1]);
	double A[N*N];
 	double B[N];
	
	for(int i=0; i<N*N; i++) A[i] = (double)(rand() % 20);
	for(int i=0; i<N; i++) B[i] = (double)(rand() % 20);
	double A_mirror[N*N];
	for(int i=0; i<N*N; i++) A_mirror[i] = A[i];
	//printing arrays
	printf("A: ");
	for(int i=0; i<N*N; i++) printf("%g ", A[i]);
	printf("\nB: ");	
	for(int i=0; i<N; i++) printf("%g ", B[i]);
	printf("\n");

	gsl_matrix_view m = gsl_matrix_view_array (A, N, N);
	gsl_vector_view b = gsl_vector_view_array (B, N);
	gsl_vector *x = gsl_vector_alloc (N);

	int s;
	struct timeval start1, stop1, start2, stop2;
	gsl_permutation * p = gsl_permutation_alloc (N);
	gettimeofday(&start1, NULL); // get start time
	gsl_linalg_LU_decomp (&m.matrix, p, &s);
	gettimeofday(&stop1, NULL); // get end time
	gettimeofday(&start2, NULL);
	gsl_linalg_LU_solve (&m.matrix, p, &b.vector, x);
	gettimeofday(&stop2, NULL);
	printf ("x = \n");
	gsl_vector_fprintf (stdout, x, "%g");

	//A * x => output_vector
	m = gsl_matrix_view_array (A_mirror, N, N); // update matrix, previous data in A is broken
	gsl_vector *output_vector = gsl_vector_alloc (N);
	gsl_blas_dgemv(CblasNoTrans, (double)1, &m.matrix, x, (double)0, output_vector); //A * x => output_vector
	printf("Output vector:\n");
	gsl_vector_fprintf (stdout, output_vector, "%g");
	
	//check Ax-b=E, where E is epsilon's matrix
	for(int i=0; i<N; i++) {
		if(fabs(gsl_vector_get(output_vector, i) - B[i]) > EPSILON) {
			printf("Approximation  is not valid\n");
			break;
		}
		if(i == N-1) printf("It's ok!\n");
	}
	printf("Decomposition time in microseconds: %lu\n", stop1.tv_usec - start1.tv_usec);
	printf("Solving time in microseconds: %lu\n", stop2.tv_usec - start2.tv_usec);	

	gsl_permutation_free (p);
	gsl_vector_free (x);
	gsl_vector_free(output_vector);

	return 0;

}
