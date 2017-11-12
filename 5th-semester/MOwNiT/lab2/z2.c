#include <stdio.h>
#include <stdlib.h>

const long double EPSILON = 0.0000001;

typedef struct Function {
    long double a, b, c;
} Function;

Function *create_function(long double a, long double b, long double c) {
    Function *fun = (Function*) malloc(sizeof(Function));
    fun->a = a;
    fun->b = b;
    fun->c = c;
    return fun;
}

long double get_value(Function *fun, long double x) {
    return fun->a*x*x + fun->b*x + fun->c;
}
//cmake doesnt see tgmath.h
long double absolute(long double x) {
    return x >= 0 ? x : (x * (-1));
}

long double find_root(Function *fun, long double x1, long double x2) {
    long double x3 = x2 - (get_value(fun, x2) * (x2-x1))/(get_value(fun, x2) - get_value(fun, x1));
    if(absolute(get_value(fun, x3)) < EPSILON || absolute(x1-x2) < EPSILON) return x3;
    else return find_root(fun, x2, x3);
}

int main() {
    char a[10], b[10], c[10];

    Function *fun1 = create_function(1, 0, -5);
    printf("%Lf\n", find_root(fun1, 2, 3));


    return 0;
}

