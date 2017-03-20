open Langset;;

exception Stuck
exception TypeError
exception BadBufferError of string
exception Terminated
exception VarNotExist
exception UnexpectedEnd
exception IllegalArgument
exception EmptyBufferError


type langType = IntType | FunType | LangType | StringType | StatementType;;

type word = string;;

type langTerm =
    | Statement of langTerm * langTerm
    | Int of int
    | String of string
    | Language of word list
    | Var of string
    | Assign of string * langTerm
    | ReadLanguage
    | ReadInt
;;

type stdinBuffer = StdinBuff of langTerm * stdinBuffer
    | StdinInt of int
    | EmptyBuffer
;;

type 'a context = Env of (string * 'a) list;;
type typEnv = langType context;;
type valEnv = langTerm context;;

let addBinding env name obj =
    match env with Env(e) -> Env((name, obj) :: e);;

let rec lookup env lookfor =
    match env with
        | Env [] -> raise VarNotExist
        | Env ( (name, obj) :: t) -> match (name = lookfor) with
            | true -> obj
            | false -> lookup (Env t) lookfor
;;

let rec typeOf env exp =
    match exp with
    | Statement (x,y) ->
        let (env', t) = typeOf env x in
        let env'', t2 = typeOf env' y in
            (env'', StatementType)
    | Int(n) -> (env, IntType)
    | String(x) -> (env, StringType)
    | Language(x) -> (env, LangType)
    | Var (x) -> (env, (lookup env x))
    | Assign (x, z) ->
        let (env', tz) = (typeOf env z) in
            (addBinding env x tz, tz)
    | ReadLanguage -> (env, LangType)
    | ReadInt -> (env, IntType)
    | _ -> raise TypeError
;;

let rec typeCheckProgram statement =
    match statement with
        | Statement(x, y) ->
            let (env, typeOfFirst) = typeOf (Env[]) x in
                typeOf env y;
        | x -> typeOf (Env []) x
;;


let rec isVal v =
    match v with
        | Int x -> true
        | String x -> true
        | Language x -> true
        | ReadLanguage -> true
        | ReadInt -> true
        | _ -> false
;;


let rec eval env exp stdinBuff =
    match exp with
    | Statement (x, y) -> let (env', expr', stdinBuff') = eval env x stdinBuff in eval env' y stdinBuff'
    | Int x -> raise Terminated
    | String x -> raise Terminated
    | Language x -> raise Terminated
    | Var x -> (env, lookup env x, stdinBuff)
    | Assign (name, thing) when (isVal thing) ->
        ( (addBinding env name thing), thing, stdinBuff)
    | Assign (name, thing) ->
        let (env', exp', stdinBuff') = (eval env thing stdinBuff) in
            (env', Assign (name, exp'), stdinBuff')
    | ReadLanguage -> (match stdinBuff with
        | StdinBuff (Language x, StdinInt y) -> (env, Language x, StdinInt y)
        | StdinBuff (Language x, StdinBuff (y,z)) -> (env, (Language x), StdinBuff (y,z))
        | StdinInt x -> raise EmptyBufferError
        | _ -> raise (BadBufferError "Unable to read lang due to bad buffer"))
    | ReadInt -> match stdinBuff with
        | StdinInt x -> (env, Int x, EmptyBuffer)
        | _ -> raise (BadBufferError "Unable to read int due to bad buffer")
    ;;

let rec stmntEvalLoop env exp stdinBuff =
    try
        let (env', exp', stdinBuff') = eval env exp stdinBuff in
            stmntEvalLoop env' exp' stdinBuff'
    with Terminated ->  (env, exp, stdinBuff);;

(* let rec progEvalLoop env expList =
    match expList with
        | [x] -> stmntEvalLoop env x
        | x :: y -> let (env', exp, stdinBuff') = stmntEvalLoop env x; in progEvalLoop env' y
    ;; *)

let rec evalProg exp stdinBuff =
    let (env,result,_) = stmntEvalLoop (Env []) exp stdinBuff in
        (env, result);;

let rec print_language v =
    let rec aux x =
        match x with
            | [x] -> print_string (x^"}")
            | x :: y -> print_string (x^","); aux y
            | _ ->  print_string "}"
        in
                match v with
                    | Language [] -> print_string "{}"
                    | Language x -> print_string "{"; aux x
                    | _ -> raise TypeError
;;

let print_val v =
    match v with
        | Int i -> print_string "Int: "; print_int i
        | String i -> print_string "String: "; print_string i
        | Language x -> print_language v
        | _ -> raise IllegalArgument
    ;;
