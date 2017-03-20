exception TypeError;;
exception Terminated;;
exception VarNotExist;;
exception Stuck;;
exception UnexpectedEnd;;


type langType = IntType | FunType | LangType | StringType | StatementType;;

type word = string;;

type langTerm =
    | Statement of langTerm * langTerm
    | Int of int
    | String of string
    | Language of word list
    | Var of string
    | Assign of string * langTerm
    | ReadLang
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
    | ReadLang -> (env, LangType)
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
        | ReadLang -> true;
        | _ -> false
;;


let rec eval env exp =
    match exp with
    | Statement (x, y) -> let (env', expr') = eval env x in eval env' y
    | Int x -> raise Terminated
    | String x -> raise Terminated
    | Language x -> raise Terminated
    | Var x -> (env, lookup env x)
    | Assign (name, thing) when (isVal thing) ->
        ( (addBinding env name thing), thing)
    | Assign (name, thing) ->
        let (env', exp') = (eval env thing) in
            (env', Assign (name, exp'))
    ;;

let rec stmntEvalLoop env exp =
    try
        let (env', exp') = eval env exp in
            stmntEvalLoop env' exp'
    with Terminated ->  (env, exp);;

let rec progEvalLoop env expList =
    match expList with
        | [x] -> stmntEvalLoop env x
        | x :: y -> let (env', exp) = stmntEvalLoop env x; in progEvalLoop env' y
    ;;

let rec evalProg exp =
    stmntEvalLoop (Env []) exp;;

let rec print_language v =
    let rec aux x = (
        match x with
            | x :: y -> print_string (","^x); aux y
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
