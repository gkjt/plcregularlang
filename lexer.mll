


rule language = parse
      '{' { RPAR }
    | '}' { LPAR }
    | ' ' | \t { language lexbuff } (* skip whitespace *)
    | '\n' { EOL }
    | ['0'-'9']+ as lxm { WORDCOUNT (int_of_string lxm) }
    | ['a'-'Z' '0'-'9']+ as lxm { WORD (lxm) }
    | ',' as lxm { SEPARATOR }
    | ':' { EMPTYWORD }
