#include <stdio.h>
#include "lfsr.c"
void myprint(short n, int k)
{
	if(k>0)
	{
		myprint(n/2, k-1);
		if(n%2) printf("1");
		else printf("0");
	}
	
}
int main(void)
{
  const short init = 0;
  short v = init;
  
  for(short i=0;i<=10;i++){
  for(short j=0;j<16;j++)
    v = shift_lfsr(v);
    printf("%16d :",v);
    myprint(v,16);
    printf("\n");
  }
}
