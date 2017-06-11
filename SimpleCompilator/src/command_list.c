#ifndef COMMAND_LIST
#define COMMAND_LIST

typedef struct command
{
	char * command;
	int arg1;
	int arg2;
	
}command;

command * commandList;
void putCommand(int comNo, char * comTxt, int arg1, int arg2)
{
	commandList[comNo].arg1 = arg1;
	commandList[comNo].arg2 = arg2;
	commandList[comNo].command = (char *)strdup(comTxt);
}
void initCommand(int no)
{
	commandList = malloc(no * sizeof(command));
}

#endif
