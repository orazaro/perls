/* create and destroy big dictionary (test) */
#include <iostream>
#include <map>
#include <string>
#include <vector>
#include <cstdlib>

void make_big_dic(
    std::map< std::string, long >& dic,
    size_t size)
{
    std::string letters = std::string("aaaaaaaa");
    int len = letters.size();
    for(size_t i = 0; i < size; i++)
    {
        dic[letters] = i;
        //std::cerr << letters << std::endl;
        for(size_t j = len - 1; j > 0 ; j--)
            if(letters[j] < 'z') 
            {
                letters[j] += 1;
                break;
            }
            else
                letters[j] = 'a';
    }
}


int main(int argc, char* argv[])
{
    using namespace std;
    size_t size = 1000000;
    if(argc > 1) size = atol(argv[1]);
    std::map< std::string, long > dic;
    std::cerr << "filling dic...";
    make_big_dic(dic, size);
    std::cerr << "ok" << std::endl;
    return 0;
}
