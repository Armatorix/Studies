%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
int * memoryCells;
int memoryCellsRange;
char * temp;
int varDeep=0;
int commandNr=1;
int inLoop=0;
#define DEBUG_FLAG 0
#include "variable_list.c"
#include "registers.c"
#include "jump_list.c"
#include "command_list.c"
#define RED     "\x1b[31m"
#define RESET   "\x1b[0m"


void yyerror(char * errMessage);
char *errorCreator(int errNo,char * var);
int yylex ();
void pushCommand(char * command);
void pushCommandWithArg(char * command, int arg);
void pushCommandWithArgs(char * command, int arg1,int arg2);
void clearAll();
void createNumInRegisterFORCE(unsigned long long num, int reg);
int isPowerOf2(unsigned long long num);


%}

%union {
	char * string;
	unsigned long long number;
	int reg;
}

%token <string> VAR BEG END
%token <string> IF THEN ELSE ENDIF
%token <string> WHILE DO ENDWHILE
%token <string> FOR FROM TO DOWNTO ENDFOR
%token <string> READ WRITE
%token <string> SKIP
%token <string> ASSIGN
%token <string> ADD SUB MUL DIV MOD
%token <string> EQ NE LT GT LE GE
%token <number> NUMBER 
%token <string> ID SEM LB RB
%%

program		: VAR vdeclarations BEG commands END  
				{
					pushCommand("HALT");
					clearAll();
				}
			;

vdeclarations 	: vdeclarations ID
				{
					if(DEBUG_FLAG){printf("\tdeklaracja %s\n",$<string>2);}
					if(insertVariable( $<string>2,0,1,0))
						errorCreator(1,$<string>2);
				}
            	| vdeclarations ID LB NUMBER RB
		         	{
		         		if(DEBUG_FLAG){printf("\tdeklaracja\n");}
		         		if(insertVariable($<string>2,1,$<number>4,0))
		         			errorCreator(1,$<string>2);
		         	}
            	| vdeclarations ID LB ID RB
		         	{
		         		if(DEBUG_FLAG){printf("\tdeklaracja\n");}
		         		errorCreator(2,$<string>2);
		      	}
		      |
		      ;

commands    	: commands command
		      | command
		      ;
command    		: identifier 
				{
					if(DEBUG_FLAG){printf("\tprzypisanie\n");}
					if(varDeep)
						errorCreator(666,temp);
				}
				ASSIGN expression SEM
				{
					pushCommandWithArg("COPY",$<reg>1);
					memoryCells[registers[$<reg>1].value]=1;
					pushCommandWithArg("STORE",$<reg>4);
					getRest($<reg>1);
					getRest($<reg>4);
				}
			| IF  condition 
				{
					if(DEBUG_FLAG){printf("\tinstrukcja warunkowa\n");}
					insertJumper(commandNr,1);
					pushCommandWithArg("JZERO",$<reg>2);
					getRest($<reg>2);
				}
				THEN commands ELSE
				{
					setJumperVal();
					deleteTopJumper();
					insertJumper(commandNr,0);
					pushCommand("JUMP");
				}
				commands ENDIF
				{
					setJumperVal();
					deleteTopJumper();
				}
			| WHILE 
				{
					inLoop=1;
					if(DEBUG_FLAG){printf("\tpętla while\n");}
					insertJumper(commandNr,0);
				}
				condition 
				{
					insertJumper(commandNr,1);
					pushCommandWithArg("JZERO", $<reg>3);
					getRest($<reg>3);
				}
				DO commands ENDWHILE
				{
					setJumperVal();
					deleteTopJumper();
					pushCommandWithArg("JUMP",getJumperStartVal());
					deleteTopJumper();
					inLoop=0;
				}
		  	| FOR ID FROM value TO value
		  		{
		  			inLoop=1;
		  			if(DEBUG_FLAG){printf("\tfor iton\n");}
		  			if(insertVariable( $<string>2,0,1,1))
						errorCreator(1,$<string>2);
					char * iterator;
					iterator = (char *)strdup($<string>2);
					iterator[0] -= 32; 
					insertVariable(iterator,0,1,1);
					
		  			int finder = memoryCellNo($<string>2, 0, 0);
		  			int finder2 = memoryCellNo(iterator, 0, 0);
		  			memoryCells[finder]=1;
		  			memoryCells[finder2]=1;
		  			pushCommandWithArg("ZERO",0);
		  			pushCommandWithArg("STORE", $<reg>4);
		  			pushCommandWithArg("INC", $<reg>6);
					pushCommandWithArg("SUB", $<reg>6);
					insertJumper(commandNr,0);
					pushCommandWithArg("JZERO",$<reg>6); //skok za pętle, zakres za mały
					createNumInRegisterFORCE(finder,0);
					pushCommandWithArg("STORE", $<reg>4);
					if((finder+1) != finder2)
						createNumInRegisterFORCE(finder2,0);
					else
						pushCommandWithArg("INC", 0);
					
					pushCommandWithArg("STORE", $<reg>6);
					getRest($<reg>4);
					getRest($<reg>6);
					insertJumper(commandNr,0);
		  			
		  		}
		  		DO commands ENDFOR
		  		{
		  			int reg = getFirstOffDuty();
		  			setToWork(reg);
		  			
		  			char * iterator;
					iterator = (char *)strdup($<string>2);
					iterator[0] -= 32;
					
		  			int finder = memoryCellNo($<string>2, 0, 0);
		  			int finder2 = memoryCellNo(iterator, 0, 0);
		  			
		  			createNumInRegisterFORCE(finder2,0);
		  			pushCommandWithArg("LOAD", reg);
		  			pushCommandWithArg("DEC", reg);
		  			insertJumper(commandNr,1);
		  			pushCommandWithArg("JZERO",reg); // skok za pętle
		  			pushCommandWithArg("STORE", reg);
		  			if((finder+1) != finder2)
						createNumInRegisterFORCE(finder,0);
					else
						pushCommandWithArg("DEC", 0);
					
					pushCommandWithArg("LOAD", reg);
		  			pushCommandWithArg("INC", reg);
		  			pushCommandWithArg("STORE", reg);
		  			setJumperVal();
		  			deleteTopJumper();
		  			pushCommandWithArg("JUMP", getJumperStartVal());
		  			deleteTopJumper();
		  			setJumperVal();
		  			deleteTopJumper();
		  			getRest(reg);
		  			deleteLastVariable();
		  			deleteLastVariable();
		  			inLoop=0;
		  		}
			| FOR ID FROM value DOWNTO value
		  		{
		  			inLoop=1;
		  			if(DEBUG_FLAG){printf("\tfor iton\n");}
		  			if(insertVariable( $<string>2,0,1,1))
						errorCreator(1,$<string>2);
					char * iterator;
					iterator = (char *)strdup($<string>2);
					iterator[0] -= 32; 
					insertVariable(iterator,0,1,1);
					
		  			int finder = memoryCellNo($<string>2, 0, 0);
		  			int finder2 = memoryCellNo(iterator, 0, 0);
		  			memoryCells[finder]=1;
		  			memoryCells[finder2]=1;
		  			pushCommandWithArg("ZERO",0);
		  			pushCommandWithArg("STORE", $<reg>6);
		  			pushCommandWithArg("INC",0);
		  			pushCommandWithArg("STORE", $<reg>4);
		  			pushCommandWithArg("ZERO",0);
		  			pushCommandWithArg("INC", $<reg>4);
					pushCommandWithArg("SUB", $<reg>4);
					insertJumper(commandNr,0);
					pushCommandWithArg("JZERO",$<reg>4); //skok za pętle, zakres za mały
					pushCommandWithArg("INC",0);
					pushCommandWithArg("LOAD", $<reg>6);
					
					createNumInRegisterFORCE(finder,0);
					pushCommandWithArg("STORE", $<reg>6);
					if((finder+1) != finder2)
						createNumInRegisterFORCE(finder2,0);
					else
						pushCommandWithArg("INC", 0);
					
					pushCommandWithArg("STORE", $<reg>4);
					getRest($<reg>4);
					getRest($<reg>6);
					insertJumper(commandNr,0);
		  			
		  		}
		  		DO commands ENDFOR
		  		{
		  			int reg = getFirstOffDuty();
		  			setToWork(reg);
		  			
		  			char * iterator;
					iterator = (char *)strdup($<string>2);
					iterator[0] -= 32;
					
		  			int finder = memoryCellNo($<string>2, 0, 0);
		  			int finder2 = memoryCellNo(iterator, 0, 0);
		  			
		  			createNumInRegisterFORCE(finder2,0);
		  			pushCommandWithArg("LOAD", reg);
		  			pushCommandWithArg("DEC", reg);
		  			insertJumper(commandNr,1);
		  			pushCommandWithArg("JZERO",reg); // skok za pętle
		  			pushCommandWithArg("STORE", reg);
		  			if((finder+1) != finder2)
						createNumInRegisterFORCE(finder,0);
					else
						pushCommandWithArg("DEC", 0);
					
					pushCommandWithArg("LOAD", reg);
		  			pushCommandWithArg("DEC", reg);
		  			pushCommandWithArg("STORE", reg);
		  			setJumperVal();
		  			deleteTopJumper();
		  			pushCommandWithArg("JUMP", getJumperStartVal());
		  			deleteTopJumper();
		  			setJumperVal();
		  			deleteTopJumper();
		  			getRest(reg);
		  			deleteLastVariable();
		  			deleteLastVariable();
		  			inLoop=0;
		  		}
			| READ identifier SEM
				{
					if(DEBUG_FLAG){printf("\tread\n");}
					if(varDeep)
						errorCreator(103,temp);
					
					int reg = getFirstOffDuty();
					setToWork(reg);
			  		pushCommandWithArg("GET",reg);
			  		pushCommandWithArg("COPY",$<reg>2);
			  		memoryCells[registers[$<reg>2].value]=1;
			  		pushCommandWithArg("STORE",reg);
			  		getRest(reg);
			  		getRest($<reg>2);
				}
		  	| WRITE value SEM
		  		{
		  			if(DEBUG_FLAG){printf("\twrite\n");}
		  			pushCommandWithArg("PUT",$<reg>2);
		  			getRest($<reg>2);
		  		}
		 	| SKIP SEM
		 	;
expression		: value
				{
					if(DEBUG_FLAG){printf("\twartość\n");}
					$<reg>$=$<reg>1;
				}
			| value_boost ADD value_boost
				{
					if(DEBUG_FLAG){printf("\tdodawanie\n");}
					createNumInRegisterFORCE(0,0);
					pushCommandWithArg("STORE",$<reg>1);
					getRest($<reg>1);
					pushCommandWithArg("ADD",$<reg>3);			
					$<reg>$=$<reg>3;
				}
			| NUMBER ADD value_boost
				{
					if(DEBUG_FLAG){printf("\tdodawanie\n");}
					if($<number>1<21)
					{
						for(int i=0;i<$<number>1;i++)
							pushCommandWithArg("INC",$<reg>3);
					}
					else
					{
						int reg = getFirstOffDuty();
						setToWork(reg);
						createNumInRegisterFORCE($<number>1,reg);
						createNumInRegisterFORCE(0,0);
						pushCommandWithArg("STORE",reg);
						pushCommandWithArg("ADD",$<reg>3);
						getRest(reg);
					}			
					$<reg>$=$<reg>3;
				}
			| value_boost ADD NUMBER
				{
					if(DEBUG_FLAG){printf("\tdodawanie\n");}
					if($<number>3<21)
					{
						for(int i=0;i<$<number>3;i++)
							pushCommandWithArg("INC",$<reg>1);
					}
					else
					{
						int reg = getFirstOffDuty();
						setToWork(reg);
						createNumInRegisterFORCE($<number>3,reg);
						createNumInRegisterFORCE(0,0);
						pushCommandWithArg("STORE",reg);
						pushCommandWithArg("ADD",$<reg>1);
						getRest(reg);
					}			
					$<reg>$=$<reg>1;
				}
			| value_boost SUB NUMBER
				{
					if(DEBUG_FLAG){printf("\tdodawanie\n");}
					if($<number>3<21)
					{
						for(int i=0;i<$<number>3;i++)
							pushCommandWithArg("DEC",$<reg>1);
					}
					else
					{
						int reg = getFirstOffDuty();
						setToWork(reg);
						createNumInRegisterFORCE($<number>3,reg);
						createNumInRegisterFORCE(0,0);
						pushCommandWithArg("STORE",reg);
						pushCommandWithArg("SUB",$<reg>1);
						getRest(reg);
					}			
					$<reg>$=$<reg>1;
				}
			| value_boost SUB value_boost
				{
					if(DEBUG_FLAG){printf("\todejmowanie\n");}
					createNumInRegisterFORCE(0,0);
					pushCommandWithArg("STORE",$<reg>3);
					getRest($<reg>3);
					pushCommandWithArg("SUB",$<reg>1);			
					$<reg>$=$<reg>1;
				}
			| NUMBER SUB value_boost
				{ //TODO:need optimalization
				
					if(DEBUG_FLAG){printf("\todejmowanie\n");}
					int reg = getFirstOffDuty();
					setToWork(reg);
					createNumInRegisterFORCE($<number>1,reg);
					createNumInRegisterFORCE(0,0);
					pushCommandWithArg("STORE",$<reg>3);
					getRest($<reg>3);
					pushCommandWithArg("SUB",reg);			
					$<reg>$=reg;
				}
			| value_boost MUL value_boost
				{
					if(DEBUG_FLAG){printf("\tmnożenie\n");}		
					int a = $<reg>1;
					int b = $<reg>3;
					int r1 = getFirstOffDuty();
					setToWork(r1);
					
					createNumInRegisterFORCE(0,0);
					pushCommandWithArg("STORE",a);
					pushCommandWithArg("LOAD",r1);
					pushCommandWithArg("STORE",b);
					pushCommandWithArg("SUB",r1);
					pushCommandWithArgs("JZERO", r1, commandNr+12);//druga wersja
					pushCommandWithArg("ZERO",r1); setRegister(0,0);
					pushCommandWithArgs("JZERO",b,commandNr+20);//wyskoczyć z pętli
					pushCommandWithArgs("JODD",b,commandNr+4);//skok do dodawania
					pushCommandWithArg("SHR",b);
					pushCommandWithArg("SHL",a);
					pushCommandWithArg("JUMP",commandNr-4);//na początek pętli
					pushCommandWithArg("STORE",a);
					pushCommandWithArg("ADD",r1);
					pushCommandWithArg("SHR",b);
					pushCommandWithArg("SHL",a);
					pushCommandWithArg("JUMP",commandNr-9);
					
					pushCommandWithArgs("JZERO",a,commandNr+10);//wyskoczyć z pętli
					pushCommandWithArgs("JODD",a,commandNr+4);//skok do dodawania
					pushCommandWithArg("SHR",a);
					pushCommandWithArg("SHL",b);
					pushCommandWithArg("JUMP",commandNr-4);//na początek pętli
					pushCommandWithArg("STORE",b);
					pushCommandWithArg("ADD",r1);
					pushCommandWithArg("SHR",a);
					pushCommandWithArg("SHL",b);
					pushCommandWithArg("JUMP",commandNr-9);
					
					getRest(a);
					getRest(b);
					$<reg>$ = r1;
					
				}
			| value_boost MUL NUMBER
				{
					if(DEBUG_FLAG){printf("\tmnożenie\n");}	
					int a = $<reg>1;
					unsigned long long b = $<number>3;
					
										
					if(b==0)
					{
						pushCommandWithArg("ZERO",a);
						$<reg>$=a;
					}
					else if(isPowerOf2(b))
					{
						unsigned long long iter=b;
						while(iter!=1)
						{
							pushCommandWithArg("SHL",a);
							iter=iter/2;
						}
						$<reg>$=a;
					}
					else
						{
						if(DEBUG_FLAG){printf("\twartość liczby =%llu \n",$<number>3);}
						int bReg = getFirstOffDuty();
						setToWork(bReg);
						createNumInRegisterFORCE(b, bReg);
						
						int r1 = getFirstOffDuty();
						setToWork(r1);
					
						createNumInRegisterFORCE(0,0);
						pushCommandWithArg("STORE",a);
						pushCommandWithArg("LOAD",r1);
						pushCommandWithArg("STORE",bReg);
						pushCommandWithArg("SUB",r1);
						pushCommandWithArgs("JZERO", r1, commandNr+12);//druga wersja
						pushCommandWithArg("ZERO",r1); setRegister(0,0);
						pushCommandWithArgs("JZERO",bReg,commandNr+20);//wyskoczyć z pętli
						pushCommandWithArgs("JODD",bReg,commandNr+4);//skok do dodawania
						pushCommandWithArg("SHR",bReg);
						pushCommandWithArg("SHL",a);
						pushCommandWithArg("JUMP",commandNr-4);//na początek pętli
						pushCommandWithArg("STORE",a);
						pushCommandWithArg("ADD",r1);
						pushCommandWithArg("SHR",bReg);
						pushCommandWithArg("SHL",a);
						pushCommandWithArg("JUMP",commandNr-9);
					
						pushCommandWithArgs("JZERO",a,commandNr+10);//wyskoczyć z pętli
						pushCommandWithArgs("JODD",a,commandNr+4);//skok do dodawania
						pushCommandWithArg("SHR",a);
						pushCommandWithArg("SHL",bReg);
						pushCommandWithArg("JUMP",commandNr-4);//na początek pętli
						pushCommandWithArg("STORE",bReg);
						pushCommandWithArg("ADD",r1);
						pushCommandWithArg("SHR",a);
						pushCommandWithArg("SHL",bReg);
						pushCommandWithArg("JUMP",commandNr-9);
					
						getRest(a);
						getRest(bReg);
						$<reg>$ = r1;
					}
					
				}
				
			| NUMBER MUL value_boost
				{
					if(DEBUG_FLAG){printf("\tmnożenie\n");}	
					int a = $<reg>3;
					unsigned long long b = $<number>1;
					
										
					if(b==0)
					{
						pushCommandWithArg("ZERO",a);
						$<reg>$=a;
					}
					else if(isPowerOf2(b))
					{
						unsigned long long iter=b;
						while(iter!=1)
						{
							pushCommandWithArg("SHL",a);
							iter=iter/2;
						}
						$<reg>$=a;
					}
					else
						{
						if(DEBUG_FLAG){printf("\twartość liczby =%llu \n",$<number>1);}
						int bReg = getFirstOffDuty();
						setToWork(bReg);
						createNumInRegisterFORCE(b, bReg);
						
						int r1 = getFirstOffDuty();
						setToWork(r1);
					
						createNumInRegisterFORCE(0,0);
						pushCommandWithArg("STORE",a);
						pushCommandWithArg("LOAD",r1);
						pushCommandWithArg("STORE",bReg);
						pushCommandWithArg("SUB",r1);
						pushCommandWithArgs("JZERO", r1, commandNr+12);//druga wersja
						pushCommandWithArg("ZERO",r1); setRegister(0,0);
						pushCommandWithArgs("JZERO",bReg,commandNr+20);//wyskoczyć z pętli
						pushCommandWithArgs("JODD",bReg,commandNr+4);//skok do dodawania
						pushCommandWithArg("SHR",bReg);
						pushCommandWithArg("SHL",a);
						pushCommandWithArg("JUMP",commandNr-4);//na początek pętli
						pushCommandWithArg("STORE",a);
						pushCommandWithArg("ADD",r1);
						pushCommandWithArg("SHR",bReg);
						pushCommandWithArg("SHL",a);
						pushCommandWithArg("JUMP",commandNr-9);
					
						pushCommandWithArgs("JZERO",a,commandNr+10);//wyskoczyć z pętli
						pushCommandWithArgs("JODD",a,commandNr+4);//skok do dodawania
						pushCommandWithArg("SHR",a);
						pushCommandWithArg("SHL",bReg);
						pushCommandWithArg("JUMP",commandNr-4);//na początek pętli
						pushCommandWithArg("STORE",bReg);
						pushCommandWithArg("ADD",r1);
						pushCommandWithArg("SHR",a);
						pushCommandWithArg("SHL",bReg);
						pushCommandWithArg("JUMP",commandNr-9);
					
						getRest(a);
						getRest(bReg);
						$<reg>$ = r1;
					}
					
				}
			| value_boost DIV value_boost
				{
					if(DEBUG_FLAG){printf("\tdzielenie\n");}
					int a = $<reg>1;
					int b = $<reg>3;
					
					int iter = getFirstBusy2Args(a,b);//mnożnik b, odejmuje od a 'iter' części b
					int sum = getFirstOffDuty();
					setToWork(sum);
					pushCommandWithArg("ZERO", sum);
					
					pushCommandWithArgs("JZERO", a, commandNr+61);//JUMP(K)   skok za pętle wynik 0
					pushCommandWithArgs("JZERO", b, commandNr+60);//JUMP(K)   skok za pętle wynik 0
					pushCommandWithArgs("JODD", b, commandNr+4);//JUMP(D)   skok do dzielenia
					pushCommandWithArg("SHR", a);
					pushCommandWithArg("SHR", b);
					pushCommandWithArg("JUMP",commandNr-3);//
					
					pushCommandWithArg("DEC", b);//(D)
					pushCommandWithArgs("JZERO",b, commandNr+51);//JUMP(K2)skok za pętle 
					pushCommandWithArg("INC",b);
					pushCommandWithArg("ZERO", 0);//zapisywanie wskaźnika do acc2
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", iter);
					pushCommandWithArg("ZERO", iter);
					pushCommandWithArg("INC", iter);//ustalamy iterator i=1
					pushCommandWithArg("ZERO", 0);
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapis a do acc1
					
					pushCommandWithArg("SHL", b);//(1)podwajamy b
					pushCommandWithArg("SHL", iter);//podwajamy iterator
					pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
					pushCommandWithArg("STORE", b);
					
					pushCommandWithArg("INC", a);//inkrementacja a  (czy jest mniejsze na pewno!)
					pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
					pushCommandWithArgs("JZERO", a, commandNr+9);//JUMP(2) przekroczenie b przez a
					pushCommandWithArg("DEC", a);//dekrementacja a 
					pushCommandWithArgs("JZERO", a, commandNr+25);//JUMP(K3) trzeba doliczyć reszte
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
					pushCommandWithArg("ZERO", 0);
					pushCommandWithArg("STORE", iter);//iterator do acc0
					pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
					pushCommandWithArg("JUMP", commandNr-14);//jump(1)
					
					pushCommandWithArg("INC", 0);//(2) wczytujemy a do rejestru
					pushCommandWithArg("LOAD", a);
					pushCommandWithArg("SHR", b);//(3) dp2 b
					pushCommandWithArg("SHR", iter);//  dp2 iter
					pushCommandWithArgs("JZERO", iter, commandNr+16);//JUMP(K4)  koniec zabawy, skok za pętle , iterator się skończył
					pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
					pushCommandWithArg("STORE", b);
					
					pushCommandWithArg("INC", a);//inkrementacja a
					pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
					pushCommandWithArgs("JZERO", a, commandNr-9);//JUMP(2)
					pushCommandWithArg("DEC", a);//dekrementacja a 
					pushCommandWithArgs("JZERO", a, commandNr+7);//JUMP(K3)  a jest zero skok za pętle
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
					pushCommandWithArg("ZERO", 0);
					pushCommandWithArg("STORE", iter);//iterator do acc0
					pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
					pushCommandWithArg("JUMP", commandNr-15);//JUMP(3)
					pushCommandWithArg("STORE", iter);//(K3)iterator do acc0 po tym jak się zrównało
					pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
					pushCommandWithArg("ZERO", 0);//(K4)przywracanie wskaźnika
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("LOAD", iter);
					pushCommandWithArg("JUMP",commandNr+4);//JUMP(K)
					pushCommandWithArg("ZERO",0);//(K2)zwracanie a
					pushCommandWithArg("STORE",a);
					pushCommandWithArg("LOAD",sum);
					//(K)
					getRest(a);//zwolnić rejestry a,b, wynik w sum, wskaźnik w iter
					getRest(b);
					$<reg>$ = sum;
				}
			| value_boost DIV NUMBER
				{
					if(DEBUG_FLAG){printf("\tdzielenie\n");}
					int a = $<reg>1;
					unsigned long long bVal = $<number>3;
					
					if(bVal==0)
					{
						pushCommandWithArg("ZERO",a);
						$<reg>$=a;
					}
					else if(isPowerOf2(bVal))
					{
						unsigned long long iter=bVal;
						while(iter!=1)
						{
							pushCommandWithArg("SHR",a);
							iter=iter/2;
						}
						$<reg>$=a;
					}
					else
					{
						int b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE(bVal,b);
					
						int iter = getFirstBusy2Args(a,b);//mnożnik b, odejmuje od a 'iter' części b
						int sum = getFirstOffDuty();
						setToWork(sum);
						pushCommandWithArg("ZERO", sum);
					
						pushCommandWithArgs("JZERO", a, commandNr+61);//JUMP(K)   skok za pętle wynik 0
						pushCommandWithArgs("JZERO", b, commandNr+60);//JUMP(K)   skok za pętle wynik 0
						pushCommandWithArgs("JODD", b, commandNr+4);//JUMP(D)   skok do dzielenia
						pushCommandWithArg("SHR", a);
						pushCommandWithArg("SHR", b);
						pushCommandWithArg("JUMP",commandNr-3);//
					
						pushCommandWithArg("DEC", b);//(D)
						pushCommandWithArgs("JZERO",b, commandNr+51);//JUMP(K2)skok za pętle 
						pushCommandWithArg("INC",b);
						pushCommandWithArg("ZERO", 0);//zapisywanie wskaźnika do acc2
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", iter);
						pushCommandWithArg("ZERO", iter);
						pushCommandWithArg("INC", iter);//ustalamy iterator i=1
						pushCommandWithArg("ZERO", 0);
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapis a do acc1
					
						pushCommandWithArg("SHL", b);//(1)podwajamy b
						pushCommandWithArg("SHL", iter);//podwajamy iterator
						pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
						pushCommandWithArg("STORE", b);
					
						pushCommandWithArg("INC", a);//inkrementacja a  (czy jest mniejsze na pewno!)
						pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
						pushCommandWithArgs("JZERO", a, commandNr+9);//JUMP(2) przekroczenie b przez a
						pushCommandWithArg("DEC", a);//dekrementacja a 
						pushCommandWithArgs("JZERO", a, commandNr+25);//JUMP(K3) trzeba doliczyć reszte
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
						pushCommandWithArg("ZERO", 0);
						pushCommandWithArg("STORE", iter);//iterator do acc0
						pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
						pushCommandWithArg("JUMP", commandNr-14);//jump(1)
					
						pushCommandWithArg("INC", 0);//(2) wczytujemy a do rejestru
						pushCommandWithArg("LOAD", a);
						pushCommandWithArg("SHR", b);//(3) dp2 b
						pushCommandWithArg("SHR", iter);//  dp2 iter
						pushCommandWithArgs("JZERO", iter, commandNr+16);//JUMP(K4)  koniec zabawy, skok za pętle , iterator się skończył
						pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
						pushCommandWithArg("STORE", b);
					
						pushCommandWithArg("INC", a);//inkrementacja a
						pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
						pushCommandWithArgs("JZERO", a, commandNr-9);//JUMP(2)
						pushCommandWithArg("DEC", a);//dekrementacja a 
						pushCommandWithArgs("JZERO", a, commandNr+7);//JUMP(K3)  a jest zero skok za pętle
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
						pushCommandWithArg("ZERO", 0);
						pushCommandWithArg("STORE", iter);//iterator do acc0
						pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
						pushCommandWithArg("JUMP", commandNr-15);//JUMP(3)
						pushCommandWithArg("STORE", iter);//(K3)iterator do acc0 po tym jak się zrównało
						pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
						pushCommandWithArg("ZERO", 0);//(K4)przywracanie wskaźnika
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("LOAD", iter);
						pushCommandWithArg("JUMP",commandNr+4);//JUMP(K)
						pushCommandWithArg("ZERO",0);//(K2)zwracanie a
						pushCommandWithArg("STORE",a);
						pushCommandWithArg("LOAD",sum);
						//(K)
						getRest(a);//zwolnić rejestry a,b, wynik w sum, wskaźnik w iter
						getRest(b);
						$<reg>$ = sum;
					}
				}
			| NUMBER DIV value_boost
				{
					if(DEBUG_FLAG){printf("\tdzielenie\n");}
					int b = $<reg>3;
					unsigned long long aVal = $<number>1;
					
					if(aVal==0)
					{
						pushCommandWithArg("ZERO",b);
						$<reg>$=b;
					}
					else
					{
						int a = getFirstOffDuty();
						setToWork(a);
						createNumInRegisterFORCE(aVal,a);
					
						int iter = getFirstBusy2Args(a,b);//mnożnik b, odejmuje od a 'iter' części b
						int sum = getFirstOffDuty();
						setToWork(sum);
						pushCommandWithArg("ZERO", sum);
					
						pushCommandWithArgs("JZERO", a, commandNr+61);//JUMP(K)   skok za pętle wynik 0
						pushCommandWithArgs("JZERO", b, commandNr+60);//JUMP(K)   skok za pętle wynik 0
						pushCommandWithArgs("JODD", b, commandNr+4);//JUMP(D)   skok do dzielenia
						pushCommandWithArg("SHR", a);
						pushCommandWithArg("SHR", b);
						pushCommandWithArg("JUMP",commandNr-3);//
					
						pushCommandWithArg("DEC", b);//(D)
						pushCommandWithArgs("JZERO",b, commandNr+51);//JUMP(K2)skok za pętle 
						pushCommandWithArg("INC",b);
						pushCommandWithArg("ZERO", 0);//zapisywanie wskaźnika do acc2
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", iter);
						pushCommandWithArg("ZERO", iter);
						pushCommandWithArg("INC", iter);//ustalamy iterator i=1
						pushCommandWithArg("ZERO", 0);
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapis a do acc1
					
						pushCommandWithArg("SHL", b);//(1)podwajamy b
						pushCommandWithArg("SHL", iter);//podwajamy iterator
						pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
						pushCommandWithArg("STORE", b);
					
						pushCommandWithArg("INC", a);//inkrementacja a  (czy jest mniejsze na pewno!)
						pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
						pushCommandWithArgs("JZERO", a, commandNr+9);//JUMP(2) przekroczenie b przez a
						pushCommandWithArg("DEC", a);//dekrementacja a 
						pushCommandWithArgs("JZERO", a, commandNr+25);//JUMP(K3) trzeba doliczyć reszte
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
						pushCommandWithArg("ZERO", 0);
						pushCommandWithArg("STORE", iter);//iterator do acc0
						pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
						pushCommandWithArg("JUMP", commandNr-14);//jump(1)
					
						pushCommandWithArg("INC", 0);//(2) wczytujemy a do rejestru
						pushCommandWithArg("LOAD", a);
						pushCommandWithArg("SHR", b);//(3) dp2 b
						pushCommandWithArg("SHR", iter);//  dp2 iter
						pushCommandWithArgs("JZERO", iter, commandNr+16);//JUMP(K4)  koniec zabawy, skok za pętle , iterator się skończył
						pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
						pushCommandWithArg("STORE", b);
					
						pushCommandWithArg("INC", a);//inkrementacja a
						pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
						pushCommandWithArgs("JZERO", a, commandNr-9);//JUMP(2)
						pushCommandWithArg("DEC", a);//dekrementacja a 
						pushCommandWithArgs("JZERO", a, commandNr+7);//JUMP(K3)  a jest zero skok za pętle
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
						pushCommandWithArg("ZERO", 0);
						pushCommandWithArg("STORE", iter);//iterator do acc0
						pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
						pushCommandWithArg("JUMP", commandNr-15);//JUMP(3)
						pushCommandWithArg("STORE", iter);//(K3)iterator do acc0 po tym jak się zrównało
						pushCommandWithArg("ADD", sum);//zwiększamy sumę o iterator
						pushCommandWithArg("ZERO", 0);//(K4)przywracanie wskaźnika
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("LOAD", iter);
						pushCommandWithArg("JUMP",commandNr+4);//JUMP(K)
						pushCommandWithArg("ZERO",0);//(K2)zwracanie a
						pushCommandWithArg("STORE",a);
						pushCommandWithArg("LOAD",sum);
						//(K)
						getRest(a);//zwolnić rejestry a,b, wynik w sum, wskaźnik w iter
						getRest(b);
						$<reg>$ = sum;
					}
				}
			| value_boost MOD value_boost
				{
					if(DEBUG_FLAG){printf("\tdzielenie\n");}
					int a = $<reg>1;
					int b = $<reg>3;
					
					int iter = getFirstOffDuty();
					setToWork(iter);
					
					pushCommandWithArgs("JZERO", a, commandNr+41);//JUMP(K)   TODO:skok za pętle wynik 0
					pushCommandWithArgs("JZERO", b, commandNr+40);//JUMP(K)   TODO:skok za pętle wynik 0
					pushCommandWithArg("DEC", b);
					pushCommandWithArgs("JZERO",b, commandNr+38);//JUMP(K)  // TODO:skok za pętle, wynik 0
					pushCommandWithArg("DEC", b);//(D)
					pushCommandWithArgs("JZERO",b, commandNr+35);//JUMP(K2)  // TODO:skok za pętle, wynik 0or1
					pushCommandWithArg("INC",b);
					pushCommandWithArg("INC",b);
					pushCommandWithArg("ZERO", iter);
					pushCommandWithArg("INC", iter);//ustalamy iterator i=1
					pushCommandWithArg("ZERO", 0);
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapis a do acc1
				
					pushCommandWithArg("SHL", b);//(1)podwajamy b
					pushCommandWithArg("SHL", iter);//podwajamy iterator
					pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
					pushCommandWithArg("STORE", b);
					
					pushCommandWithArg("INC", a);//inkrementacja a  (czy jest mniejsze na pewno!)
					pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
					pushCommandWithArgs("JZERO", a, commandNr+6);//JUMP(2) przekroczenie b przez a
					pushCommandWithArg("DEC", a);//dekrementacja a 
					pushCommandWithArgs("JZERO", a, commandNr+20);//JUMP(K) skok za pętle wynik 0
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
					pushCommandWithArg("JUMP", commandNr-11);//jump(1)
					
					pushCommandWithArg("INC", 0);//(2) wczytujemy a do rejestru
					pushCommandWithArg("LOAD", a);
					pushCommandWithArg("SHR", b);//(3) dp2 b
					pushCommandWithArg("SHR", iter);//  dp2 iter
					pushCommandWithArgs("JZERO", iter, commandNr+16);//JUMP(K3)  skończył sie iterator, wynik w a
					pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
					pushCommandWithArg("STORE", b);
					pushCommandWithArg("INC", a);//inkrementacja a
					pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
					pushCommandWithArgs("JZERO", a, commandNr-9);//JUMP(2)
					pushCommandWithArg("DEC", a);//dekrementacja a 
					pushCommandWithArgs("JZERO", a, commandNr+5);//JUMP(K)  a jest zero wynik 0
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
					pushCommandWithArg("JUMP", commandNr-12);//JUMP(3)
					pushCommandWithArgs("JODD",a,commandNr+3);//(K2)
					pushCommandWithArg("ZERO", a);//(K)
					pushCommandWithArg("JUMP",commandNr+3);//
					pushCommandWithArg("ZERO",a);//
					pushCommandWithArg("INC",a);//
					//(k3)
					getRest(iter);//zwolnić rejestry a,iter, wynik w a
					getRest(b);
					$<reg>$=a;
					
				}
			| value_boost MOD NUMBER
				{
					if(DEBUG_FLAG){printf("\tdzielenie\n");}
					int a = $<reg>1;
					unsigned long long bVal = $<number>3;
					if((bVal == 0) || (bVal == 1))
					{
						pushCommandWithArg("ZERO", a);
						$<reg>$=a;
					}
					else if(bVal == 2)
					{
						pushCommandWithArgs("JODD",a, commandNr+3);
						pushCommandWithArg("ZERO",a);
						pushCommandWithArg("JUMP",commandNr+3);
						pushCommandWithArg("ZERO",a);
						pushCommandWithArg("INC",a);
						$<reg>$=a;
					}
					else
						{
						int b = getFirstOffDuty();
						setToWork(b);
					
						int iter = getFirstOffDuty();
						setToWork(iter);
					
						pushCommandWithArgs("JZERO", a, commandNr+41);//JUMP(K)   TODO:skok za pętle wynik 0
						pushCommandWithArgs("JZERO", b, commandNr+40);//JUMP(K)   TODO:skok za pętle wynik 0
						pushCommandWithArg("DEC", b);
						pushCommandWithArgs("JZERO",b, commandNr+38);//JUMP(K)  // TODO:skok za pętle, wynik 0
						pushCommandWithArg("DEC", b);//(D)
						pushCommandWithArgs("JZERO",b, commandNr+35);//JUMP(K2)  // TODO:skok za pętle, wynik 0or1
						pushCommandWithArg("INC",b);
						pushCommandWithArg("INC",b);
						pushCommandWithArg("ZERO", iter);
						pushCommandWithArg("INC", iter);//ustalamy iterator i=1
						pushCommandWithArg("ZERO", 0);
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapis a do acc1
				
						pushCommandWithArg("SHL", b);//(1)podwajamy b
						pushCommandWithArg("SHL", iter);//podwajamy iterator
						pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
						pushCommandWithArg("STORE", b);
					
						pushCommandWithArg("INC", a);//inkrementacja a  (czy jest mniejsze na pewno!)
						pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
						pushCommandWithArgs("JZERO", a, commandNr+6);//JUMP(2) przekroczenie b przez a
						pushCommandWithArg("DEC", a);//dekrementacja a 
						pushCommandWithArgs("JZERO", a, commandNr+20);//JUMP(K) skok za pętle wynik 0
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
						pushCommandWithArg("JUMP", commandNr-11);//jump(1)
					
						pushCommandWithArg("INC", 0);//(2) wczytujemy a do rejestru
						pushCommandWithArg("LOAD", a);
						pushCommandWithArg("SHR", b);//(3) dp2 b
						pushCommandWithArg("SHR", iter);//  dp2 iter
						pushCommandWithArgs("JZERO", iter, commandNr+16);//JUMP(K3)  skończył sie iterator, wynik w a
						pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
						pushCommandWithArg("STORE", b);
						pushCommandWithArg("INC", a);//inkrementacja a
						pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
						pushCommandWithArgs("JZERO", a, commandNr-9);//JUMP(2)
						pushCommandWithArg("DEC", a);//dekrementacja a 
						pushCommandWithArgs("JZERO", a, commandNr+5);//JUMP(K)  a jest zero wynik 0
						pushCommandWithArg("INC", 0);
						pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
						pushCommandWithArg("JUMP", commandNr-12);//JUMP(3)
						pushCommandWithArgs("JODD",a,commandNr+3);//(K2)
						pushCommandWithArg("ZERO", a);//(K)
						pushCommandWithArg("JUMP",commandNr+3);//
						pushCommandWithArg("ZERO",a);//
						pushCommandWithArg("INC",a);//
						//(k3)
						getRest(iter);//zwolnić rejestry a,iter, wynik w a
						getRest(b);
						$<reg>$=a;
					}
				}
			| NUMBER MOD value_boost
				{
					if(DEBUG_FLAG){printf("\tdzielenie\n");}
					int a = getFirstOffDuty();
					setToWork(a);
					createNumInRegisterFORCE($<number>1,a);
					int b = $<reg>3;
					
					int iter = getFirstOffDuty();
					setToWork(iter);
					
					pushCommandWithArgs("JZERO", a, commandNr+41);//JUMP(K)   TODO:skok za pętle wynik 0
					pushCommandWithArgs("JZERO", b, commandNr+40);//JUMP(K)   TODO:skok za pętle wynik 0
					pushCommandWithArg("DEC", b);
					pushCommandWithArgs("JZERO",b, commandNr+38);//JUMP(K)  // TODO:skok za pętle, wynik 0
					pushCommandWithArg("DEC", b);//(D)
					pushCommandWithArgs("JZERO",b, commandNr+35);//JUMP(K2)  // TODO:skok za pętle, wynik 0or1
					pushCommandWithArg("INC",b);
					pushCommandWithArg("INC",b);
					pushCommandWithArg("ZERO", iter);
					pushCommandWithArg("INC", iter);//ustalamy iterator i=1
					pushCommandWithArg("ZERO", 0);
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapis a do acc1
				
					pushCommandWithArg("SHL", b);//(1)podwajamy b
					pushCommandWithArg("SHL", iter);//podwajamy iterator
					pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
					pushCommandWithArg("STORE", b);
					
					pushCommandWithArg("INC", a);//inkrementacja a  (czy jest mniejsze na pewno!)
					pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
					pushCommandWithArgs("JZERO", a, commandNr+6);//JUMP(2) przekroczenie b przez a
					pushCommandWithArg("DEC", a);//dekrementacja a 
					pushCommandWithArgs("JZERO", a, commandNr+20);//JUMP(K) skok za pętle wynik 0
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
					pushCommandWithArg("JUMP", commandNr-11);//jump(1)
					
					pushCommandWithArg("INC", 0);//(2) wczytujemy a do rejestru
					pushCommandWithArg("LOAD", a);
					pushCommandWithArg("SHR", b);//(3) dp2 b
					pushCommandWithArg("SHR", iter);//  dp2 iter
					pushCommandWithArgs("JZERO", iter, commandNr+16);//JUMP(K3)  skończył sie iterator, wynik w a
					pushCommandWithArg("ZERO", 0);//zapisujemy b do acc0
					pushCommandWithArg("STORE", b);
					pushCommandWithArg("INC", a);//inkrementacja a
					pushCommandWithArg("SUB", a);//a-b jest zero przechodzimy do wstecznego(2)
					pushCommandWithArgs("JZERO", a, commandNr-9);//JUMP(2)
					pushCommandWithArg("DEC", a);//dekrementacja a 
					pushCommandWithArgs("JZERO", a, commandNr+5);//JUMP(K)  a jest zero wynik 0
					pushCommandWithArg("INC", 0);
					pushCommandWithArg("STORE", a);//zapisujemy nowe a do acc1
					pushCommandWithArg("JUMP", commandNr-12);//JUMP(3)
					pushCommandWithArgs("JODD",a,commandNr+3);//(K2)
					pushCommandWithArg("ZERO", a);//(K)
					pushCommandWithArg("JUMP",commandNr+3);//
					pushCommandWithArg("ZERO",a);//
					pushCommandWithArg("INC",a);//
					//(k3)
					getRest(iter);//zwolnić rejestry a,iter, wynik w a
					getRest(b);
					$<reg>$=a;
				}
			| SUB value
				{
					errorCreator(102,"-");
				}
			;
//0 if false
condition   	: value_boost EQ value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					pushCommandWithArg("ZERO",0);
					pushCommandWithArg("INC",$<reg>3);
					pushCommandWithArg("STORE",$<reg>1);
					pushCommandWithArg("SUB",$<reg>3);
					pushCommandWithArgs("JZERO",$<reg>3,commandNr+6);
					pushCommandWithArg("DEC",$<reg>3);
					pushCommandWithArgs("JZERO",$<reg>3,commandNr+3);
					pushCommandWithArg("ZERO",$<reg>3);
					pushCommandWithArg("JUMP",commandNr+2);
					pushCommandWithArg("INC",$<reg>3);
					getRest($<reg>1);
					$<reg>$=$<reg>3;
				}
			| value_boost EQ NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					if($<number>3<20)
					{
						pushCommandWithArg("INC",$<reg>1);
						for(unsigned long long i=0 ; i<$<number>3; i++)
						{
							pushCommandWithArg("DEC",$<reg>1);
						}
						pushCommandWithArgs("JZERO",$<reg>1,commandNr+6);
						pushCommandWithArg("DEC",$<reg>1);
						pushCommandWithArgs("JZERO",$<reg>1,commandNr+3);
						pushCommandWithArg("ZERO",$<reg>1);
						pushCommandWithArg("JUMP",commandNr+2);
						pushCommandWithArg("INC",$<reg>1);
						$<reg>$=$<reg>1;
					}
					else
					{
						unsigned long long b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>3,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("INC",b);
						pushCommandWithArg("STORE",$<reg>1);
						pushCommandWithArg("SUB",b);
						pushCommandWithArgs("JZERO",b,commandNr+6);
						pushCommandWithArg("DEC",b);
						pushCommandWithArgs("JZERO",b,commandNr+3);
						pushCommandWithArg("ZERO",b);
						pushCommandWithArg("JUMP",commandNr+2);
						pushCommandWithArg("INC",b);
						getRest($<reg>1);
						$<reg>$=b;
					}
				}
			| NUMBER EQ value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					if($<number>1<20)
					{
						pushCommandWithArg("INC",$<reg>3);
						for(unsigned long long i=0 ; i<$<number>1; i++)
						{
							pushCommandWithArg("DEC",$<reg>3);
						}
						pushCommandWithArgs("JZERO",$<reg>3,commandNr+6);
						pushCommandWithArg("DEC",$<reg>3);
						pushCommandWithArgs("JZERO",$<reg>3,commandNr+3);
						pushCommandWithArg("ZERO",$<reg>3);
						pushCommandWithArg("JUMP",commandNr+2);
						pushCommandWithArg("INC",$<reg>3);
						$<reg>$=$<reg>3;
					}
					else
					{
						unsigned long long b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>1,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("INC",b);
						pushCommandWithArg("STORE",$<reg>3);
						pushCommandWithArg("SUB",b);
						pushCommandWithArgs("JZERO",b,commandNr+6);
						pushCommandWithArg("DEC",b);
						pushCommandWithArgs("JZERO",b,commandNr+3);
						pushCommandWithArg("ZERO",b);
						pushCommandWithArg("JUMP",commandNr+2);
						pushCommandWithArg("INC",b);
						getRest($<reg>3);
						$<reg>$=b;
					}
					
				}
				
			| NUMBER EQ NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					
					unsigned long long b = getFirstOffDuty();
						setToWork(b);
					pushCommandWithArg("ZERO",b);
					if($<number>1!=$<number>3)
					{
					
						pushCommandWithArg("INC",b);
					}
					$<reg>$=b;
				}
			| value_boost NE value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie ne\n");}
					pushCommandWithArg("ZERO",0);
					pushCommandWithArg("INC",$<reg>3);
					pushCommandWithArg("STORE",$<reg>1);
					pushCommandWithArg("SUB",$<reg>3);
					pushCommandWithArgs("JZERO",$<reg>3,commandNr+4);
					pushCommandWithArg("DEC",$<reg>3);
					pushCommandWithArgs("JZERO",$<reg>3,commandNr+3);
					pushCommandWithArg("JUMP",commandNr+2);
					pushCommandWithArg("INC",$<reg>3);
					getRest($<reg>1);
					$<reg>$=$<reg>3;
					
					
				}
			| value_boost NE NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie ne\n");}
					
					if($<number>3<20)
					{
						pushCommandWithArg("INC",$<reg>1);
						for(unsigned long long i=0 ; i<$<number>3; i++)
						{
							pushCommandWithArg("DEC",$<reg>1);
						}
						pushCommandWithArgs("JZERO",$<reg>1,commandNr+4);
						pushCommandWithArg("DEC",$<reg>1);
						pushCommandWithArgs("JZERO",$<reg>1,commandNr+3);
						pushCommandWithArg("JUMP",commandNr+2);
						pushCommandWithArg("INC",$<reg>1);
						$<reg>$=$<reg>1;
					}
					else
					{	
						unsigned long long b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>3,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("INC",b);
						pushCommandWithArg("STORE",1);
						pushCommandWithArg("SUB",b);
						pushCommandWithArgs("JZERO",b,commandNr+4);
						pushCommandWithArg("DEC",b);
						pushCommandWithArgs("JZERO",b,commandNr+3);
						pushCommandWithArg("JUMP",commandNr+2);
						pushCommandWithArg("INC",b);
						getRest($<reg>1);
						$<reg>$=b;
					}
					
				}
			| NUMBER NE value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie ne\n");}
					
					if($<number>1<20)
					{
						pushCommandWithArg("INC",$<reg>3);
						for(unsigned long long i=0 ; i<$<number>1; i++)
						{
							pushCommandWithArg("DEC",$<reg>3);
						}
						pushCommandWithArgs("JZERO",$<reg>3,commandNr+4);
						pushCommandWithArg("DEC",$<reg>3);
						pushCommandWithArgs("JZERO",$<reg>3,commandNr+3);
						pushCommandWithArg("JUMP",commandNr+2);
						pushCommandWithArg("INC",$<reg>3);
						$<reg>$=$<reg>3;
					}
					else
					{	
						unsigned long long b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>1,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("INC",b);
						pushCommandWithArg("STORE",1);
						pushCommandWithArg("SUB",b);
						pushCommandWithArgs("JZERO",b,commandNr+4);
						pushCommandWithArg("DEC",b);
						pushCommandWithArgs("JZERO",b,commandNr+3);
						pushCommandWithArg("JUMP",commandNr+2);
						pushCommandWithArg("INC",b);
						getRest($<reg>3);
						$<reg>$=b;
					}
					
				}
				
			| NUMBER NE NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					
					unsigned long long b = getFirstOffDuty();
						setToWork(b);
					pushCommandWithArg("ZERO",b);
					if($<number>1==$<number>3)
					{
					
						pushCommandWithArg("INC",b);
					}
					$<reg>$=b;
				}
			| value_boost LT value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					pushCommandWithArg("ZERO",0);
					pushCommandWithArg("STORE",$<reg>1);
					pushCommandWithArg("SUB",$<reg>3);
					getRest($<reg>1);
					$<reg>$=$<reg>3;
				}
			| value_boost LT NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					if($<number>3 < 20)
					{
						if($<number>3==0)
						{
							pushCommandWithArg("ZERO",$<reg>1);
							$<reg>$=$<reg>1;
						}
						else
						{
							pushCommandWithArg("INC",$<reg>1);
							for(unsigned long long i=0 ; i<$<number>3; i++)
							{
								pushCommandWithArg("DEC",$<reg>1);
							}
							pushCommandWithArgs("JZERO",$<reg>1,commandNr+3);
							pushCommandWithArg("ZERO",$<reg>1);
							pushCommandWithArg("JUMP",commandNr+2);
							pushCommandWithArg("INC",$<reg>1);
							$<reg>$=$<reg>1;
						}
					}
					else
					{
						int b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>3,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("STORE",$<reg>1);
						pushCommandWithArg("SUB",b);
						getRest($<reg>1);
						$<reg>$=b;
					}
				}
			| NUMBER LT value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					if($<number>1 < 20)
					{
						if($<number>1==0)
						{
							$<reg>$=$<reg>3;
						}
						else
						{
							for(unsigned long long i=0 ; i<$<number>1; i++)
							{
								pushCommandWithArg("DEC",$<reg>3);
							}
							$<reg>$=$<reg>3;
						}
					}
					else
					{
						int b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>1,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("STORE",b);
						pushCommandWithArg("SUB",$<reg>3);
						getRest(b);
						$<reg>$=$<reg>3;
					}
				}
			| NUMBER LT NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					
					unsigned long long b = getFirstOffDuty();
					setToWork(b);
					pushCommandWithArg("ZERO",b);
					if($<number>1 < $<number>3)
					{
					
						pushCommandWithArg("INC",b);
					}
					$<reg>$=b;
				}
			| value_boost GT value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie gt\n");}
					pushCommandWithArg("ZERO",0);
					pushCommandWithArg("STORE",$<reg>3);
					pushCommandWithArg("SUB",$<reg>1);
					getRest($<reg>3);
					$<reg>$=$<reg>1;
				}
			| NUMBER GT value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					if($<number>1 < 20)
					{
						if($<number>1==0)
						{
							pushCommandWithArg("ZERO",$<reg>3);
							$<reg>$=$<reg>3;
						}
						else
						{
							pushCommandWithArg("INC",$<reg>3);
							for(unsigned long long i=0 ; i<$<number>1; i++)
							{
								pushCommandWithArg("DEC",$<reg>3);
							}
							pushCommandWithArgs("JZERO",$<reg>3,commandNr+3);
							pushCommandWithArg("ZERO",$<reg>3);
							pushCommandWithArg("JUMP",commandNr+2);
							pushCommandWithArg("INC",$<reg>3);
							$<reg>$=$<reg>3;
						}
					}
					else
					{
						int b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>1,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("STORE",$<reg>3);
						pushCommandWithArg("SUB",b);
						getRest($<reg>3);
						$<reg>$=b;
					}
				}
			| value_boost GT NUMBER 
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					if($<number>3 < 20)
					{
						if($<number>3==0)
						{
							$<reg>$=$<reg>1;
						}
						else
						{
							for(unsigned long long i=0 ; i<$<number>3; i++)
							{
								pushCommandWithArg("DEC",$<reg>1);
							}
							$<reg>$=$<reg>1;
						}
					}
					else
					{
						int b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>3,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("STORE",b);
						pushCommandWithArg("SUB",$<reg>1);
						getRest(b);
						$<reg>$=$<reg>1;
					}
				}
			| NUMBER GT NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					
					unsigned long long b = getFirstOffDuty();
					setToWork(b);
					pushCommandWithArg("ZERO",b);
					if($<number>1 > $<number>3)
					{
						pushCommandWithArg("INC",b);
					}
					$<reg>$=b;
				}
			| value_boost LE value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					pushCommandWithArg("ZERO",0);
					pushCommandWithArg("INC",$<reg>3);
					pushCommandWithArg("STORE",$<reg>1);
					pushCommandWithArg("SUB",$<reg>3);
					getRest($<reg>1);
					$<reg>$=$<reg>3;
				}
			| value_boost LE NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					if($<number>3 < 20)
					{
						if($<number>3==0)
						{
							pushCommandWithArgs("JZERO",$<reg>1,commandNr+3);
							pushCommandWithArg("ZERO",$<reg>1);
							pushCommandWithArg("JUMP",commandNr+2);
							pushCommandWithArg("INC",$<reg>1);
							
						}
						else
						{
							for(unsigned long long i=0 ; i<$<number>3; i++)
							{
								pushCommandWithArg("DEC",$<reg>1);
							}
							pushCommandWithArgs("JZERO",$<reg>1,commandNr+3);
							pushCommandWithArg("ZERO",$<reg>1);
							pushCommandWithArg("JUMP",commandNr+2);
							pushCommandWithArg("INC",$<reg>1);
							$<reg>$=$<reg>1;
						}
					}
					else
					{
						int b = getFirstOffDuty(); 	
						setToWork(b);
						createNumInRegisterFORCE($<number>3+1,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("STORE",$<reg>1);
						pushCommandWithArg("SUB",b);
						getRest($<reg>1);
						$<reg>$=b;
					}
				}
			| NUMBER LE value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					if($<number>1 < 20)
					{
						if($<number>1==0)
						{
							pushCommandWithArg("INC",$<reg>3);
							$<reg>$ = $<reg>3;
						}
						else
						{
							pushCommandWithArg("INC",$<reg>3);
							for(unsigned long long i=0 ; i<$<number>1; i++)
							{
								pushCommandWithArg("DEC",$<reg>3);
							}
							$<reg>$=$<reg>3;
						}
					}
					else
					{
						int b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>1,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("STORE",b);
						pushCommandWithArg("INC",$<reg>3);
						pushCommandWithArg("SUB",$<reg>3);
						getRest(b);
						$<reg>$=$<reg>3;
					}
				}
			| NUMBER LE NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					
					unsigned long long b = getFirstOffDuty();
					setToWork(b);
					pushCommandWithArg("ZERO",b);
					if($<number>1 <= $<number>3)
					{
					
						pushCommandWithArg("INC",b);
					}
					$<reg>$=b;
				}
			| value_boost GE value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie gt\n");}
					pushCommandWithArg("ZERO",0);
					pushCommandWithArg("INC",$<reg>1);
					pushCommandWithArg("STORE",$<reg>3);
					pushCommandWithArg("SUB",$<reg>1);
					getRest($<reg>3);
					$<reg>$=$<reg>1;
				}
			| NUMBER GE value_boost
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					if($<number>1 < 20)
					{
						if($<number>1==0)
						{
							pushCommandWithArgs("JZERO",$<reg>3,commandNr+3);
							pushCommandWithArg("ZERO",$<reg>3);
							pushCommandWithArg("JUMP",commandNr+2);
							pushCommandWithArg("INC",$<reg>3);
							$<reg>$=$<reg>3;
						}
						else
						{
							for(unsigned long long i=0 ; i<$<number>1; i++)
							{
								pushCommandWithArg("DEC",$<reg>3);
							}
							pushCommandWithArgs("JZERO",$<reg>3,commandNr+3);
							pushCommandWithArg("ZERO",$<reg>3);
							pushCommandWithArg("JUMP",commandNr+2);
							pushCommandWithArg("INC",$<reg>3);
							$<reg>$=$<reg>3;
						}
					}
					else
					{
						int b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>1,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("INC",b);
						pushCommandWithArg("STORE",$<reg>3);
						pushCommandWithArg("SUB",b);
						getRest($<reg>3);
						$<reg>$=b;
					}
				}
			| value_boost GE NUMBER 
				{
					if(DEBUG_FLAG){printf("\tporównanie lt\n");}
					if(	$<number>3 < 20)
					{
						if($<number>3==0)
						{
							pushCommandWithArg("INC",$<reg>1);
							$<reg>$=$<reg>1;
						}
						else
						{
							pushCommandWithArg("INC",$<reg>1);
							for(unsigned long long i=0 ; i<$<number>3; i++)
							{
								pushCommandWithArg("DEC",$<reg>1);
							}
							$<reg>$=$<reg>1;
						}
					}
					else
					{
						int b = getFirstOffDuty();
						setToWork(b);
						createNumInRegisterFORCE($<number>3,b);
						pushCommandWithArg("ZERO",0);
						pushCommandWithArg("INC",$<reg>1);
						pushCommandWithArg("STORE",b);
						pushCommandWithArg("SUB",$<reg>1);
						getRest(b);
						$<reg>$=$<reg>1;
					}
				}
			| NUMBER GE NUMBER
				{
					if(DEBUG_FLAG){printf("\tporównanie eq\n");}
					
					unsigned long long b = getFirstOffDuty();
					setToWork(b);
					pushCommandWithArg("ZERO",b);
					if($<number>1 >= $<number>3)
					{
						pushCommandWithArg("INC",b);
					}
					$<reg>$=b;
				}
			;
value       	: NUMBER
				{
					if(DEBUG_FLAG){printf("\twartość liczby =%llu \n",$<number>1);}
					int reg = getFirstOffDuty();
					setToWork(reg);
					createNumInRegisterFORCE($<number>1, reg);
					$<reg>$ = reg;
				}
			| identifier
				{
					if(DEBUG_FLAG){printf("\twartosc zmiennej\n");}
					pushCommandWithArg("COPY",$<reg>1);
					if(!memoryCells[registers[$<reg>1].value])
						errorCreator(103,temp);
					
					pushCommandWithArg("LOAD",$<reg>1);
					$<reg>$=$<reg>1;
				}
			;
value_boost      	: identifier
				{
					if(DEBUG_FLAG){printf("\twartosc zmiennej\n");}
					pushCommandWithArg("COPY",$<reg>1);
					if(!memoryCells[registers[$<reg>1].value])
						errorCreator(103,temp);
					
					pushCommandWithArg("LOAD",$<reg>1);
					$<reg>$=$<reg>1;
				}
			;
identifier  	: ID
				{
					if(DEBUG_FLAG){printf("\tid zmiennej %s\n",$<string>1);}
					int finder = memoryCellNo($<string>1, 0, 0);
					if(finder < 0)
						errorCreator(finder,$<string>1);
						
						
					int reg = getFirstOffDuty();
					setToWork(reg);
					createNumInRegisterFORCE(finder,reg);
					temp = $<string>1;
					$<reg>$ = reg;
				}
			| ID LB ID RB
				{	
					if(DEBUG_FLAG){printf("\tid tab[id]\n");}
					temp = $<string>1;
					int finder = memoryCellNoEx($<string>3,0,0);
					if(finder <0 )
						errorCreator(finder,$<string>3);
					
					int finder2 = memoryCellNo($<string>1,1,0);
					if(finder2 < 0 )
						errorCreator(finder2,$<string>1);
					int reg1 = getFirstOffDuty();
					setToWork(reg1);
					createNumInRegisterFORCE(finder2, reg1);
					createNumInRegisterFORCE(finder, 0);
					pushCommandWithArg("ADD",reg1);
					$<reg>$ = reg1;
				}
			| ID LB NUMBER RB
				{
					if(DEBUG_FLAG){printf("\tid tab[num]\n");}
					temp = $<string>1;
					int finder = memoryCellNo($<string>1,1 ,$<number>3);
					if(finder < 0)
						errorCreator(finder,$<string>1);
				
					int reg = getFirstOffDuty();
					setToWork(reg);
					createNumInRegisterFORCE(finder,reg);
					$<reg>$ = reg;
				}
			;

%%	
void commandThings()
{
	increseAllJumps();
	commandNr++;
}
void pushCommand(char * command)
{	
	if(DEBUG_FLAG)printf("%s\n",command);
	putCommand(commandNr, command, 0, 0);
	commandThings();
}
void pushCommandWithArg(char * command, int arg)
{
	if(DEBUG_FLAG)printf("%s %d\n",command,arg);
	putCommand(commandNr, command, arg, 0);
	commandThings();
}

void pushCommandWithArgs(char * command, int arg1,int arg2)
{
	if(DEBUG_FLAG)printf("%s %d %d\n",command,arg1,arg2);
	putCommand(commandNr, command, arg1, arg2);
	commandThings();
}

int yywrap() { 
	return 1; 
} 
void clearAll()
{
	clearVariableList();
	clearJumpList();
	free(memoryCells);
	free(registers);
}

void createNumHelper(unsigned long long num, int reg)
{
	
	if(num!=0)
	{
		if(num==1)
		{
			pushCommandWithArg("INC",reg);
		}
		else
		{
			createNumHelper(num>>1,reg);
			pushCommandWithArg("SHL",reg);
			if(num%2)
			{
				pushCommandWithArg("INC",reg);
			}
		}
	}
}
void createNumInRegister(unsigned long long num, int reg)
{
	int i;
	if(reg==0)
	for (i=0; i<5 ; i++)
		if(registers[i].valuated)
			if(registers[i].value == num)
			{
				if( i == reg)
				{
					return;
				}
				else
				{
					pushCommandWithArg("COPY",i);
					setRegister(reg,num);
					return;
				}
			}
	if(registers[reg].valuated)
		{
		if(registers[reg].value == num)
			{
				setRegister(reg,num);
				return;
			}
		else if(registers[reg].value == num+1)
			{
				pushCommandWithArg("DEC",reg);
				setRegister(reg,num);
				return;
			}
		else if(registers[reg].value == num+2)
			{
				pushCommandWithArg("DEC",reg);
				pushCommandWithArg("DEC",reg);
				setRegister(reg,num);
				return;
			}
		else if(registers[reg].value == num-1)
			{
				pushCommandWithArg("INC",reg);
				setRegister(reg,num);
				return;
			}
		else if(registers[reg].value == num-2)
			{
				pushCommandWithArg("INC",reg);
				pushCommandWithArg("INC",reg);
				setRegister(reg,num);
				return;
			}
		}
	if(!registers[reg].valuated || registers[reg].value != 0)
	pushCommandWithArg("ZERO",reg);
	createNumHelper(num,reg);
	setRegister(reg,num);
}
void createNumInRegisterFORCE(unsigned long long num, int reg)
{
	//if(!inLoop)createNumInRegister(num,reg);
	pushCommandWithArg("ZERO",reg);
	createNumHelper(num,reg);
	setRegister(reg,num);
}

void initAll()
{
	commandNr = 0;
	initRegisters();
	initAcc();
}
int isPowerOf2(unsigned long long x)
{
	return (x & (x - 1)) == 0;
}
void reductCommands()
{
}
int main( int argc, char **argv )
{	
	if(argc != 2)
	{
		printf("Podaj nazwę pliku wynikowego.\n");
		exit(1);
	}
	
	initCommand(10000);
	initAll();
	yyparse();
	reductCommands();
	if(!DEBUG_FLAG)flush(argv[1]);
	//clearAll();
	return 0;
}	

