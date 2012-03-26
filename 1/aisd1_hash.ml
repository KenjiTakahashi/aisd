(** ocamlopt -ccopt -static -w A *)
let (n, m) = Scanf.scanf "%d %d\n" (fun x -> fun y -> (x, y));;
let arr = Array.make n "";;
for i = 0 to n - 1 do
    arr.(i) <- Scanf.scanf "%s\n" (fun x -> x)
done;;
let result = ref 0;;
let marks = Hashtbl.create (n * m);;
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
    let queue = Queue.create () in
    (
        Queue.add source queue;
        Hashtbl.add marks source 1;
        while not(Queue.is_empty queue) do
            let v = Queue.take queue in
            let e = find_incidents v in
            for i = 0 to List.length e - 1 do
                let incident = List.nth e i in
                try
                    let _ = Hashtbl.find marks incident in ()
                with
                Not_found ->
                    (
                        Hashtbl.add marks incident 1;
                        Queue.add incident queue
                    )
            done
        done
    )
;;
for i = 0 to n - 1 do
    for j = 0 to m - 1 do
        if arr.(i).[j] != 'A' then
            try
                let _ = Hashtbl.find marks (i, j) in ()
            with
            Not_found ->
                (
                    bfs (i, j);
                    result := !result + 1
                )
    done
done;;

print_endline (string_of_int !result)
