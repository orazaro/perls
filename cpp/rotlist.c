#include <stdio.h>

typedef struct list {
    int m;
    struct list *next;
} List;

List* rotlist(List* li)
{
    List *p,*p2;
    int n = 0,i,i2;
    for(p2 = li; p2; p2 = p2->next)
        n++;
    for(i2 = n-1; i2 > 0; i2--)
    for(p = li,i = 0; p && i < i2; p = p->next, i++)
    {
        int t = p->m;
        if(p->next) 
        {
            p->m = p->next->m;
            p->next->m = t;
        }
    }
        
    return li;
}

void printlist(List* li)
{
    List* p;
    printf("list: ");
    for(p = li; p ; p=p->next)
        printf("%d ", p->m);
    printf("\n");
}

int main()
{
    const int n = 7;
    List mylist[n];
    int i;
    for(i = 0; i < n; i++)
    {
        mylist[i].m = i+1;
        if(i < n - 1)
            mylist[i].next = &mylist[i+1];
        else
            mylist[i].next = NULL;
    }
    printlist(mylist);
    rotlist(mylist);
    printlist(mylist);

    return 0;
}
