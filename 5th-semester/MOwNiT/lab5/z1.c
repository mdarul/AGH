#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

double monte_carlo_integration(double x0, double x1, double y0, double y1, int precision, double (*calculate_fun)(double)) {
    int hit_amount = 0;
    double cur_x, cur_y, val;
    for(int i=0; i<precision; i++) {
        cur_x = x0 + ((double)rand()/RAND_MAX)*(x1 - x0);
        cur_y = y0 + ((double)rand()/RAND_MAX)*(y1 - y0);
        val = calculate_fun(cur_x);
        if(val > 0 && cur_y > 0 && cur_y <= val) hit_amount++;
        else if(val < 0 && cur_y < 0 && cur_y >= val) hit_amount--;
    }
    return (double)hit_amount / (double)precision * (x1-x0) * (y1-y0);
}

double monte_carlo_interval(double x0, double x1, double y0, double y1, int precision, int intervals_amount, double (*calculate_fun)(double)){

    double start = x0, end = (double)(x0 + (x1-x0)/intervals_amount), sum = 0;
    for(int i = 1; i <= intervals_amount; i++) {
        sum += monte_carlo_integration(start, end, y0, y1, precision/intervals_amount, calculate_fun);
        start = end;
        end = end + (x1-x0)/intervals_amount;
    }
    return sum;
}

double calculate_fun1(double x) {
    return x*x;
}

double calculate_fun2(double x) {
    return 1 / sqrt(x);
}

double calculate_fun3(double x) {
    return (double)sin(x);
}

double calculate_fun4(double x) {
    return (-1)*x + 2;
}

int main() {
    srand(time(NULL));
    int N = (int)1e6, intervals_amount = 100;
    double x0=0, x1=1, y0=0, y1=2;
    double *values = malloc(sizeof(double)*(intervals_amount+1));

    double proper_value_fun1 = 0.33333333333, proper_value_fun2 = 2;
    for(int i=1; i <= intervals_amount; i++) values[i] =  fabs(proper_value_fun1 - monte_carlo_interval(x0, x1, y0, y1, N, i, &calculate_fun2));

    FILE *gnuplot = popen("gnuplot", "w");
    fprintf(gnuplot, "plot '-' with lines\n");
    for(int i=1; i <= intervals_amount; i++) fprintf(gnuplot, "%d %f\n", i, values[i]);
    fprintf(gnuplot, "e\n");
    fflush(gnuplot);
    getc(stdin);

    return 0;
}
