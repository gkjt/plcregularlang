exception TypeError;;


type langType = IntType | FunType | LangType | WordType | StringType;;

type word = string;;

type langTerm =
    | Int of int
    | String of string
    | Language of word list
;;

type 'a context = Env of (string * 'a) list;;

let addBinding env name obj =
    match env with Env(e) -> Env((name, obj) :: e);;

let rec typeOf env exp =
    match exp with
    | Int(n) -> IntType
    | String(x) -> StringType
    | _ -> raise TypeError;;

let typeOfProgram exp =
    typeOf (Env[]) exp;;

let rec eval env exp =
    match exp with
    | Int x -> Int x
    | String x -> String x
    ;;

let rec evalProg exp =
    eval (Env[]) exp;;

let print_val v =
    match v with
        | Int i -> print_string "Int: "; print_int i
        | String i -> print_string "String: "; print_string i
    ;;
