%option yylineno

%{
#include "imp.tab.h"
#define RED     "\x1b[31m"
#define RESET   "\x1b[0m"
void clearAll();
void yyerror(char *errMessage){
	clearAll();
	printf(RED"Error --- "RESET"linia:%d\n"RED"      %s\n"RESET,yylineno,errMessage);
	exit(1);
}
void errorCreator(int errNo,char * var)
{
	
	char *buf;
	size_t sz;
	switch( errNo )
		{
		case 1:
		  	sz = snprintf(NULL, 0, "Ponowna deklaracja zmiennej: %s", var);
			buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Ponowna deklaracja zmiennej: %s", var);
		    break;
		    
		case 2:
		   	sz = snprintf(NULL, 0, "Niewłaściwa inicjalizacja zmiennej tablicowej: %s", var);
			buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Niewłaściwa inicjalizacja zmiennej tablicowej: %s", var);
		    break; 
		case -1:
			sz = snprintf(NULL, 0, "Użycie niezadeklarowanej zmiennej: %s", var);
			buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Użycie niezadeklarowanej zmiennej: %s",var);
		    break;  
		case -2:
			sz = snprintf(NULL, 0, "Niewłaściwe użycie zmiennej: %s", var);
			buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Niewłaściwe użycie zmiennej: %s",var);
		    break;
		case -3:
			sz = snprintf(NULL, 0, "Niewłaściwe użycie zmiennej tablicowej: %s", var);
			buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Niewłaściwe użycie zmiennej tablicowej: %s",var);
		    break;
		case -4:
			sz = snprintf(NULL, 0, "Niewłaściwe użycie zmiennej tablicowej(wartość spoza zakresu): %s", var);
			buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Niewłaściwe użycie zmiennej tablicowej(wartość spoza zakresu): %s",var);
		    break;
		case 100:
		   	sz = snprintf(NULL, 0, "Niewłaściwy znak: %s.", var);
		      buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Niewłaściwy znak: %s.", var);
		    break;
		case 101:
		   	sz = snprintf(NULL, 0, "Niewłaściwa nazwa zmiennej: %s.", var);
		      buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Niewłaściwa nazwa zmiennej: %s.", var);
		    break;
		case 102:
		   	sz = snprintf(NULL, 0, "Niewłaściwy znak: %s.", var);
		      buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Niewłaściwy znak: %s.", var);
		    break;
		case 103:
		   	sz = snprintf(NULL, 0, "Użycie niezainicjalizowanej zmiennej: %s.", var);
		      buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Użycie niezainicjalizowanej zmiennej: %s.", var);
		    break;
		case 666:
		   	sz = snprintf(NULL, 0, "Próba zmiany wartości zmiennej pętlowej: %s.", var);
		      buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Próba zmiany wartości zmiennej pętlowej: %s.", var);
		    break;		    
		    
		default:
		    sz = snprintf(NULL, 0, "Nieobsługiwany błąd: %s.", var);
		      buf = (char *)malloc(sz + 1);
			sz = snprintf(buf, sz+1, "Nieobsługiwany błąd: %s.", var);
		    break;
		}
	yyerror(buf); 
}

int yylex();

%}

%x COMMENT
NUMBER		[0-9]+
WHITESPACE		[ \t]+

%%
VAR			return VAR;
BEGIN 		return BEG;
END			return END;
IF 			return IF;
THEN 			return THEN;
ELSE 			return ELSE;
ENDIF			return ENDIF;
WHILE 		return WHILE;
DO 			return DO;
ENDWHILE		return ENDWHILE;
FOR 			return FOR;
FROM 			return FROM;
TO 			return TO;
DOWNTO 		return DOWNTO;
ENDFOR		return ENDFOR;
READ 			return READ;
WRITE			return WRITE;
SKIP			return SKIP;
":=" 			return ASSIGN;
"+" 			return ADD;
"\-" 			return SUB;
"*" 			return MUL;
"/" 			return DIV;
"%"			return MOD;
"=" 			return EQ;
"<>" 			return NE;
"<" 			return LT;
">" 			return GT;
"<=" 			return LE;
">="			return GE;
"["			return LB;
"]"			return RB;
";" 			return SEM;
{NUMBER}{WHITESPACE}?"+"{WHITESPACE}?{NUMBER}     {
			         char * n1;
			         char * n2;
			         n1 = malloc(strlen(yytext)*sizeof(char));
			         n2 = malloc(strlen(yytext)*sizeof(char));
			         unsigned long long i,j;
			         for(i=0;yytext[i]!='+';i++)
			         {
			        
			         	n1[i]=yytext[i];
			         }
			         n1[i] = '\0';
			         i++;
			         for(j=0;yytext[i+j]!='\0';j++)
			         {
			         n2[j] = yytext[i+j];
			         }
			         n2[j] = '\0';
			         yylval.number = atoi(n1) + atoi(n2); 
			         return NUMBER;
			         
				}
{NUMBER}{WHITESPACE}?"\-"{WHITESPACE}?{NUMBER}     {
			         char * n1;
			         char * n2;
			         n1 = malloc(strlen(yytext)*sizeof(char));
			         n2 = malloc(strlen(yytext)*sizeof(char));
			         unsigned long long i,j;
			         for(i=0;yytext[i]!='-';i++)
			         {
			        
			         	n1[i]=yytext[i];
			         }
			         n1[i] = '\0';
			         i++;
			         for(j=0;yytext[i+j]!='\0';j++)
			         {
			         n2[j] = yytext[i+j];
			         }
			         n2[j] = '\0';
			         
			         if(atoi(n1) < atoi(n2))
					   yylval.number=0;
					  
				   yylval.number = atoi(n1) - atoi(n2); 
			         return NUMBER;
			         
				}
{NUMBER}{WHITESPACE}?"*"{WHITESPACE}?{NUMBER}     {
			         char * n1;
			         char * n2;
			         n1 = malloc(strlen(yytext)*sizeof(char));
			         n2 = malloc(strlen(yytext)*sizeof(char));
			         unsigned long long i,j;
			         for(i=0;yytext[i]!='*';i++)
			         {
			        
			         	n1[i]=yytext[i];
			         }
			         n1[i] = '\0';
			         i++;
			         for(j=0;yytext[i+j]!='\0';j++)
			         {
			         n2[j] = yytext[i+j];
			         }
			         n2[j] = '\0';
			         yylval.number = atoi(n1) * atoi(n2); 
			         return NUMBER;
			         
				}
{NUMBER}{WHITESPACE}?"/"{WHITESPACE}?{NUMBER}     {
			         char * n1;
			         char * n2;
			         n1 = malloc(strlen(yytext)*sizeof(char));
			         n2 = malloc(strlen(yytext)*sizeof(char));
			         unsigned long long i,j;
			         for(i=0;yytext[i]!='+';i++)
			         {
			        
			         	n1[i]=yytext[i];
			         }
			         n1[i] = '\0';
			         i++;
			         for(j=0;yytext[i+j]!='\0';j++)
			         {
			         n2[j] = yytext[i+j];
			         }
			         n2[j] = '\0';
			         unsigned long long num1=atoi(n1);
			         unsigned long long num2=atoi(n2);
			         if((num1 == 0) || (num2 == 0) || (num1<num2))
			         {
			         	yylval.number = 0;
			         }
			         else 
			         {
			         yylval.number = num1/num2;
			         }
			         return NUMBER;
				}			
{NUMBER}{WHITESPACE}?"%"{WHITESPACE}?{NUMBER}     {
			         char * n1;
			         char * n2;
			         n1 = malloc(strlen(yytext)*sizeof(char));
			         n2 = malloc(strlen(yytext)*sizeof(char));
			         unsigned long long i,j;
			         for(i=0;yytext[i]!='%';i++)
			         {
			        
			         	n1[i]=yytext[i];
			         }
			         n1[i] = '\0';
			         i++;
			         for(j=0;yytext[i+j]!='\0';j++)
			         {
			         n2[j] = yytext[i+j];
			         }
			         n2[j] = '\0';
			         unsigned long long num1=atoi(n1);
			         unsigned long long num2=atoi(n2);
			         if((num1 == 0) || (num2 == 0))
			         {
			         	yylval.number = 0;
			         }
			         else if(num1<num2)
			         {
			         	yylval.number = num1;
			         }
			         else 
			         {
			         yylval.number = num1%num2;
			         }
			         return NUMBER;
			         
				}
[_a-z]+		{

				yylval.string=(char *)strdup(yytext);
				return ID;
			}
												
{NUMBER}		{
				yylval.number = atoi(yytext); 
				return NUMBER;
			}
[_a-zA-Z0-9]+	{
				errorCreator(101,yytext); 
			}

\{			BEGIN(COMMENT);
<COMMENT>[^\{\}]*
<COMMENT>\}		{
				BEGIN(INITIAL);
			}
<COMMENT>\{		{
				yyerror("Źle rozstawione nawiasy komentarza.");
			}
<COMMENT><<EOF>>	{
				yyerror("Źle rozstawione nawiasy. Brak nawiasu zamykającego.");
			}
\}			{
				yyerror("Źle rozstawione nawiasy komentarza."); 
			}
\n 			
{WHITESPACE}
.			{
				errorCreator(100,yytext); 
			}
%%

