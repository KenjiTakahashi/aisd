/* Karol Woźniak
 * 233234
 * MSz
 */
#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    if(a % 2 == 0) {
        a += 1;
    }
    if(b % 2 == 0) {
        b -= 1;
    }
    int i;
    for(i = a; i <= b; i += 2) {
        printf("%d ", i);
    }
    printf("\n");
    return 0;
}
