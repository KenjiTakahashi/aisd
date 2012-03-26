/* g++ -Wall -W -O2 -static */
#include <stdio.h>
#include <map>
#include <vector>

using namespace std;

int number[8] = {0, 1, 1, 2, 1, 2, 2, 3};
int tab[2][64];
map<int, vector<int> > hash;

void prepare_map() {
    vector<int> v;
    v.push_back(0);
    hash[58] = v;
    hash[27] = v;
    hash[54] = v;
    hash[26] = v;
    hash[50] = v;
    hash[52] = v;
    hash[25] = v;
    hash[56] = v;
    hash[24] = v;
    hash[48] = v;
    v.push_back(2);
    hash[23] = v;
    hash[21] = v;
    hash[19] = v;
    hash[22] = v;
    hash[7] = v;
    hash[18] = v;
    hash[17] = v;
    hash[20] = v;
    hash[5] = v;
    hash[16] = v;
    v.push_back(4);
    v.push_back(6);
    hash[6] = v;
    hash[4] = v;
    vector<int> v2;
    v2.push_back(0);
    v2.push_back(1);
    hash[11] = v2;
    hash[9] = v2;
    vector<int> v3(v2);
    v2.push_back(2);
    v2.push_back(3);
    hash[3] = v2;
    hash[1] = v2;
    v3.push_back(4);
    v3.push_back(5);
    hash[42] = v3;
    hash[34] = v3;
    hash[10] = v3;
    hash[8] = v3;
    hash[40] = v3;
    hash[32] = v3;
    v2.push_back(4);
    v2.push_back(5);
    v2.push_back(6);
    v2.push_back(7);
    hash[2] = v2;
    hash[0] = v2;
    vector<int> v4;
    v4.push_back(0);
    v4.push_back(4);
    hash[36] = v4;
    hash[38] = v4;
}

int main() {
    int n;
    scanf("%d\n", &n);
    prepare_map();
    for(int i = 1; i <= n; ++i) {
        char str[3];
        fgets(str, 5, stdin);
        int var = 0;
        if(str[0] == '.') {
            var += 1;
        }
        if(str[1] == '.') {
            var += 2;
        }
        if(str[2] == '.') {
            var += 4;
        }
        for(map<int, vector<int> >::const_iterator it = hash.begin(); it != hash.end(); ++it) {
            for(unsigned int j = 0; j < it->second.size(); ++j) {
                if((it->second[j] & var) == it->second[j]) {
                    int res = tab[(i - 1) % 2][it->first] + number[it->second[j]];
                    int address = (((it->first & 1) << 3) + ((it->first & 2) << 3) + ((it->first & 4) << 3)) | it->second[j];
                    if(tab[i % 2][address] < res) {
                        tab[i % 2][address] = res;
                    }
                }
            }
        }
    }
    int result = 0;
    for(int k = 0; k < 64; ++k) {
        if(tab[n % 2][k] > result) {
            result = tab[n % 2][k];
        }
    }
    printf("%d\n", result);
}
