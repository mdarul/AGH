#include <stdlib.h>
#include <gsl/gsl_math.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

struct fun_parameters {
    double a;
    double b;
    double c;
};

double user_fun(double x[], size_t dim, void *p) {
    struct fun_parameters *f_par = (struct fun_parameters *) p;
    if(dim != 2) abort();
    return f_par->a*x[0]*x[0] + f_par->b*x[0]*x[1] + f_par->c*x[1]*x[1];
}

int main() {
    gsl_monte_function F;
    struct fun_parameters par = {1.0, 0.0, 0.0};
    F.f = &user_fun;
    F.dim = 2;
    F.params = &par;

    double correct_value = 0.3333333333;
    double result, abserr;
    size_t dim = 2;
    double xl[2] = {0.0, 0.0};
    double xu[2] = {1.0, 1.0}; // xl[0] i xu[0] to x0 i x1
    size_t calls;
    gsl_rng *r;

    const gsl_rng_type *T;
    gsl_rng_env_setup();
    T = gsl_rng_default;
    r = gsl_rng_alloc(T);

    int i = 0, n = 6;
    double values[3][n];

    for(calls = 100; calls <= pow(10, n); calls*=10) {
        gsl_monte_plain_state *state1 = gsl_monte_plain_alloc(dim);
        gsl_monte_plain_integrate(&F, xl, xu, dim, calls, r, state1, &result, &abserr);
        gsl_monte_plain_free(state1);
        values[0][i] = fabs(correct_value - result);
        i++;
    }

    printf("\n\n");

    i = 0;
    for(calls = 100; calls <= pow(10, n); calls*=10) {
        gsl_monte_miser_state *state2 = gsl_monte_miser_alloc(dim);
        gsl_monte_miser_integrate(&F, xl, xu, dim, calls, r, state2, &result, &abserr);
        gsl_monte_miser_free(state2);
        values[1][i] = fabs(correct_value - result);
        i++;
    }
    printf("\n\n");

    i = 0;
    for(calls = 100; calls <= pow(10, n); calls*=10) {
        gsl_monte_vegas_state *state3 = gsl_monte_vegas_alloc(dim);
        gsl_monte_vegas_integrate(&F, xl, xu, dim, calls, r, state3, &result, &abserr);
        gsl_monte_vegas_free(state3);
        values[2][i] = fabs(correct_value - result);
        i++;
    }

    FILE *gnuplot = popen("gnuplot", "w");
    fprintf(gnuplot, "set yrange [0:0.05]\n");

    fprintf(gnuplot, "set terminal qt 0\n");
    fprintf(gnuplot, "plot '-' with lines title \"plain\"\n");
    for(i=0; i < n; i++) fprintf(gnuplot, "%d %f\n", i, values[0][i]);
    fprintf(gnuplot, "e\n");

    fprintf(gnuplot, "set terminal qt 1\n");
    fprintf(gnuplot, "plot '-' with lines title \"miser\"\n");
    for(i=0; i < n; i++) fprintf(gnuplot, "%d %f\n", i, values[1][i]);
    fprintf(gnuplot, "e\n");

    fprintf(gnuplot, "set terminal qt 2\n");
    fprintf(gnuplot, "plot '-' with lines title \"vegas\"\n");
    for(i=0; i < n; i++) fprintf(gnuplot, "%d %f\n", i, values[2][i]);
    fprintf(gnuplot, "e\n");


    fflush(gnuplot);
    getc(stdin);

    return 0;
}
