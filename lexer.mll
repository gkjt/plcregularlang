{
    open Parser
}


rule language = parse
    | ' ' | '\t' | '\n'         { language lexbuf } (* skip whitespace *)
    | ['0'-'9']+ as lxm         { INTEGER (int_of_string lxm) }
    | ['a'-'Z' '0'-'9']+ as lxm { WORD (lxm) }
    | ',' as lxm                { SEPARATOR }
    | ':'                       { EMPTYWORD }
