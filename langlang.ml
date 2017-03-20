exception TypeError;;
exception Terminated;;
exception VarNotExist;;
exception Stuck;;
exception UnexpectedEnd;;


type langType = IntType | FunType | LangType | StringType;;

type word = string;;

type langTerm =
    | Int of int
    | String of string
    | Language of word list
    | Var of string
    | Assign of string * langTerm
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
    | Int(n) -> IntType
    | String(x) -> StringType
    | Language(x) -> LangType
    | Var x -> typeOf env (lookup env x)
    | Assign (x, z) -> typeOf env z
    | _ -> raise TypeError;;

let rec typeOfProgram expList =
    match expList with
        | [x] -> typeOf (Env[]) x
        | x::y -> typeOf (Env[]) x; typeOfProgram y
;;


let rec isVal env v =
    match (typeOf env v) with
        | IntType | StringType | LangType -> true
        | _ -> false
;;


let rec eval env exp =
    match exp with
    | Int x -> raise Terminated
    | String x -> raise Terminated
    | Language x -> raise Terminated
    | Var x -> (env, lookup env x)
    | Assign (name, thing) when (isVal env thing) ->
        ( (addBinding env name thing), thing)
    | Assign (name, thing) ->
        let (env', exp') = (eval env thing) in
            (env', Assign (name, exp'))
    ;;

let rec stmntEvalLoop env exp =
    try
        let (env', exp') = eval env exp in
            stmntEvalLoop env' exp'
    with Terminated -> if (isVal env exp) then (env, exp) else raise Stuck;;

let rec progEvalLoop env expList =
    match expList with
        | [x] -> stmntEvalLoop env x
        | x :: y -> let (env', exp) = stmntEvalLoop env x; in progEvalLoop env' y
    ;;

let rec evalProg expList =
    progEvalLoop (Env []) expList;;

let rec print_language v =
    let rec aux x = (
        match x with
            | x :: y -> print_string (x^","); aux y
            | [x] -> print_string (x^"}")
            ) in
                match v with
                    | Language [] -> print_string "{}"
                    | Language x -> print_string "{"; aux x
;;

let print_val v =
    match v with
        | Int i -> print_string "Int: "; print_int i
        | String i -> print_string "String: "; print_string i
        | Language x -> print_language v
    ;;
