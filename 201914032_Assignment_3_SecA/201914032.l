%option noyywrap

%{
#include <stdio.h>
int line_num=1;
%}

delim 		      [  \t]
newline           [\n]
ws                {delim}+
digit			  [0-9]
numbers           {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
letter            [A-Za-z]
var               ({letter}|[_])({letter}|{digit})*
arithmetic_op     [-+*%/]
assign_op         [=]
parentheses       [()]
curly_braces      [{}]
separator         [,;:]
literal           \".*\"
keyword           ("if"|"then"|"else"|"switch"|"case"|"while"|"for"|"int"|"break"|"default"|"main"|"printf")
relop             ("=="|"!="|"<"|"<="|">="|">"|"++"|"--")

%%

{ws}
{newline}      	{line_num++; fprintf(yyout,"\n\n",yytext);}
{parentheses}  	{fprintf(yyout,"<parenthesis , %s>,Line Number=%d\n",yytext,line_num);}
{curly_braces} 	{fprintf(yyout,"<Curly Bracket , %s>,Line Number=%d\n",yytext,line_num);}
{separator}    	{fprintf(yyout,"<Separator, %s>,Line Number=%d\n",yytext,line_num);}
{literal}      	{fprintf(yyout,"<literal, %s>,Line Number=%d\n",yytext,line_num);}
{assign_op}     {fprintf(yyout,"<Assignment Operator, %s>,Line Number=%d\n",yytext,line_num);}
{arithmetic_op} {fprintf(yyout,"<Arithmetic Operator, %s>,Line Number=%d\n",yytext,line_num);}
{keyword}       {fprintf(yyout,"<keyword, %s>,Line Number= %d\n",yytext,line_num);}
{relop}         {fprintf(yyout,"<Relational Operator, %s>,Line Number=%d\n",yytext,line_num);}
exit   		    {return 1;}
{var}			{fprintf(yyout,"<Identifier, %s>,Line Number=%d\n",yytext,line_num);}
"&&"         	{fprintf(yyout,"<Logical Operator, %s>,Line Number=%d\n",yytext,line_num);}
{numbers}  	    {fprintf(yyout,"<Number, %s>,Line Number=%d\n",yytext,line_num);}

%%

int main() {
yyin=fopen("input.txt","r");
yyout=fopen("output.txt","w");
yylex();
fprintf(yyout,"Total number of lines:%d", line_num);
}
