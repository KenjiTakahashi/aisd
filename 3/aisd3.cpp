/* g++ -Wall -W -O2 -static */
#include <cstdio>
#include <vector>

using namespace std;

int main() {
    int l, n, b, d, c;
    long long res;
    int st = 0;
    int sp = 1;
    scanf("%d %d %d\n", &l, &n, &b);
    vector<vector<long long> > arr(n + 1, vector<long long>(2, 0));
    for(int i = 0; i < n; ++i) {
        scanf("%d %d\n", &d, &c);
        if(d < l) {
            while(st < sp && arr[st][0] + b < d) {
                st += 1;
            }
            if(st == sp) {
                printf("-1");
                return 0;
            } else {
                res = c + arr[st][1];
                while(st < sp && arr[sp - 1][1] >= res) {
                    sp -= 1;
                }
                arr[sp][0] = d;
                arr[sp][1] = res;
                sp += 1;
            }
        } else {
            break;
        }
    }
    while(st < sp && arr[st][0] + b < l) {
        st += 1;
    }
    if(st == sp) {
        printf("-1");
    } else {
        printf("%lld\n", arr[st][1]);
    }
    return 0;
}
