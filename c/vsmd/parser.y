%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define YYSTYPE char *

  char *section;
  
  void yyerror(const char *str)
  {
    fprintf(stderr,"error: %s\n",str);
  }

  int yywrap(void)
  {
    return 1;
  }

  void main(void)
  {
    section = malloc(1024);
    yyparse();
    free(section);
  }
%}

%token O_BRACK C_BRACK WORD EQ

%%
sections:
        | section sections
        ;

section:
        O_BRACK WORD C_BRACK lines
        {
          printf("%s\n", $2);
        }
        ;

lines:
        | line lines
        ;

line:
        WORD EQ WORD
        {
          printf("\tVariable name: %s\n\tVariable value: %s\n\n", $1, $3);
        }
        ;
%%
