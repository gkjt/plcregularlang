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

let rec conc v1 v2 =
    let rec aux1 x = (
        match x with
            | [x] -> [(v1^x)]
            | x :: y -> (v1^x) :: aux1 y
            ) in let rec aux2 x = (
				| [x] -> aux1 x
				| x :: y -> aux1 x :: aux2 y
			) in aux2 v2;;