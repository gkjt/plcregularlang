open Langlang
open Parser
open Lexer
open Arg
open Printf

let channel =
    try (open_in Sys.argv.(1))
    with Invalid_argument x -> failwith "USAGE: ./langlangi PATH";;

let parseProgram =
    try let lexbuf = Lexing.from_channel channel in
        parse_main language lexbuf
    with Parsing.Parse_error -> failwith "Parse Failure";;

let parsedProg = parseProgram in
    let () = print_string "Parsing Completed\n" in
        let _ = typeOfProgram parsedProg in
            let () = print_string "Type Checking Completed\n" in
                let result = evalProg parsedProg in
                    let () = print_string "Result: " ; print_val result in
                        flush stdout;;
