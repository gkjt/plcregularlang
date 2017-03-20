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
    let rec aux1 x z = (
        match x with
            | [x] -> [(x^z)]
            | x :: y -> (x^z) :: aux1 y z
	) in
	let rec aux2 x = (
		match x with
			| [x] -> aux1 v1 x
			| x :: y -> aux1 v1 x :: aux2 y
	) in aux2 v2;;
    
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
>>>>>>> refs/remotes/origin/master
