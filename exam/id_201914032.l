%option noyywrap


%{
#include<stdio.h>
%}

DIGIT [0-9]
DIGITS {DIGIT}+
LETTER [a-zA-Z]
ID {LETTER}({LETTER}|{DIGIT})*
E-MAIL {ID}"@"{ID}("\.com")
PHONE  (("+880"){DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}|("01"){DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT})
DATE   ({DIGIT}{DIGIT}"/"{DIGIT}{DIGIT}"/"{DIGIT}{DIGIT}{DIGIT}{DIGIT})
NAME   ({ID}" "{ID}" "{ID}|{ID}|{ID}" "{ID})
MORNING {DIGIT}{DIGIT}":"{DIGIT}{DIGIT}" ""AM"|{DIGIT}{DIGIT}":"{DIGIT}{DIGIT}":"{DIGIT}{DIGIT}" ""AM"
EVENING {DIGIT}{DIGIT}":"{DIGIT}{DIGIT}" ""PM"|{DIGIT}{DIGIT}":"{DIGIT}{DIGIT}":"{DIGIT}{DIGIT}" ""PM"

%%
{E-MAIL}  {fprintf(yyout,"<E-MAIL,%s>",yytext);}
{PHONE}  {fprintf(yyout,"<PHONE,%s>",yytext);}
{DATE}  {fprintf(yyout,"<DATE,%s>",yytext);}
{NAME}  {fprintf(yyout,"<NAME,%s>",yytext);}
{MORNING}  {fprintf(yyout,"<MORNING,%s>",yytext);}
{EVENING}  {fprintf(yyout,"<EVENING,%s>",yytext);}
%%


int main(){
yyin=fopen("in.txt","r");
yyout=fopen("out.txt","w");
yylex();
fclose(yyin);
fclose(yyout);
}
