%{
    open Langlang
    open Langset
    exception EOF
    exception EndOfProgram
%}


%token EOF
%token RPAR LPAR OBRACK CBRACK
%token <int> INTEGER
%token <string> WORD
%token EMPTYWORD
%token SEPARATOR
%token PRINT
%token QUOTE
%token <string> STRING
%token ASSIGNMENT
%token ENDSTMNT
%token <string> VAR
<<<<<<< HEAD
%token READLANG READINT PREFIX
=======
%token READLANG READINT
%token SETUNION
>>>>>>> origin/master

%right ASSIGNMENT

%start parse_main
%start parse_input
%type <Langlang.langTerm> parse_main
%type <Langlang.stdinBuffer> parse_input
%type <Langlang.word list> lang
%type <Langlang.word> word

%%

parse_main:
    | expr ENDSTMNT      			{$1}
    | expr ENDSTMNT EOF				{$1}
    | expr ENDSTMNT parse_main    	{ Statement ($1, $3) }
    ;

expr:
    | OBRACK expr CBRACK        { $2 }
    | INTEGER                   { Int $1 }
    | QUOTE STRING QUOTE        { String $2 }
    | VAR                       { Var $1 }
<<<<<<< HEAD
    | VAR ASSIGNMENT expr    	{ Assign($1, $3) }
    | READLANG                  { ReadLanguage }
    | READINT                  	{ ReadInt }
	| PREFIX					{ Prefix }
=======
    | VAR ASSIGNMENT expr       { Assign($1, $3) }
    | READLANG                  { ReadLanguage }
    | READINT                   { ReadInt }
    | expr SETUNION expr        { Union ($1, $3)}
    | PRINT expr INTEGER        { PrintSome ($2, $3) }
    | PRINT expr                { Print ($2) }
>>>>>>> origin/master

parse_input:
    | LPAR lang RPAR parse_input    { StdinBuff (Language $2, $4) }
    | LPAR lang RPAR INTEGER        { StdinBuff (Language $2, StdinInt $4) }

lang:
    | word SEPARATOR lang   { set_add $3 $1 }
    | word { [$1] }

word:
    | WORD                  { $1 }
    | EMPTYWORD             { "" }
