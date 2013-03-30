#include <stdio.h>


int data[1000000];


int main() {
    int i, n;
    scanf("%d", &n);
    for(i = 0; i < n; ++i) {
        scanf("%d", &data[i]);
    }
    int x, l, p;
    int m;
    scanf("%d", &m);
    for(i = 0; i < m; ++i) {
        scanf("%d", &x);
        l = 0;
        p = n;
        while(l < p) {
            int s = (l + p) / 2;
            if(x > data[s]) {
                l = s + 1;
            } else {
                p = s;
            }
        }
        printf("%d ", n - l);
    }
    printf("\n");
    return 0;
}
