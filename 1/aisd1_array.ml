(** ocamlopt -ccopt -static -w A *)
let (n, m) = Scanf.scanf "%d %d\n" (fun x -> fun y -> (x, y));;
let arr = Array.make n "";;
for i = 0 to n - 1 do
    Scanf.scanf "%s\n" (fun x -> arr.(i) <- x)
done;;
let result = ref 0;;
let marks = Array.make_matrix n m 0;;
let find_incidents (i, j) =
    match arr.(i).[j] with
    |'A' -> []
    |'B' ->
            let out = ref [] in
            (
                (try
                        match arr.(i).[j - 1] with
                        |'D' -> out := (i, j - 1)::!out
                        |'E' -> out := (i, j - 1)::!out
                        |'F' -> out := (i, j - 1)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                ); (try
                        match arr.(i + 1).[j] with
                        |'C' -> out := (i + 1, j)::!out
                        |'D' -> out := (i + 1, j)::!out
                        |'F' -> out := (i + 1, j)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                )
            );
            !out
    |'C' ->
            let out = ref [] in
            (
                (try
                        match arr.(i).[j - 1] with
                        |'D' -> out := (i, j - 1)::!out
                        |'E' -> out := (i, j - 1)::!out
                        |'F' -> out := (i, j - 1)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                ); (try
                        match arr.(i - 1).[j] with
                        |'B' -> out := (i - 1, j)::!out
                        |'E' -> out := (i - 1, j)::!out
                        |'F' -> out := (i - 1, j)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                )
            );
            !out
    |'D' ->
            let out = ref [] in
            (
                (try
                        match arr.(i).[j + 1] with
                        |'B' -> out := (i, j + 1)::!out
                        |'C' -> out := (i, j + 1)::!out
                        |'F' -> out := (i, j + 1)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                ); (try
                        match arr.(i - 1).[j] with
                        |'B' -> out := (i - 1, j)::!out
                        |'E' -> out := (i - 1, j)::!out
                        |'F' -> out := (i - 1, j)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                )
            );
            !out
    |'E' ->
            let out = ref [] in
            (
                (try
                        match arr.(i).[j + 1] with
                        |'B' -> out := (i, j + 1)::!out
                        |'C' -> out := (i, j + 1)::!out
                        |'F' -> out := (i, j + 1)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                ); (try
                        match arr.(i + 1).[j] with
                        |'C' -> out := (i + 1, j)::!out
                        |'D' -> out := (i + 1, j)::!out
                        |'F' -> out := (i + 1, j)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                )
            );
            !out
    |'F' ->
            let out = ref [] in
            (
                (try
                        match arr.(i).[j + 1] with
                        |'B' -> out := (i, j + 1)::!out
                        |'C' -> out := (i, j + 1)::!out
                        |'F' -> out := (i, j + 1)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                ); (try
                        match arr.(i + 1).[j] with
                        |'C' -> out := (i + 1, j)::!out
                        |'D' -> out := (i + 1, j)::!out
                        |'F' -> out := (i + 1, j)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                ); (try
                        match arr.(i).[j - 1] with
                        |'E' -> out := (i, j - 1)::!out
                        |'D' -> out := (i, j - 1)::!out
                        |'F' -> out := (i, j - 1)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                ); (try
                        match arr.(i - 1).[j] with
                        |'B' -> out := (i - 1, j)::!out
                        |'E' -> out := (i - 1, j)::!out
                        |'F' -> out := (i - 1, j)::!out
                        |_ -> ()
                    with
                    Invalid_argument _ -> ()
                )
            );
            !out
    |_ -> failwith "wrong input"
;;
let bfs source =
    let stack = Stack.create () in
    (
        Stack.push source stack;
        let (i, j) = source in
        marks.(i).(j) <- 1;
        while not(Stack.is_empty stack) do
            let rec traverse l =
                match l with
                |[] -> ()
                |(inci, dent)::t ->
                        (
                            if marks.(inci).(dent) = 0 then
                                (
                                    marks.(inci).(dent) <- 1;
                                    Stack.push (inci, dent) stack
                                )
                        );
                        traverse t
            in traverse (find_incidents (Stack.pop stack))
        done
    )
;;
for i = 0 to n - 1 do
    for j = 0 to m - 1 do
        if arr.(i).[j] != 'A' && marks.(i).(j) = 0 then
                (
                    bfs (i, j);
                    result := !result + 1
                )
    done
done;;

print_endline (string_of_int !result)
