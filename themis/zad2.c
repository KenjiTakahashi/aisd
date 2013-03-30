#include <stdio.h>


int main() {
    long long int size, i, a, b, m, j, res, x;
    scanf("%Ld", &size);
    for(i = 0; i < size; ++i) {
        scanf("%Ld %Ld %Ld", &a, &b, &m);
        res = 1;
        x = a % m;
        for(j = 1; j <= b; j <<= 1) {
            x %= m;
            if((b & j) != 0) {
                res *= x;
                res %= m;
            }
            x *= x;
        }
        printf("%Ld\n", res);
    }
    return 0;
}
