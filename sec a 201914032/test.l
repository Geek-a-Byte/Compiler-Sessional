%option noyywrap

%{
#include<stdio.h>
int line_num=0;
%}

keyword ("printf"|"main"|"break"|"return"|"case"|"switch"|"if"|"else"|"for"|"int"|"float"|"double")
digit [0-9]
digits {digit}+
letter [a-zA-Z]
delim  [ \t\n]
ws     {delim}+
number {digits}(.{digits})?(E[+-]?{digits})?
id     ({letter}|_{letter})({letter}|{digits})*
paren  [{()}]
punc   [,;:]
inc    "++"
dec    "--"
logop  "&&"
comp   (>=|<=|==|>|<|!=)
oper   [\+\-\*\/\%]
assign [=]
literal (\".*\")


%%
{keyword}   {fprintf(yyout,"keyword %s\n",yytext);}
{digit}   	{fprintf(yyout,"digit %s\n",yytext);}
{number} 	{fprintf(yyout,"number %s\n",yytext);}
{id}     	{fprintf(yyout,"id %s\n",yytext);}
{paren}  	{fprintf(yyout,"paren %s\n",yytext);}
{punc}    	{fprintf(yyout,"punc %s\n",yytext);}
{oper}    	{fprintf(yyout,"oper %s\n",yytext);}
{logop}    	{fprintf(yyout,"logical oper %s\n",yytext);}
{assign}  	{fprintf(yyout,"assign %s\n",yytext);}
{comp}    	{fprintf(yyout,"comp %s\n",yytext);}
{inc}    	{fprintf(yyout,"inc %s\n",yytext);}
{dec}    	{fprintf(yyout,"dec %s\n",yytext);}
{literal}    	{fprintf(yyout,"literal %s\n",yytext);}
%%


int main(){
yyin=fopen("in.txt","r");
yyout=fopen("out.txt","w"); 
yylex();
fclose(yyin); 
fclose(yyout);
return 0;
}