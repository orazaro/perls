#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

int main()
{
    const int len = 1000;
    const int kreqs = 3;
    const int over = 5;
    using namespace std;
    srandom(time(NULL));
    vector<int> vec(len+over);

    int max = 0;
    
    for(int k = 0; true; ++k) {
        for(int i = 0; i < len*kreqs; ++i) {
            int j = random()%len;
            for(int o = 0; o < over; o++)
                vec[j+o] += 1;
        }

        int ma = 0, sum = 0; 
        for(int i = 0; i < len; ++i) {
            if(vec[i] > ma) ma = vec[i];
            sum += vec[i];
            vec[i] = 0;
        }
        double av = (double)sum / len;
        if(ma > max) max = ma;
        cout << k <<". Max=" << max << " max=" << ma << " av=" << av << endl;
    }

    return 0;
}
