#include<stdio.h>

float find_epsilon()
{
    float epsilon = 1, last;
    while(1 + epsilon != 1) {
        last = epsilon;
        epsilon /= 2;
    }
    return last;
}

int main()
{
    printf("Machine epsilon: %.40f\n", find_epsilon());
}
