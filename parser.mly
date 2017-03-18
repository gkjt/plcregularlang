%{
    open Langlang
%}

%token RPAR LPAR
%token <int> INTEGER
%token <string> WORD
%token EMPTYWORD
%token SEPARATOR
%token EOF
%token QUOTE
%token <string> STRING

%start parse_main
%type <Langlang.langTerm> parse_main
%type <Langlang.langTerm> parse_input
%type <Langlang.word list> lang

%%

parse_main:
    | expr EOF {$1}
    ;

expr:
    | INTEGER               { Int $1 }
    | QUOTE STRING QUOTE    { String($2) }

parse_input:
    | LPAR lang RPAR        { Language $2 }
    | INTEGER { Int $1 }

lang:
    | lang SEPARATOR lang   { $1 :: $3 }
    | WORD                  { $1 }
    | EMPTYWORD             { "" }
