type token =
  | EOF
  | RPAR
  | LPAR
  | OBRACK
  | CBRACK
  | INTEGER of (int)
  | WORD of (string)
  | EMPTYWORD
  | SEPARATOR
  | PRINT
  | QUOTE
  | STRING of (string)
  | ASSIGNMENT
  | ENDSTMNT
  | VAR of (string)
  | READLANG
  | READINT
  | CONC
  | SETUNION
  | SETINTERSECT
  | STAR
  | POWER

val parse_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Langlang.langTerm
val parse_input :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Langlang.stdinBuffer
