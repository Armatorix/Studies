#include <string.h>
#ifndef REGISTERS
#define REGISTERS
typedef struct registerCell{
	int isSet;
	int valuated;
	unsigned long long value;
}registerCell;

registerCell * registers = NULL;
void initRegisters()
{
	registers = malloc(5*sizeof(registerCell));
	for (int i=0 ; i<5 ; i++)
	{
		registers[i].isSet = 0;
		registers[i].value = 0;
		registers[i].value = 0;
	}
}
void setRegister(int no, unsigned long long val)
{
	registers[no].value = val;
	registers[no].valuated=1;
}
int getFirstOffDuty()
{
	for(int i = 1; i<5 ; i++)
	{
		if(!registers[i].isSet)
		{
			return i;
		}
	}
	return -1;
}
int getFirstBusy2Args(int num1, int num2)
{
	for(int i = 1; i<5 ; i++)
	{
		if((registers[i].isSet) && (i!=num1) && (i!=num1))
		{
			return i;
		}
	}
	return -1;
}
void setToWork(int i)
{
	registers[i].isSet = 1;
}
void getRest(int reg)
{
	registers[reg].isSet=0;
}
#endif
