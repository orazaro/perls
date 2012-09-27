#include <stdio.h>
int main(void)
{
    int i;
    int array[5];
    for(i = -1; i > -6; i--)
        array[i] = i*-1;
    for(i = -1; i > -6; i--)
        printf("%d\n",array[i]);
}
