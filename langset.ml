open List;;

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

let rec set_concatenate v1 v2 =
    let rec concatenate str set =
        match set with
        | [] -> []
        | [x] -> [str^x]
        | x :: y -> (str^x) :: concatenate str y
    in match v1 with
    | [] -> v2
    | [x] -> concatenate x v2
    | x :: y -> (concatenate x v2) @ (set_concatenate y v2);;

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

let rec set_star set count =
	let rec aux z count=
		if (count >= 0) then (match z with
			| [] -> []
			| [x] -> let x' = (x^(String.sub x 0 1)) in x' :: aux [x'] (count-1)
			| x :: y -> aux [x] (count-1)) else []
	in match set with
    | [] -> []
	| [x] -> "" :: x :: aux set (count - 3)
    | "" :: y -> set_star y count
    | x :: y -> "" :: x :: aux set (count - 2);;

let rec set_power set count =
	let rec aux x set' count =
		if (count > 0) then (
		(aux x (set_concatenate x set') (count - 1))) else (set_concatenate x set')
	in match count with
	| x -> aux set set (count - 2)
;;