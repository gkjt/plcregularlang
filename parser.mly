%{
    open Langlang
    exception EOF
    exception EndOfProgram
%}


%token EOF
%token RPAR LPAR
%token <int> INTEGER
%token <string> WORD
%token EMPTYWORD
%token SEPARATOR
%token QUOTE
%token <string> STRING
%token ASSIGNMENT
%token ENDSTMNT

%right ASSIGNMENT

%start parse_main
%start parse_input
%type <Langlang.langTerm list> parse_main
%type <Langlang.langTerm> parse_input
%type <Langlang.word list> lang
%type <Langlang.word> word

%%

parse_main:
    | expr ENDSTMNT     {[$1]}
    | expr ENDSTMNT parse_main    { $1::$3 }
    | expr ENDSTMNT EOF {[$1]}
    ;

expr:
    | INTEGER               { Int $1 }
    | QUOTE STRING QUOTE    { String $2 }
    | STRING                { Var $1 }
    | STRING ASSIGNMENT expr { Assign($1, $3) }
    | LPAR lang RPAR        { Language $2 }

parse_input:
    | LPAR lang RPAR        { Language $2 }
    | INTEGER               { Int $1 }

lang:
    | word SEPARATOR lang   { $1 :: $3 }
    | word { [$1] }
word:
    | WORD                  { $1 }
    | EMPTYWORD             { "" }
