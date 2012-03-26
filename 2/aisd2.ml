(** ocamlopt -ccopt -static -w A *)
let n = Scanf.scanf "%d\n" (fun x -> x) in
let number = [|0; 1; 1; 2; 1; 2; 2; 3|] in
let check hash var i tab =
    let rec check_a hash =
        match hash with
        |(key, value)::tl ->
                (
                    let rec check_aux vv =
                        match vv with
                        |elem::tl ->
                                (
                                    if elem land var = elem then
                                        let res = tab.((i - 1) mod 2).(key) + number.(elem) and
                                        address = (((key land 1) lsl 3) + ((key land 2) lsl
                                        3) + ((key land 4) lsl 3)) lor elem in
                                        if tab.(i mod 2).(address) < res then
                                            tab.(i mod 2).(address) <- res
                                );
                                check_aux tl
                        |[] -> ()
                    in check_aux value;
                );
                check_a tl
        |[] -> ()
    in check_a hash
and
tab = Array.make_matrix 2 64 0 and
hash = [
    (58, [0]);
    (56, [0]);
    (54, [0]);
    (52, [0]);
    (50, [0]);
    (48, [0]);
    (42, [0; 1; 4; 5]);
    (40, [0; 1; 4; 5]);
    (38, [0; 4]);
    (36, [0; 4]);
    (34, [0; 1; 4; 5]);
    (32, [0; 1; 4; 5]);
    (27, [0]);
    (26, [0]);
    (25, [0]);
    (24, [0]);
    (23, [0; 2]);
    (22, [0; 2]);
    (21, [0; 2]);
    (20, [0; 2]);
    (19, [0; 2]);
    (18, [0; 2]);
    (17, [0; 2]);
    (16, [0; 2]);
    (11, [0; 1]);
    (10, [0; 1; 4; 5]);
    (9, [0; 1]);
    (8, [0; 1; 4; 5]);
    (7, [0; 2]);
    (6, [0; 2; 4; 6]);
    (5, [0; 2]);
    (4, [0; 2; 4; 6]);
    (3, [0; 1; 2; 3]);
    (2, [0; 1; 2; 3; 4; 5; 6; 7]);
    (1, [0; 1; 2; 3]);
    (0, [0; 1; 2; 3; 4; 5; 6; 7])
] in
for i = 1 to n do
    Scanf.scanf "%s\n"
    (fun x ->
        let var = ref 0 in
        (if x.[0] = '.' then var := !var + 1);
        (if x.[1] = '.' then var := !var + 2);
        (if x.[2] = '.' then var := !var + 4);
        check hash !var i tab
    )
done;
Array.fast_sort compare tab.(n mod 2);
print_endline (string_of_int tab.(n mod 2).(63))
