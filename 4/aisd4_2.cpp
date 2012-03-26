/* g++ -Wall -W -O2 -static */
#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;

void insert(int *w, int v, int a, int m) {
    v += m;
    w[v] = a;
    while(v != 1) {
        v /= 2;
        if(w[v * 2] >= w[v * 2 + 1]) {
            w[v] = w[v * 2];
        } else {
            w[v] = w[v * 2 + 1];
        }
    }
}
 
int query(int *w, int a, int b, int m) {
    int wyn;
    a += m;
    b += m;
    int wyn1 = w[a];
    int wyn2 = w[b];
    wyn = w[a];
    if(a != b) {
        wyn = w[b];
    }
    //if(w[a] > w[b]) {
    //    wyn = w[a];
    //} else {
    //    wyn = w[b];
    //}
    while(a / 2 != b / 2) {
        if(a % 2 == 0 && w[a + 1] > wyn) {
            wyn = w[a + 1];
        }
        if(b % 2 == 1 && w[b - 1] > wyn) {
            wyn = w[b - 1];
        }
        a /= 2;
        b /= 2;
    }
    return wyn;
}

int main() {
    int n;
    scanf("%d\n", &n);
    for(int i = 0; i < n; ++i) {
        int nn;
        scanf("%d\n", &nn);
        int a[500000];
        int s[500000];
        int e[500000];
        vector<int> sorted;
        for(int j = 0; j < nn; ++j) {
            scanf("%d", &a[j]);
        }
        e[0] = 1;
        s[nn - 1] = 1;
        for(int j = 0, k = nn - 1; j < nn; ++j, --k) {
            e[j + 1] = 1;
            s[k - 1] = 1;
            if(a[j] < a[j + 1]) {
                e[j + 1] += e[j];
            }
            if(a[k - 1] < a[k]) {
                s[k - 1] += s[k];
            }
            sorted.push_back(a[j]);
        }
        sort(sorted.begin(), sorted.end());
        vector<int>::iterator it = unique(sorted.begin(), sorted.end());
        sorted.resize(it - sorted.begin());
        int result = 1;
        int l = sorted.size();
        int *t = new int[2 * l]();
        for(int j = 0; j < nn; ++j) {
            int index = distance(sorted.begin(),
                    lower_bound(sorted.begin(), sorted.end(), a[j]));
            if(index > 0) {
                int presult = query(t, 0, index - 1, l) + s[j];
                if(presult > result) {
                    result = presult;
                }
            }
            insert(t, index, e[j], l);
        }
        printf("%d\n", result);
        delete [] t;
    }
    return 0;
}
