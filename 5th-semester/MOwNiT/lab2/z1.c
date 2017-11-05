#include <stdio.h>
#include <stdlib.h>

#define EPSILON	0.0000001

typedef struct Function {
	int a, b, c;
} Function; 

int main() {
	Function *func1 = (Function *) malloc(sizeof(Function));
	scanf("%d%d%d", func1->a, func1->b, func1->c);
	printf("%d%d%d", func1->a, func1->b, func1->c);
	return 0;
}

