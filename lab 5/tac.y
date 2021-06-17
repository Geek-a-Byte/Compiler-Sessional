%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int yylex(void);
int t_count = 1;
char * str;


void yyerror(char *s)
{
	fprintf(stderr,"%s\n",s);
	return;
}

char* getTemp(int i)
{
    // write your code
}



%}

%union { char cvar[5]; }
%token <cvar> DOUBLE
%token <cvar> NAME
%token '\n'

%type <cvar> expr
%type <cvar> term

%right '='
%left '+' '-'
%left '*' 
%left '/'
%left '(' ')'


%%
program:
	line program			{
								
							}
	| line					{
								
							}
	;
line:
	expr 	'\n' 		    {	
								t_count =1;	
								printf("\t\n",$1);
							}
	| NAME '=' expr '\n' 	{				
								t_count-=1;
								str = getTemp(t_count);
								strcpy($3,str);
								printf("%s = %s\n",$1,$3);
								t_count=1;
								
								
							}
	;
expr:
	expr '+' expr 			{ 
								// write your code
								

							}
	| expr '-' expr 		{ 
	
								// write your code
								
								
							}
	
	| expr '*' expr 		{ 
								// write your code
							}
	| expr '/' expr 		{ 
								// write your code
								
							}
	| term 				    { 				
								// write your code
								
							}
	| '(' expr ')' 			{
								// write your code
								
								
							}
	;
term:
	
	NAME 					{ 
								
								// write your code
								
							}
	| DOUBLE 				{ 	
								// write your code
							}
	;
%%


int main(void)
{
	yyparse();
	return 0;
}