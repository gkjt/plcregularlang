open Langlang
open Parser
open Lexer
open Args
open Printf

let parseProgram chan =
    try let lexbuf = Lexing.from_channel chan in
        parser_main lexer_main lexbuff
    with Parsing.Parse_error -> failwith "Parse Failure";;

let arg = ref stdin in
    let setProg prog = arg := open_in p in
        let usage = "./langlang PROGRAM" in
            parse [] setProg;
            let parsedProg = parseProgram !arg in
                let () = print_string "Parsing Completed\n" in
                    let _ = typeProg parsedProg in
                        let () = print_string "Type Checking Completed\n" in
                            let result = evalProg parsedProg in
                                let () = print_string "Result of program execution: "^result;
