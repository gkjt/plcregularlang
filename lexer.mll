{
    open Parser
}


rule language = parse
    | ' ' | '\t' | '\n'         { language lexbuf } (* skip whitespace and newlines *)
    | eof                       { EOF }
    | ['0'-'9']+ as lxm         { INTEGER (int_of_string lxm) }
    | ['a'-'z']+ as lxm         { WORD (lxm) }
    | ','                       { SEPARATOR }
    | ':'                       { EMPTYWORD }
    | '{'                       { LPAR }
    | '}'                       { RPAR }

and prog = parse
    | [' ' '\t']                { prog lexbuf } (* skip whitespace and newlines *)
    | '\n'                      { Lexing.new_line lexbuf; prog lexbuf }
    | eof                       { EOF }
    | ['0'-'9']+ as lxm         { INTEGER (int_of_string lxm) }
    | "readlang"                { READLANG }
    | "readint"                 { READINT }
	| "+"					    { CONC }
    | "U"                       { SETUNION }
    | "I"                       { SETINTERSECT }
    | "print"                   { PRINT }
    | '"' (['a'-'z']+ as lxm) '"' { STRING (lxm) }
    | ['a'-'z']+ as lxm         { VAR (lxm) }
    | ';'                       { ENDSTMNT }
    | '"'                       { QUOTE }
    | '='                       { ASSIGNMENT }
    | '('                       { OBRACK }
    | ')'                       { CBRACK }
