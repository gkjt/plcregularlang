open Langset;;

exception Stuck
exception TypeError of string
exception BadBufferError of string
exception Terminated
exception VarNotExist of string
exception UnexpectedEnd
exception IllegalArgument
exception EmptyBufferError
exception ProgEnd;;


type langType = IntType | LangType | StringType | StatementType | UnitType;;

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
	| Conc of langTerm * langTerm
    | Union of langTerm * langTerm
    | Intersection of langTerm * langTerm
    | Print of langTerm
    | PrintSome of langTerm * langTerm
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
        | Env [] -> raise (VarNotExist lookfor)
        | Env ( (name, obj) :: t) -> match (name = lookfor) with
            | true -> obj
            | false -> lookup (Env t) lookfor
;;

let rec isVal v =
    match v with
        | Int x -> true
        | String x -> true
        | Language x -> true
        | _ -> false
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
	| Conc (lang1, lang2) ->
        (match typeOf env lang1 with
            | (e, LangType) | (e, StringType) ->
                let (_, typeOfLang2) = typeOf env lang2 in
                    match typeOfLang2 with
                    | LangType | StringType -> (env, LangType)
                    | _ -> raise (TypeError "Concatenate must be between Languages, Strings, or both")
            | _ -> raise (TypeError "Concatenate must be two Languages, Strings, or both"))
    | Union (lang1, lang2) ->
        (match typeOf env lang1 with
            | (e, LangType) ->
                if (e, LangType) = typeOf env lang2
                then (env, LangType)
                else raise (TypeError "Union must be two Languages")
            | _ -> raise (TypeError "Union must be two Languages"))
    | Intersection (lang1, lang2) ->
        (match typeOf env lang1 with
            | (e, LangType) ->
                if (e, LangType) = typeOf env lang2
                then (env, LangType)
                else raise (TypeError "Intersection must be two Languages")
            | _ -> raise (TypeError "Intersection must be two Languages"))
    | Print x when isVal x -> (env, UnitType)
    | Print x -> let (env', typeOfThing) = typeOf env x in
        (match typeOfThing with
            | IntType | LangType | StringType -> (env, UnitType)
            | StatementType | UnitType -> raise (TypeError "Can only print Ints, Langs and Strings"))
    | PrintSome (Language x, Integer count) -> (env, UnitType)
    | PrintSome (x, Integer count) -> let (env', typeOfThing) = typeOf env x in
        (match typeOfThing with
            | LangType -> (env, UnitType)
            | IntType  | StringType | StatementType | UnitType -> raise (TypeError "Can only print with 2 params on Langs"))
    | PrintSome (x, count) -> let (env', typeOfThing) = typeOf env count in
        (match typeOfThing with
            | LangType -> (env, UnitType)
            | IntType  | StringType | StatementType | UnitType -> raise (TypeError "Can only print with 2 params on Langs"))
    | _ -> raise (TypeError "Unimplemented type")
;;

let rec typeCheckProgram statement =
    match statement with
        | Statement(x, y) ->
            let (env, typeOfFirst) = typeOf (Env[]) x in
                typeOf env y;
        | x -> typeOf (Env []) x
;;

let rec print_some_language lang count =
    let rec aux x count =
    if(count > 0) then (match x with
        | [x] -> print_string (x^"}")
        | x :: y -> if(count = 1) then print_string x
            else print_string (x^", "); aux y (count-1)
        | _ ->  print_string "}") else print_string "}\n"
    in
        match lang with
            | Language [] -> print_string "{}\n"
            | Language x -> print_string "{"; aux x count
            | _ -> raise (TypeError "Not a language")
;;

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
                    | _ -> raise (TypeError "Not a language")
;;

let print_val v =
    match v with
        | Int i -> print_int i; print_string "\n"
        | String i -> print_string i; print_string "\n"
        | Language x -> print_language v; print_string "\n"
        | _ -> raise IllegalArgument
    ;;



let rec eval env exp stdinBuff =
    match exp with
    | Statement (x, y) -> ( match y with
        | Statement (a, b) -> let (env', x', stdinBuff') = stmntEvalLoop env x stdinBuff in stmntEvalLoop env' y stdinBuff'
        | _ -> let (env', x', stdinBuff') = stmntEvalLoop env x stdinBuff in stmntEvalLoop env' y stdinBuff'; raise ProgEnd
        )
    | Int x -> raise Terminated
    | String x -> raise Terminated
    | Language x -> raise Terminated
    | Var x -> (env, lookup env x, stdinBuff)
    | Assign (name, thing) when (isVal thing) ->
        ( (addBinding env name thing), thing, stdinBuff)
    | Assign (name, thing) ->
        let (env', thing', stdinBuff') = (eval env thing stdinBuff) in
            (env', Assign (name, thing'), stdinBuff')
    | ReadLanguage -> (match stdinBuff with
        | StdinBuff (Language x, StdinInt y) -> (env, Language x, StdinInt y)
        | StdinBuff (Language x, StdinBuff (y,z)) -> (env, (Language x), StdinBuff (y,z))
        | StdinInt x -> raise EmptyBufferError
        | _ -> raise (BadBufferError "Unable to read lang due to bad buffer"))
    | ReadInt -> (match stdinBuff with
        | StdinInt x -> (env, Int x, EmptyBuffer)
        | _ -> raise (BadBufferError "Unable to read int due to bad buffer"))
	| Conc (a, b) -> (match (a, b) with
        | (Language x, Language y) ->
            (env, Language (set_concatenate x y), stdinBuff)
        | (String x, String y) ->
            (env, Language (set_concatenate [x] [y]), stdinBuff)
        | (Language x, String y) ->
            (env, Language (set_concatenate x [y]), stdinBuff)
        | (String x, Language y) ->
            (env, Language (set_concatenate [x] y), stdinBuff)
        | (x, Language y) -> let (env', x', stdinBuff') = eval env x stdinBuff in (env', Conc (x', Language y), stdinBuff')
        | (x, String y) -> let (env', x', stdinBuff') = eval env x stdinBuff in (env', Conc (x', String y), stdinBuff')
        | (x, y) -> let (env', y', stdinBuff') = eval env y stdinBuff in (env', Conc (x, y'), stdinBuff'))
    | Union (Language x, Language y) -> (env, Language (set_union x y), stdinBuff)
    | Union (Language x, y) ->
        let (env', y', stdinBuff') = eval env y stdinBuff in
            (env', Union(Language x, y'), stdinBuff')
    | Union (x, y) ->
        let (env', x', stdinBuff') = eval env x stdinBuff in
            (env', Union(x', y), stdinBuff')
    | Intersection(Language x, Language y) -> (env, Language (set_intersection x y), stdinBuff)
    | Intersection(Language x, y) ->
        let (env', y', stdinBuff') = eval env y stdinBuff in
            (env', Intersection(Language x, y'), stdinBuff')
    | Intersection(x, y) ->
        let (env', x', stdinBuff') = eval env x stdinBuff in
            (env', Intersection(x', y), stdinBuff')
    | Print x when isVal x -> let () = print_val x in
        raise Terminated
    | Print x -> let (env', x', buff') = eval env x stdinBuff in
        (env', Print x', buff')
    | PrintSome ((Language x), count) ->
        let () = print_some_language (Language x) count in
        raise Terminated
    | PrintSome (x, count) -> let (env', x', buff') = eval env x stdinBuff
        in (env', PrintSome(x', count), buff')

and stmntEvalLoop env exp stdinBuff =
    try
        let (env', exp', stdinBuff') = eval env exp stdinBuff in
            stmntEvalLoop env' exp' stdinBuff'
    with Terminated ->  (env, exp, stdinBuff);;

 let rec progEvalLoop env expList stdinBuff =
    match expList with
        | Statement (x, y) -> let (env', exp, stdinBuff') = stmntEvalLoop env x stdinBuff in stmntEvalLoop env' y stdinBuff'
        | Statement (x, Statement (y, z)) -> let (env', exp, stdinBuff') = stmntEvalLoop env x stdinBuff; in progEvalLoop env' y stdinBuff'
        | x -> stmntEvalLoop env expList stdinBuff

    ;;

let rec evalProg exp stdinBuff =
    let (env,result,_) = progEvalLoop (Env []) exp stdinBuff in
        (env, result);;
