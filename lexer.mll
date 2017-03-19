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
    | ' ' | '\t' | '\n'         { language lexbuf } (* skip whitespace and newlines *)
    | ['0'-'9']+ as lxm         { INTEGER (int_of_string lxm) }
    | ['a'-'z']+ as lxm         { STRING (lxm) }
    | eof                       { EOF }
    | ';'                       { ENDSTMNT }
    | '\"'                      { QUOTE }
    | '='                       { ASSIGNMENT }
