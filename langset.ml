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

let rec conc v0 v1 =
    let rec aux x = (
        match x with
            | [x] -> [(v0^x)]
            | x :: y -> (v0^x) :: aux y
            ) in aux v1;;
