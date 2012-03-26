#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    if(a > b) {
        int c = a;
        a = b;
        b = c;
    }
    for(; a <= b; ++a) {
        printf("%d\n", a);
    }
    return 0;
}
