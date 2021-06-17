%option noyywrap
%{ 
   #include<stdio.h>
   #include "201914032.tab.h"
%}

WS     [ \t]+
DIGITS [0-9]+
NUMBER {DIGITS}(\.{DIGITS})?



%%
{WS}     {}
[\n]     {return NEWLINE;}
{NUMBER} {sscanf(yytext,"%lf",&yylval);return NUMBER;}
"&"      {return BITWISEAND;}
\*\*     {return DSTERIK;}
\<\=     {return LEQUAL;}
\>\=     {return GEQUAL;}
\!\=     {return NEQUAL;}
\+       {return PLUS;}
\<\<     {return LSHIFT;}
\>\>     {return RSHIFT;}
\%       {return MOD;}
\-       {return MINUS;}
\*       {return MUL;}
\/       {return DIV;}
"("      {return LPAREN;}
")"      {return RPAREN;}
"exit"   {exit(0);}
.        {printf("unrecognized character.");}
%%