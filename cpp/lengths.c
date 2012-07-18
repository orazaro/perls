#include <stdio.h>

int main(int argc, char* argv[])
{
   int i,s;
   s=0;
   char*p;
   for(i=1; i<argc;i++)
   {
      for (p=argv[i];*p;p++);
      s+=(p-argv[i]);
   }
 printf("%d\n",s);
 return 0;
}

