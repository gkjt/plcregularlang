let rec set_add set el =
    match set with
    | [] -> [el]
    | [x] -> if (compare x  el) = 0 then set else
        if (x < el) then x :: [el] else (el :: set)
    | x::y -> if (compare x  el) = 0 then set else
        if (x < el) then x :: (set_add y el) else (el :: set)
