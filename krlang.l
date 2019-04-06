%{
#include "y.tab.h"
void yyerror (char *s);
int yylex();
unsigned int comm = 0 ; 
#define COMM {comm += strlen(yytext);}
%}
bop	=|<|>|!=|<=|>=|==|&&|"||"|[+-/*]
uop	"++"|"--"

%%

[a-z]                           {yylval.id = yytext[0]; return ID;} 
[0-9]*                          {yylval.num = atoi(yytext); return INTNUMBER; }
[0-9]*(\.)?[0-9]*               {yylval.numfloat = atoi(yytext); return FLOATNUMBER; }
"exit"                          {return EXIT;}
"const"                           {return CONSTANT;}
"if"                              {return  IF;}
"else"                            {return ELSE;}
"for"                             {return FOR;}
"while"                           {return WHILE;}
"do"                              {return DO;}
"print"                          {return PRINT;}
"scan"                            {return SCAN;}
"and"                             {return log_and;}
"or"                              {return log_or;}
_                                 {ECHO; yyerror("unexpected character\n");};
[ \n\t]	                           ;
"+"                               return PLUS;
"-"                               return MINUS;
"/"                               return DIVIDE;
"*"                               return MULTIPLY;
{bop}	                            {return BOP;}
{uop}	                            {return UOP;}
True                              {return BOOLEAN;}
False                             {return BOOLEAN;}
"ISE"                             {return ISE;}
"ANCAKVEANCAK"                    {return ANCAKVEANCAK;}
%%

int yywrap(void){
  return 1;
}