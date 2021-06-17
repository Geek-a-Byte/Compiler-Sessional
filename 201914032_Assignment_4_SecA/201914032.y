%{
    #include<stdio.h>
    #include<math.h>
    #define YYSTYPE double
    int yylex();
    FILE *yyin,*yyout;
    int yyerror(const char *s)
    {
        fprintf(yyout,"%s\n",s);
    }
%}


%token NEWLINE NUMBER LPAREN RPAREN
%left  BITWISEAND
%left  NEQUAL
%left  LEQUAL GEQUAL
%left  LSHIFT RSHIFT
%right PLUS MINUS
%left  MUL DIV MOD
%left  DSTERIK



%%
stmt: line|stmt line;
line: expr NEWLINE        {fprintf(yyout,"=%lf\n",$1);};
expr: PLUS PLUS expr      {$$=$3+1;}
| expr  PLUS expr         {$$=$1+$3;}
| expr  PLUS PLUS         {$$=$1;}
| expr  MINUS MINUS       {$$=$1;}
| MINUS MINUS expr        {$$=$3-1;}
| LPAREN expr RPAREN      {$$=$2;}
| expr BITWISEAND expr    {int x=(int)$1;
                          int y=(int)$3;
                          if(x!=$1 || y!=$3) fprintf(yyout,"type error.\n");
                          else $$=(int)$1&(int)$3;}
| expr MINUS expr         {$$=$1-$3;}
| expr MUL expr           {$$=$1*$3;}
| expr DIV expr           {if($3==0) yyerror("Div by 0 error.");
                          else $$=$1/$3;}

| expr LSHIFT expr        {int x=(int)$1;
                          int y=(int)$3;
                          if(x!=$1 || y!=$3) fprintf(yyout,"type error.\n");
                          else $$=(int)$1<<(int)$3;}

| expr RSHIFT expr       {int x=(int)$1;
                         int y=(int)$3;
                         if(x!=$1 || y!=$3) fprintf(yyout,"type error.\n");
                         else $$=(int)$1>>(int)$3;}
| expr MOD expr          {int x=(int)$1;
                          int y=(int)$3;
                         if(x!=$1 || y!=$3) fprintf(yyout,"type error.\n");
                         else $$=(int)$1%(int)$3;}
| expr LEQUAL expr       {if($1<=$3) fprintf(yyout,"true.\n");
                         else fprintf(yyout,"false.\n");}
| expr GEQUAL expr       {if($1>=$3) fprintf(yyout,"true.\n");
                         else fprintf(yyout,"false.\n");}
| expr NEQUAL expr       {if($1!=$3) fprintf(yyout,"true.\n");
                         else fprintf(yyout,"false.\n");}
| expr DSTERIK expr      {int x=(int)$1;
                         int y=(int)$3;
                         if(x!=$1 || y!=$3) fprintf(yyout,"type error.\n");
                         else $$=pow((int)$1,(int)$3);}
| NUMBER                 {$$=$1;};

%%
void main(){
    yyin=fopen("in.txt","r");
    yyout=fopen("output.txt","w");
    yyparse();
}
