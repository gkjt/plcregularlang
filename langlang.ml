exception TypeError;;



type langType = IntType | FunType | LangType | WordType;;

type langTerm =
    | Int of int;;

type 'a context = Env of (string * 'a) list;;

let addBinding env name obj =
    match env with Env(e) -> Env((name, obj) :: e);;

let rec typeOf env exp =
    match exp with
    | Int(n) -> IntType
    | _ -> raise TypeError;;

let typeOfProgram exp =
    typeOf (Env[]) exp;;

let rec eval env exp =
    match exp with
    Int x -> Int x
    ;;

let rec evalProg exp =
    eval (Env[]) exp;;

let print_val v =
    match v with
        Int i -> print_string "Int: "; print_int i
    ;;
