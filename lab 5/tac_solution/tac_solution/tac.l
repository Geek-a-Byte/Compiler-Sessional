%option  noyywrap
%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "tac.tab.h"

void   yyerror(char*);
extern YYSTYPE yylval;
%}

DIGITS   [0-9]+
DOUBLE	 {DIGITS}(\.{DIGITS})?
NAME	 [a-zA-Z]
%%
[ \t]+ 	 { }
{DOUBLE} {
			strcpy(yylval.cvar,yytext);
			return DOUBLE;
		 }
[-+*/=]  {
		    return *yytext;
	     }
"(" 	 {
			return *yytext;
		 }
")" 	 {
			return *yytext;
		 }
{NAME} 	 {
			strcpy(yylval.cvar,yytext);
			return NAME;
		 }
\n 	     {
			return *yytext;
         }

exit     {
			return 0;
		 }
.        {
			char msg[25];
			sprintf(msg," <%s>","invalid character",yytext);
			yyerror(msg);
		 }
%%