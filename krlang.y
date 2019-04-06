%{
#include <stdio.h>     
#include <stdlib.h>
#include <ctype.h>
void yyerror (char *s);
int yylex();
int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
%}
%start program
%union {int num; float numfloat; char id;}        
%token PRINT
%token SCAN
%left OR AND
%token ISE
%token ANCAKVEANCAK
%token EXIT
%token <id> ID
%token <num> INTNUMBER
%token <numfloat> FLOATNUMBER
%token CONS 
%token EQUALS 
%token FOR BOP UOP  DO WHILE IF ELSE
%left PLUS MINUS
%left MULTIPLY DIVIDE
%right NOT
%type <id> assignment
%type <num> program exp term factor



%%

program : assignment ';'                {;}
            |EXIT ';'                   {exit(EXIT_SUCCESS);}
            | PRINT exp ';'             {printf("\n",$2);}
            | program assignment ';'    {;}
            | program PRINT exp ';'     {printf("\n",$3);}
            | program EXIT ';'          {exit(EXIT_SUCCESS);}
            |program FOR '('lexp ';' lexp ';' lexp')'  lbody 	{printf("For loop");}
                    | WHILE  '(' lexp ')' lbody			        {printf("While loop");}
                    | DO codeblock WHILE  lexp  ';'		{printf("DO while");}
                    | IF  '(' lexp ')' lbody				        {printf("IF");}
                    | IF '(' lexp ')'lbody	ELSE lbody		{printf("IF..ELSE");}
                    ;
                        lbody: stmt
                        | codeblock
                        ;
                        codeblock:'{' stmt_list '}'
                        ;
                        stmt_list: stmt_list stmt
                        |
                        ;
                        stmt: lexp ';'
                        ;
                        lexp: fexp			
                        |				
                        ;
                        fexp: fexp ',' exp		
                        |exp
                        |'(' fexp ')'		
                        ;
                        exp: ID BOP exp			
                        | ID UOP			
                        | UOP ID
                        | ID
                        | INTNUMBER
                        ;

        ;
assignment : ID '=' exp  { updateSymbolVal($1,$3); }
exp     : term                           {$$ = $1;}
        | exp '+' term                   {$$ = $1 + $3;}
        | exp '-' term                   {$$ = $1 - $3;}
        ;
term    : factor                          {$$ = $1;}
        |term '*' factor                  {$$ = $1 * $3;}        
        |term '/' factor                  {$$ = $1 / $3;}
        ;
factor  : INTNUMBER                        {$$ = $1;}
        | '('exp')'                              {$$ = $2;}
        ;



%%        

main()
{
yyparse();
}
int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}
int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}