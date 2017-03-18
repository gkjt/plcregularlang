%{
    open Langlang
%}

%token RPAR LPAR
%token <int> INTEGER
%token <string> WORD
%token EMPTYWORD
%token SEPARATOR
%token EOF

%start parse_main
%type <Langlang.langTerm> parse_main

%%

parse_main:
    expr EOF {$1}
    ;

expr:
    INTEGER { Int $1 }
