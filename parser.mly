%{
    open Langlang
%}

%token RPAR LPAR
%token <int> INTEGER
%token WORD
%token EMPTYWORD
%token SEPARATOR
%token EOF

%start main
%type <Langlang.langTerm> main

%%

main:
    expr EOF {$1}
    ;

expr:
    INTEGER { Int $1 }
