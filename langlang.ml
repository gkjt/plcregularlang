exception TypeError;;



type langType = IntType | FunType | LangType | WordType;;

type langTerm =
    | Int of int;;

type 'a context = Env of (string * 'a) list;;

let addBinding env name obj =
    match env with Env(e) -> Env((name, obj) :: e);;

let rec typeOf env e =
    match e with
    | Int(n) -> IntType
    | _ -> raise TypeError;;
