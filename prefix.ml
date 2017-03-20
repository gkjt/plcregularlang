let rec prefix v =
    let rec aux x = (
        match x with
            | [x] -> ("a"^x)
            | x :: y -> ("a"^x) :: aux y
            ) in
                match v with
                    | Language [] -> Language []
                    | Language x -> Language [aux x]
;;