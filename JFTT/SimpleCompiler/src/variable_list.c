#include <string.h>
#ifndef VARIABLE_LIST
#define VARIABLE_LIST

typedef struct variable{
	char * name;
	int isTable;
	int size;
	int memStart;
	int rangeType;
	struct variable * next;
}variable;
int freeVarPointer=0;
int freeTabPointer=32;
variable * variableList = NULL;


	/**	0-delete all
	 */
void deleteLastVariable()
{
	if (variableList->memStart > 32) 
	{
		freeTabPointer = variableList->memStart;
	}
	else
	{
		freeVarPointer = variableList->memStart;
	}
	variable * var;
	var = variableList->next;
	memoryCells[(variableList->memStart)]=0;
	free(variableList->name);
	free(variableList);
	variableList = var;
}

void clearVariableList()
{	
	variable * var;
	while(variableList!=NULL)
	{
		var=variableList->next;
		free(variableList->name);
		free(variableList);
		variableList=var;
	}
}

int isInList(char * vName)
{
	variable * var;
	var = variableList;
	while(var!=NULL)
	{
		if(!strcmp(var->name,vName))
		{
			return 1;
		}
		var=var->next;
	}
	return 0;
}
/** 0-n nrKomórki
  * -1 -  nie znaleziono
  * -2 -  $(vName) nie jest tablicą
  * -3 -  $(vName) nie jest tablicą
  * -4    spoza zakresu tablicy
  */
int memoryCellNoEx(char * vName, int isTable, int cell)
{
	variable * var;
	var = variableList;
	while(var!=NULL)
	{
		if(!strcmp(var->name,vName))
		{
			if(var->isTable == 0 && isTable ==1)
			{
				return -2;
			}
			else if(var->isTable == 1 && isTable ==0)
			{
				return -3;
			}
			else 
			{
				if(cell>var->size)
					return -4;
				
				if(!memoryCells[var->memStart+cell])
					return -5;
					
				varDeep = var->rangeType;
				return var->memStart+cell;
			}
		}
		var=var->next;
	}
	return -1;
}

int memoryCellNo(char * vName, int isTable, int cell)
{	
	variable * var;
	var = variableList;
	while(var!=NULL)
	{
		if(!strcmp(var->name,vName))
		{
			if(var->isTable == 0 && isTable ==1)
			{
				return -2;
			}
			else if(var->isTable == 1 && isTable ==0)
			{
				return -3;
			}
			else 
			{
				if(cell>=var->size)
				{
					return -4;
				}
				varDeep = var->rangeType;
				return var->memStart+cell;
			}
		}
		var=var->next;
	}
	return -1;
}
	/**	 1 -poprawnie
	  *	-1 -zmienna już występuje	
	  */
int insertVariable( char * vName, int vIsTable,int vSize,int vRangeType)
{
	if(isInList(vName))
	{
		return 1;
	}
	variable * newVar = malloc(sizeof(variable));
	newVar->name = (char *)strdup(vName);
	newVar->isTable = vIsTable;
	newVar->size = vSize;
	if(variableList == NULL)
	{
		newVar->next = NULL;
	}
	else
	{
		newVar->next = variableList;
	}
	if(vIsTable)
	{
		newVar->memStart = freeTabPointer;
		freeTabPointer = freeTabPointer + vSize;
	}
	else
	{
		if(freeVarPointer <32)
		{
			newVar->memStart = freeVarPointer;
			freeVarPointer = freeVarPointer+1;
		}
		else
		{
			newVar->memStart = freeTabPointer;
			freeTabPointer = freeTabPointer+1;
		}
		
	}
	newVar->rangeType = vRangeType;
	variableList = newVar;
	memoryCells=realloc(memoryCells,(freeTabPointer+1)*sizeof(int));
	int i;
	for(i=variableList->memStart ; i< variableList->memStart+variableList->size ; i++)
	{
		memoryCells[i] = 0;
	}
	return 0;
}

void initAcc()
{
	insertVariable("acc0", 0, 1,0);
	insertVariable("acc1", 0, 1,0);
	insertVariable("acc2", 0, 1,0);
}

#endif
