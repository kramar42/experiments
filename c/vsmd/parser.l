%{
#include "y.tab.h"
%}

%%
\[              return O_BRACK;
\]              return C_BRACK;
[a-zA-Z]+       yylval = strdup (yytext); return WORD;
=               return EQ;
[ \t\n]         ;
%%




