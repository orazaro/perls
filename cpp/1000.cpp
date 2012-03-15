#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

int main()
{
    const int len = 3000;
    using namespace std;
    srandom(time(NULL));
    vector<int> vec(len);

    int max = 0;
    
    for(int k = 0; true; ++k) {
        for(int i = 0; i < len; ++i) {
            int j = random()%len;
            vec[j] += 1;
        }

        int ma = 0;
        for(int i = 0; i < len; ++i) {
            if(vec[i] > ma) ma = vec[i];
            vec[i] = 0;
        }
        if(ma > max) max = ma;
        cout << k <<". Max=" << max << " max=" << ma  << endl;
    }

    return 0;
}
