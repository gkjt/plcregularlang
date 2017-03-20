let rec set_add set el =
    match set with
    | [] -> [el]
    | [x] -> if (compare x  el) = 0 then set else
        if (x < el) then x :: [el] else (el :: set)
    | x::y -> if (compare x  el) = 0 then set else
        if (x < el) then x :: (set_add y el) else (el :: set);;

let rec set_union set1 set2 =
    match set1 with
    | [] -> set2
    | [x] -> set_add set2 x
    | x::y -> set_union y (set_add set2 x);;

let rec prefix s v =
    let rec aux x = (
        match x with
            | [x] -> [(s^x)]
            | x :: y -> (s^x) :: aux y
            ) in aux v;;

let rec set_intersection set1 set2 =
        let rec aux2 el set2 =
            match set2 with
            | [] -> true
            | [x] -> if (x = el) then true else false
            | x :: y -> if (x = el) then true else aux2 el y
        in
        match set1 with
        | [] -> []
        | [x] -> if(aux2 x set2) then [x] else []
        | x :: y -> let res = aux2 x set2 in
            match res with
            | false -> set_intersection y set2
            | true -> x :: set_intersection y set2;;
