#include <iostream>

int main()
{
    int complexArray[4][10][8][11][20][3];
    complexArray[3][9][5][10][15][2] = 5;
    std::cout <<  complexArray[3][9][5][10][15][2];
    
    return 0;
}
