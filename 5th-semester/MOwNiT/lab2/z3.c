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

Function *derivatie(Function *fun1) {
    Function *fun2 = create_function(0, fun1->a * 2, fun1->b);
    return fun2;
}

long double find_root(Function *fun, long double x0) {
    long double x1 = x0 - get_value(fun, x0) / get_value(derivatie(fun), x0);
    if(absolute(get_value(fun, x1)) < EPSILON || absolute(x0 - x1) < EPSILON) return x1;
    else return find_root(fun, x1);
}

int main() {
    char a[10], b[10], c[10];
    long double A=0, B=2;
    scanf("%s%s%s", a, b, c);
    Function *fun1 = create_function((long double)strtol(a, NULL, 0), (long double)strtol(b, NULL, 0), (long double)strtol(c, NULL, 0));
    if(get_value(fun1, A) * fun1->a > 0) printf("%Lf\n", find_root(fun1, A)); // sprawdzamy, czy funkcja i jej druga pochodna mają te same znaki (2a ma ten sam znak co a, więc nie mnożyłem)
    else printf("%Lf\n", find_root(fun1, B));


    return 0;
}

