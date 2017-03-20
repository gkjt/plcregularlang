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
    | [' ' '\t' '\n']           { prog lexbuf } (* skip whitespace and newlines *)
    | eof                       { EOF }
    | ['0'-'9']+ as lxm         { INTEGER (int_of_string lxm) }
    | "readlang"                { READLANG }
    | "readint"                 { READINT }
	| "prefix"					{ PREFIX }
    | ['a'-'z']+ as lxm         { VAR (lxm) }
    | ';'                       { ENDSTMNT }
    | '"'                       { QUOTE }
    | '='                       { ASSIGNMENT }
