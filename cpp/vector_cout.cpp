#include <vector>
#include <iostream>
#include <iterator>

int main()
{
    int a[] = {1,2,3,11,22,33,111,222,333};
    std::vector<int> vec(a,a+sizeof(a)/sizeof(*a));
    std::copy(vec.begin(), vec.end(), 
        std::ostream_iterator<int>(std::cout," "));
    return 0;
}
