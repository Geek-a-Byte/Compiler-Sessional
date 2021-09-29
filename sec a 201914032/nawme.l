%option noyywrap

%{
#include<stdio.h>
int line_count=1;
%}

digit  [0-9]
letter [a-zA-Z]
iden  ({letter}|_)({digit}|{letter})*


%%

[\n]    {line_count++; fprintf(yyout,"\n");}
[ \t]+  {}
("&&"|"||") {fprintf(yyout,"<Logical Operator , %s> Line Number=%d\n",yytext,line_count);}
("<"|"<="|">="|">"|"=="|"!=") {fprintf(yyout,"<Relational Operator , %s> Line Number=%d\n",yytext,line_count);}
=       {fprintf(yyout,"<Assignment Operator , %s> Line Number=%d\n",yytext,line_count);}
"++"    {fprintf(yyout,"<Increment Operator , %s> Line Number=%d\n",yytext,line_count);}
"--"    {fprintf(yyout,"<Decrement Operator , %s> Line Number=%d\n",yytext,line_count);}
("+"|"-"|"*"|"%"|"/") {fprintf(yyout,"<Arithmatic Operator , %s> Line Number=%d\n",yytext,line_count);}
[0-9.E\-+0-9]* {fprintf(yyout,"<Number , %s> Line Number=%d\n",yytext,line_count);}
("if"|"else"|"switch"|"case"|"while"|"for"|"int"|"break"|"default"|"main"|"printf")  {fprintf(yyout,"<Keyword , %s> Line Number=%d\n",yytext,line_count);}
\{|\}  {fprintf(yyout,"<Curly , %s> Line Number=%d\n",yytext,line_count);}
\(|\)   {fprintf(yyout,"<Parentheses , %s> Line Number=%d\n",yytext,line_count);}
[,;:]   {fprintf(yyout,"<Separator , %s> Line Number=%d\n",yytext,line_count);}
\".*\"  {fprintf(yyout,"<Literal , %s> Line Number=%d\n",yytext,line_count);}
"//".*""  {fprintf(yyout,"<Comment , %s> Line Number=%d\n",yytext,line_count);}
"/*".*"*/" {fprintf(yyout,"<Comment , %s> Line Number=%d\n",yytext,line_count);}
{iden}  {fprintf(yyout,"<Identifier , %s> Line Number=%d\n",yytext,line_count);}



%%
int main(){
yyin = fopen("in.txt","r");
yyout = fopen("output.txt","w");

yylex();
line_count--;
fprintf(yyout,"\nTotal number of lines: %d", line_count);
}
