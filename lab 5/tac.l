%option noyywrap
%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "tac.tab.h"

void yyerror(char*);
extern YYSTYPE yylval;


%}

DIGITS  [0-9]+
DOUBLE	{DIGITS}(\.{DIGITS})?
NAME	[a-zA-Z]

%%
[ \t]+ 	 { }
{DOUBLE} {
			// write your code
		 }
[-+*/=]  {
		    // write your code
	     }
'('		 {
			// write your code
		 }
')'		 {
			// write your code
		 }
{NAME} 	 {
			// write your code
		 }
\n 	     {
			return *yytext;
		 }	 

exit     {
			return 0;
		 }
.        {
			char msg[25]; // fprintf
			sprintf(msg," <%s>","invalid character",yytext);
			yyerror(msg);
		 }
%%