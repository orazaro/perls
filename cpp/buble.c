#include <stdio.h>
#include <stdlib.h>
#include <time.h>


void buble(double a[], int n)
{
    int i,j;
    for(i = 0; i < n; i++)
        for(j = i + 1; j < n; j++)
            if(a[i] > a[j]) {
                double tmp = a[i];
                a[i] = a[j];
                a[j] = tmp;
            }
}

void printa(double a[], int n)
{
    int i;
    printf("a:\n");
    for(i = 0; i < n; i++)
        printf("%lf\n",a[i]);
    printf("\n");
}

int main()
{
    const int n = 30;
    double a[n];
    int i;

    srandom(time(NULL));
    for(i = 0; i < n; i++)
    {
        a[i] = (double)random()/random();
    }
    printa(a,n);
    buble(a,n);
    printa(a,n);
    return 0;
}

