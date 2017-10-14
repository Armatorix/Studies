#ifndef JUMP_LIST
#define VARIABLE_LIST
#include "command_list.c"
#define RED     "\x1b[31m"
#define RESET   "\x1b[0m"
#define DEBUG_JFLAG 0
typedef struct jumper{
	int jumpNr;
	int commandNr;
	struct jumper * prev;
}jumper;

jumper * jumpList = NULL;


	/**	0-delete all
	 */
void deleteTopJumper()
{
	jumper * jump;
	if(jumpList!=NULL)
	{
		jump = jumpList->prev;
		free(jumpList);
		jumpList = jump;
	}
}

void clearJumpList()
{	
	jumper * jump;
	while(jumpList!=NULL)
	{
		jump=jumpList->prev;
		free(jumpList);
		jumpList=jump;
	}
}



	/**	 1 -poprawnie
	  *	-1 -zmienna już występuje	
	  */
void insertJumper( int commandNrr, int booster)
{
	jumper * newJump = malloc(sizeof(jumper));
	newJump->jumpNr = commandNrr+booster;
	newJump->commandNr =commandNrr;
	newJump->prev = jumpList;
	jumpList = newJump;
}

void increseAllJumps()
{
	jumper * jump;
	jump = jumpList;
	while(jump!=NULL)
	{
		jump->jumpNr++;
		jump = jump->prev;
	}
}

void setJumperVal()
{
	if(DEBUG_JFLAG)printf(""RED"%d %d "RESET,jumpList->commandNr,jumpList->jumpNr);
	if(!strcmp(commandList[jumpList->commandNr].command,"JUMP"))
	{
		commandList[jumpList->commandNr].arg1 = jumpList->jumpNr;
	}
	else
	{
		commandList[jumpList->commandNr].arg2 = jumpList->jumpNr;
	}
}

int getJumperStartVal()
{
	return jumpList->commandNr;
}

void flush(char * fileName)
{
	FILE *f = fopen(fileName, "w");
	if (f == NULL)
	{
	    printf("Error opening file!\n");
	    exit(1);
	}
	for (int i=0 ; i<commandNr ; i++)
	{
		if(!strcmp(commandList[i].command,"HALT"))
		{
			fprintf(f,"HALT\n");
		}
		else if((!strcmp(commandList[i].command,"JZERO")) || !strcmp(commandList[i].command,"JODD"))
		{
			fprintf(f,"%s %d %d\n",commandList[i].command,commandList[i].arg1,commandList[i].arg2);
		}
		else
		{
			fprintf(f,"%s %d\n",commandList[i].command,commandList[i].arg1);
		}
	}
	fclose(f);
}
#endif
