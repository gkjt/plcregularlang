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
%token <string> VAR
%token READLANG

%right ASSIGNMENT

%start parse_main
%start parse_input
%type <Langlang.langTerm> parse_main
%type <Langlang.stdinBuffer> parse_input
%type <Langlang.word list> lang
%type <Langlang.word> word

%%

parse_main:
    | expr ENDSTMNT         {$1}
    | expr ENDSTMNT EOF {$1}
    | expr ENDSTMNT parse_main    { Statement ($1, $3) }
    ;

expr:
    | INTEGER                   { Int $1 }
    | QUOTE STRING QUOTE        { String $2 }
    | VAR                       { Var $1 }
    | VAR ASSIGNMENT INTEGER    { Assign($1, Int($3)) }
    | READLANG                  { ReadLanguage }

parse_input:
    | LPAR lang RPAR parse_input    { StdinBuff (Language $2, $4) }
    | LPAR lang RPAR INTEGER        { StdinBuff (Language $2, StdinInt $4) }

lang:
    | word SEPARATOR lang   { $1 :: $3 }
    | word { [$1] }

word:
    | WORD                  { $1 }
    | EMPTYWORD             { "" }
