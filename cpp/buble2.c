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
    const int n = 10;
    double a[n];
    int i = 0, m;
    char buf[BUFSIZ];

    while(fgets(buf,BUFSIZ,stdin))
    {
        a[i] = atoi(buf);
        if(++i >= n) break;
    }
    m = i;
    printa(a,m);
    buble(a,m);
    printa(a,m);
    return 0;
}

