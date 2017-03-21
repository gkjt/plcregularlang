open Langlang
open Parser
open Lexer
open Arg
open Printf
open Langset

exception ParseError
;;

let channel =
    try (open_in Sys.argv.(1))
    with Invalid_argument x -> failwith "USAGE: ./langlangi PATH";;

let parse_or_exn parseFunc rule lexbuf source =
    try parseFunc rule lexbuf
    with exn ->
        let pos = lexbuf.Lexing.lex_curr_p in
        let line = pos.Lexing.pos_lnum in
        let charnum = pos.Lexing.pos_cnum - pos.Lexing.pos_bol in
        let token = Lexing.lexeme lexbuf in
        let () = (Printf.printf "Syntax error on token \"%s\" (%d, %d) of %s" token line charnum source) in
        exit 1

let parsedProgram =
    let lexbuf = Lexing.from_channel channel in
        parse_or_exn parse_main prog lexbuf Sys.argv.(1)
;;
let stdinBuff =
    let lexbuf = Lexing.from_channel stdin in
        parse_or_exn parse_input language lexbuf "stdin"
        ;;

let _ = typeCheckProgram parsedProgram in
    let () = print_string "Type Checking Completed\n" in
        try let (env, result) = evalProg parsedProgram stdinBuff in
            let () = print_string "Exited" in
                flush stdout
                with ProgEnd -> exit 0
;;
