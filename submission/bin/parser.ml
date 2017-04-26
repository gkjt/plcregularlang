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

open Parsing;;
let _ = parse_error;;
# 2 "bin/parser.mly"
    open Langlang
    open Langset
    exception EOF
    exception EndOfProgram
# 33 "bin/parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* RPAR *);
  258 (* LPAR *);
  259 (* OBRACK *);
  260 (* CBRACK *);
  263 (* EMPTYWORD *);
  264 (* SEPARATOR *);
  265 (* PRINT *);
  266 (* QUOTE *);
  268 (* ASSIGNMENT *);
  269 (* ENDSTMNT *);
  271 (* READLANG *);
  272 (* READINT *);
  273 (* CONC *);
  274 (* SETUNION *);
  275 (* SETINTERSECT *);
  276 (* STAR *);
  277 (* POWER *);
    0|]

let yytransl_block = [|
  261 (* INTEGER *);
  262 (* WORD *);
  267 (* STRING *);
  270 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\004\000\004\000\002\000\002\000\003\000\003\000\
\005\000\005\000\000\000\000\000"

let yylen = "\002\000\
\002\000\003\000\003\000\003\000\001\000\001\000\001\000\003\000\
\001\000\001\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000\003\000\003\000\001\000\004\000\004\000\003\000\001\000\
\001\000\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\005\000\000\000\006\000\
\000\000\009\000\010\000\027\000\000\000\000\000\028\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\025\000\026\000\000\000\000\000\000\000\018\000\
\004\000\000\000\000\000\002\000\003\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\019\000\022\000\021\000\023\000"

let yydgoto = "\003\000\
\012\000\015\000\029\000\017\000\030\000\013\000"

let yysindex = "\025\000\
\171\255\007\255\000\000\000\255\171\255\000\000\171\255\000\000\
\004\255\000\000\000\000\000\000\175\255\041\255\000\000\022\255\
\027\255\046\255\040\255\171\255\001\000\171\255\171\255\171\255\
\171\255\171\255\000\000\000\000\031\255\036\255\000\255\000\000\
\000\000\243\254\243\254\000\000\000\000\243\254\243\254\243\254\
\243\254\243\254\008\255\041\255\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\020\255\000\000\000\000\000\000\000\000\000\000\000\000\045\255\
\000\000\000\000\255\254\000\000\052\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\052\255\000\000\000\000\
\000\000\066\255\081\255\000\000\000\000\096\255\111\255\126\255\
\141\255\156\255\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\041\000\029\000\030\000\042\000\000\000\251\255"

let yytablesize = 273
let yytable = "\018\000\
\036\000\019\000\017\000\022\000\023\000\024\000\025\000\026\000\
\014\000\014\000\016\000\017\000\046\000\034\000\035\000\020\000\
\038\000\039\000\040\000\041\000\042\000\007\000\007\000\007\000\
\007\000\001\000\002\000\032\000\007\000\031\000\007\000\043\000\
\007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
\007\000\004\000\005\000\044\000\006\000\020\000\027\000\028\000\
\007\000\033\000\008\000\001\000\024\000\009\000\010\000\011\000\
\022\000\023\000\024\000\025\000\026\000\037\000\022\000\023\000\
\024\000\025\000\026\000\016\000\016\000\016\000\016\000\047\000\
\045\000\048\000\016\000\000\000\016\000\000\000\016\000\016\000\
\016\000\016\000\008\000\008\000\008\000\008\000\000\000\000\000\
\000\000\008\000\000\000\008\000\000\000\008\000\008\000\008\000\
\008\000\011\000\011\000\011\000\011\000\000\000\000\000\000\000\
\011\000\000\000\011\000\000\000\011\000\011\000\011\000\011\000\
\012\000\012\000\012\000\012\000\000\000\000\000\000\000\012\000\
\000\000\012\000\000\000\012\000\012\000\012\000\012\000\013\000\
\013\000\013\000\013\000\000\000\000\000\000\000\013\000\000\000\
\013\000\000\000\013\000\013\000\013\000\013\000\014\000\014\000\
\014\000\014\000\000\000\000\000\000\000\014\000\000\000\014\000\
\000\000\014\000\014\000\014\000\014\000\015\000\015\000\015\000\
\015\000\000\000\000\000\000\000\015\000\000\000\015\000\000\000\
\015\000\015\000\015\000\015\000\004\000\005\000\000\000\006\000\
\000\000\000\000\000\000\007\000\000\000\008\000\000\000\000\000\
\009\000\010\000\011\000\021\000\000\000\000\000\000\000\022\000\
\023\000\024\000\025\000\026\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\004\000\005\000\000\000\006\000\000\000\000\000\
\000\000\007\000\000\000\008\000\000\000\000\000\009\000\010\000\
\011\000"

let yycheck = "\005\000\
\000\000\007\000\004\001\017\001\018\001\019\001\020\001\021\001\
\002\001\002\001\011\001\013\001\005\001\019\000\020\000\012\001\
\022\000\023\000\024\000\025\000\026\000\002\001\003\001\004\001\
\005\001\001\000\002\000\001\001\009\001\008\001\011\001\001\001\
\013\001\014\001\015\001\016\001\017\001\018\001\019\001\020\001\
\021\001\002\001\003\001\008\001\005\001\001\001\006\001\007\001\
\009\001\004\001\011\001\000\000\001\001\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\021\001\021\000\017\001\018\001\
\019\001\020\001\021\001\002\001\003\001\004\001\005\001\043\000\
\031\000\044\000\009\001\255\255\011\001\255\255\013\001\014\001\
\015\001\016\001\002\001\003\001\004\001\005\001\255\255\255\255\
\255\255\009\001\255\255\011\001\255\255\013\001\014\001\015\001\
\016\001\002\001\003\001\004\001\005\001\255\255\255\255\255\255\
\009\001\255\255\011\001\255\255\013\001\014\001\015\001\016\001\
\002\001\003\001\004\001\005\001\255\255\255\255\255\255\009\001\
\255\255\011\001\255\255\013\001\014\001\015\001\016\001\002\001\
\003\001\004\001\005\001\255\255\255\255\255\255\009\001\255\255\
\011\001\255\255\013\001\014\001\015\001\016\001\002\001\003\001\
\004\001\005\001\255\255\255\255\255\255\009\001\255\255\011\001\
\255\255\013\001\014\001\015\001\016\001\002\001\003\001\004\001\
\005\001\255\255\255\255\255\255\009\001\255\255\011\001\255\255\
\013\001\014\001\015\001\016\001\002\001\003\001\255\255\005\001\
\255\255\255\255\255\255\009\001\255\255\011\001\255\255\255\255\
\014\001\015\001\016\001\013\001\255\255\255\255\255\255\017\001\
\018\001\019\001\020\001\021\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\002\001\003\001\255\255\005\001\255\255\255\255\
\255\255\009\001\255\255\011\001\255\255\255\255\014\001\015\001\
\016\001"

let yynames_const = "\
  EOF\000\
  RPAR\000\
  LPAR\000\
  OBRACK\000\
  CBRACK\000\
  EMPTYWORD\000\
  SEPARATOR\000\
  PRINT\000\
  QUOTE\000\
  ASSIGNMENT\000\
  ENDSTMNT\000\
  READLANG\000\
  READINT\000\
  CONC\000\
  SETUNION\000\
  SETINTERSECT\000\
  STAR\000\
  POWER\000\
  "

let yynames_block = "\
  INTEGER\000\
  WORD\000\
  STRING\000\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 39 "bin/parser.mly"
                            (_1)
# 214 "bin/parser.ml"
               : Langlang.langTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    Obj.repr(
# 40 "bin/parser.mly"
                           (_1)
# 221 "bin/parser.ml"
               : Langlang.langTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Langlang.langTerm) in
    Obj.repr(
# 41 "bin/parser.mly"
                                   ( Statement (_1, _3) )
# 229 "bin/parser.ml"
               : Langlang.langTerm))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 45 "bin/parser.mly"
                                ( _2 )
# 236 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 46 "bin/parser.mly"
                                ( Int _1 )
# 243 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 47 "bin/parser.mly"
                       ( String _1 )
# 250 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 48 "bin/parser.mly"
                                ( Var _1 )
# 257 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 49 "bin/parser.mly"
                              ( Assign(_1, _3) )
# 265 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 50 "bin/parser.mly"
                                ( ReadLanguage )
# 271 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 51 "bin/parser.mly"
                                ( ReadInt )
# 277 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 52 "bin/parser.mly"
                    ( Conc(_1, _3) )
# 285 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 53 "bin/parser.mly"
                                ( Union (_1, _3))
# 293 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 54 "bin/parser.mly"
                                ( Intersection (_1, _3))
# 301 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 55 "bin/parser.mly"
                    ( Star (_1, _3) )
# 309 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 56 "bin/parser.mly"
                     ( Power (_1, _3) )
# 317 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 57 "bin/parser.mly"
                              ( PrintSome (_2, _3) )
# 325 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 58 "bin/parser.mly"
                                ( Print (_2) )
# 332 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Langlang.word list) in
    Obj.repr(
# 59 "bin/parser.mly"
                                ( Language _2 )
# 339 "bin/parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Langlang.word list) in
    Obj.repr(
# 62 "bin/parser.mly"
                                     ( set_add _3 _1 )
# 347 "bin/parser.ml"
               : Langlang.word list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 63 "bin/parser.mly"
             ( [_1] )
# 354 "bin/parser.ml"
               : Langlang.word list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Langlang.word list) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Langlang.stdinBuffer) in
    Obj.repr(
# 66 "bin/parser.mly"
                                    ( StdinBuff (Language _2, _4) )
# 362 "bin/parser.ml"
               : Langlang.stdinBuffer))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : Langlang.word list) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 67 "bin/parser.mly"
                                    ( StdinBuff (Language _2, StdinInt _4) )
# 370 "bin/parser.ml"
               : Langlang.stdinBuffer))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Langlang.word) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Langlang.word list) in
    Obj.repr(
# 70 "bin/parser.mly"
                            ( set_add _3 _1 )
# 378 "bin/parser.ml"
               : Langlang.word list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Langlang.word) in
    Obj.repr(
# 71 "bin/parser.mly"
           ( [_1] )
# 385 "bin/parser.ml"
               : Langlang.word list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 74 "bin/parser.mly"
                            ( _1 )
# 392 "bin/parser.ml"
               : Langlang.word))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "bin/parser.mly"
                            ( "" )
# 398 "bin/parser.ml"
               : Langlang.word))
(* Entry parse_main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry parse_input *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let parse_main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Langlang.langTerm)
let parse_input (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 2 lexfun lexbuf : Langlang.stdinBuffer)
