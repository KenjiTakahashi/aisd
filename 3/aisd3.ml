(** ocamlopt -ccopt -static -w A *)
Scanf.scanf "%d %d %d\n" (fun l -> fun n -> fun b ->
    let func arr st sp l =
        while !st < sp && arr.(!st).(0) + b < l do
            st := !st + 1
        done;
        if !st = sp then
            print_endline "-1"
        else
            print_endline (string_of_int arr.(!st).(1))
    and arr = Array.make_matrix (n + 1) 2 0
    and s = Stream.of_channel stdin
    and aux s =
        let numberize s =
            let rec aux s o m =
                match s with
                |hd::tl -> aux tl (o + m * hd) (m * 10)
                |_ -> o
            in aux s 0 1
            and convert c =
                match c with
                |'0' -> 0
                |'1' -> 1
                |'2' -> 2
                |'3' -> 3
                |'4' -> 4
                |'5' -> 5
                |'6' -> 6
                |'7' -> 7
                |'8' -> 8
                |'9' -> 9
                |_ -> failwith "wrong" (* should never happen *)
                in let rec auxx c s1 s2 =
                    match c with
                    |' ' -> auxx (Stream.next s) s2 s1
                    |'\n' -> (numberize s2, numberize s1)
                    |c -> auxx (Stream.next s) ((convert c)::s1) s2
                in auxx (Stream.next s) [] []
    and st = ref 0 and sp = ref 1 in
    try
        let rec loop i s =
            if i < n then
                let (d, c) = aux s in
                if d < l then (
                    while !st < !sp && arr.(!st).(0) + b < d do
                        st := !st + 1
                    done;
                    if !st = !sp then
                        print_endline "-1"
                    else
                        let res = c + arr.(!st).(1) in
                        while !st < !sp && arr.(!sp - 1).(1) >= res do
                            sp := !sp - 1
                        done;
                        arr.(!sp).(0) <- d;
                        arr.(!sp).(1) <- res;
                        sp := !sp + 1;
                        loop (i + 1) s
                ) else
                    func arr st !sp l
            else
                func arr st !sp l
        in loop 0 s
    with Stream.Failure -> func arr st !sp l
)
