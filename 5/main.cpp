/* g++ -Wall -W -O2 -static */
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <vector>

using namespace std;

int sum(vector<vector<int> > r, int n) {
    int s = 0;
    for(int i = 0; i < n; ++i) {
        int ss = r[i].size();
        if(ss == 0) {
            s++;
        } else {
            s += ss;
        }
    }
    return s;
}

int main() {
    srand(time(NULL));
    int n;
    int p = 9999991;
    scanf("%d\n", &n);
    vector<int> l = vector<int>(n);
    vector<vector<int> > r;
    vector<vector<int> > t;
    long long a;
    do {
        r = vector<vector<int> >(n);
        t = vector<vector<int> >(n);
        a = (rand() % (p - 1)) + 1;
        for(int i = 0; i < n; ++i) {
            scanf("%d", &l[i]);
            long long k = ((a * l[i]) % p) % n;
            r[k].push_back(0);
            t[k].push_back(l[i]);
        }
    } while(sum(r, n) > 3 * n);
    printf("%d\n", n);
    for(vector<vector<int> >::iterator it = t.begin(); it != t.end(); ++it) {
        int res = (int)(*it).size();
        if(res == 0) {
            printf("%d ", 1);
        } else {
            printf("%d ", res);
        }
    }
    printf("\n%lld\n", a);
    vector<long long> rr = vector<long long>(n, 0);
    for(unsigned int i = 0; i < t.size(); ++i) {
        int yi = t[i].size();
        if(yi != 0) {
            int flag;
            vector<int> copy = r[i];
            do {
                flag = 0;
                long long ai = (rand() % (p - 1)) + 1;
                rr[i] = ai;
                for(unsigned int j = 0; j < t[i].size(); ++j) {
                    long long ki = ((ai * t[i][j]) % p) % yi;
                    if(r[i][ki] != 0) {
                        flag = 1;
                        r[i] = copy;
                        break;
                    }
                    r[i][ki] = t[i][j];
                }
            } while(flag == 1);
        }
    }
    for(vector<long long>::iterator it = rr.begin(); it != rr.end(); ++it) {
        printf("%lld ", (long long)*it);
    }
    printf("\n");
    return 0;
}
