%option noyywrap

%{
#include <stdio.h>
 	
int line_idx = 1;
%}

delim 			[ \t]
ws 				{delim}+
digit 			[0-9]
digits 			{digit}+
number 			{digits}(\.{digits})?(E[+-]?{digits})?
seperator 		      [,|;|:]
alphanumeric 	     [_a-zA-Z]
identifier 		{alphanumeric}({alphanumeric}|{digit})*
parentheses 	     [(|)]
curly_braces 	     [{|}]
keyword   ("int"|"main"|"while"|"printf"|"scanf"|"for"|"if"|"break")
incrop 			 "++"
relop 			 ("<="|">="|"=="|>|<)
addrop 			 [&]
arithop 		      [+|-|%|/]
assign 			 [=]
newline 		      [\n]
comment 		      ("//")(.*)
literal                \".*\"


%%
{assign}      	{fprintf(yyout,"<Assignment Operator, %s>, Line Number=%d\n",yytext,line_idx);}

{literal}      	{fprintf(yyout,"<literal, %s>, Line Number=%d\n",yytext,line_idx);}
{comment} 		{fprintf(yyout,"<comment, %s>, Line Number= %d\n",yytext,line_idx);}
{parentheses}  	{fprintf(yyout,"<parenthesis , %s>, Line Number=%d\n",yytext,line_idx);}
{keyword} 		{fprintf(yyout,"<keyword, %s>, Line Number= %d\n",yytext,line_idx);}
{identifier} 	{fprintf(yyout,"<identifier, %s>, Line Number= %d\n",yytext,line_idx);}
{number} 		{fprintf(yyout,"<Number, %s>, Line Number= %d\n",yytext,line_idx);}
{incrop} 		{fprintf(yyout,"<Increment Operator, %s>, Line Number= %d\n",yytext,line_idx);}
{relop} 		{fprintf(yyout,"<Relational Operator, %s>, Line Number= %d\n",yytext,line_idx);}
{addrop} 		{fprintf(yyout,"<Address Operator, %s>, Line Number= %d\n",yytext,line_idx);}
{arithop} 		{fprintf(yyout,"<Arithmatic Operator, %s>, Line Number= %d\n",yytext,line_idx);}
{curly_braces} 	{fprintf(yyout,"<Curly Bracket, %s>, Line Number= %d\n",yytext,line_idx);}
{seperator} 	{fprintf(yyout,"<Seperator , %s>, Line Number= %d\n",yytext,line_idx);}
{newline} 		{fprintf(yyout,"   newline starts-------\n\n------newline ends\n");line_idx++;}
{ws} 			{fprintf(yyout,"<whitespace, __%s__>, Line Number= %d\n",yytext,line_idx);}

%%

int main()
{
	yyin = fopen("input.txt" , "r");
	yyout = fopen("out.txt" , "w");
	yylex();
	//fprintf(yyout,"OK inside main function\n");
}