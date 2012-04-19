#include <stdio.h>
#include <stdint.h>

int main()
{
    printf("int=%u\n", sizeof(int));
    printf("uint32_t=%u\n", sizeof(uint32_t));
    printf("double=%u\n", sizeof(double));
    printf("float=%u\n", sizeof(float));

    return 0;
}
