/* g++ -Wall -W -O2 -static */
#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;

int doMagic(vector<int> array, unsigned int k) {
    if(array.size() <= 10) {
        sort(array.begin(), array.end());
        return array[k];
    } else {
        vector<int> med;
        unsigned int i;
        for(i = 0; i + 5 <= array.size(); i += 5) {
            sort(array.begin() + i, array.begin() + i + 5);
            med.push_back(*(array.begin() + i + 2));
        }
        sort(array.begin() + i, array.end());
        switch(array.size() % 5) {
            case 1:
                med.push_back(array[array.size() - 1]);
                break;
            case 2:
                med.push_back(array[array.size() - 2]);
                break;
            case 3:
                med.push_back(array[array.size() - 2]);
                break;
            case 4:
                med.push_back(array[array.size() - 2]);
                break;
            default:
                break;
        }
        int m = doMagic(med, med.size() / 2);
        vector<int> maxim;
        int equal = 0;
        vector<int> minim;
        for(vector<int>::iterator i = array.begin(); i != array.end(); ++i) {
            if(*i > m) {
                maxim.push_back(*i);
            } else if(*i == m) {
                equal++;
            } else {
                minim.push_back(*i);
            }
        }
        if(minim.size() >= k + 1) {
            return doMagic(minim, k);
        } else if(minim.size() + equal >= k + 1) {
            return m;
        } else {
            return doMagic(maxim, k - minim.size() - equal);
        }
    }
}

int main() {
    int n;
    unsigned int k;
    scanf("%d %d\n", &n, &k);
    vector<int> array(n);
    for(int i = 0; i < n; ++i) {
        scanf("%d", &array[i]);
    }
    printf("%d\n", doMagic(array, k - 1));
    return 0;
}
