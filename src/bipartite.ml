open Graph 
open Tools
open Gfile
open Algo_max_flow
open Printf


(*Noeud origine*)
let source = (1000)
(*Noeud destination*)
let sink = (2000)

(*Read_person lit chaque personne et crée un noeud dont le label est celui de la personne, et connecte ce noeud à l'origine avec une capacité 1
pour chaque arc*)
let read_person graph line = 
  try 
    Scanf.sscanf line "person %d" (fun person -> new_arc (new_node graph person) source person 1) 
  with e ->
    Printf.printf "Impossible to read person in line : \n%s\n" line ; 
    failwith "from_file"


(*Read_book lit chaque livre et crée un noeud dont le label est celui du livre, et connecte ce noeud à la destination avec une capacité 1
pour chaque arc*)
let read_book graph line =
  try 
    Scanf.sscanf line "book %d" (fun book -> new_arc (new_node graph book) book sink 1)
  with e ->
    Printf.printf "Impossible to read book in line : \n%s\n" line ; 
    failwith "from_file"


(*Read_wants_to_read lit chaque association entre personne et livre et crée un arc entre la personne (1er argument) et le livre
(2ème argument, avec une capacité 1 pour chaque arc*)
let read_wants_to_read graph line = 
  try 
    Scanf.sscanf line "read %d %d" (fun person book -> new_arc graph person book 1) 
  with e ->
    Printf.printf "Impossible to read wants in line : \n%s\n" line ; 
    failwith "from_file"

    
(*Read_comment identifie un commentaire pour simplement l'ignorer*)
let read_comment graph line =
  try
    Scanf.sscanf line "%%" graph
  with _ ->
    Printf.printf "Unknown line : \n%s\n" line ; 
    failwith "from_file"


(*Read_file utilise les fonctions précedemment définies pour créer le graphe sur lequel on appliquera l'algorithme Ford Fulkerson*)
let read_file file =
  let open_file = open_in file in 
  let init_graph = new_node (new_node empty_graph source) sink in

  (*Boucle lisant toutes les lignes du fichier*)
  let rec loop graph =
    try
      let line = input_line open_file in 
      (* On enlève les espaces*)
      let line = String.trim line in
      let graph_inter = 
        (* On ignore les lignes où il n'y a pas de texte*)
        if line = "" then graph

        else match line.[0] with 
          | 'p' -> read_person graph line
          | 'b' -> read_book graph line
          | 'r' -> read_wants_to_read graph line
          | _ -> read_comment graph line
      in
      loop graph_inter

    with End_of_file -> graph 
  in
  let out = loop init_graph in
  close_in open_file ;
  out

(*Fordfulkerson_books lit le fichier qui contient les information sur les personnes et les books, construit le graph et applique 
l'algorithme fordfulkerson *)
let fordfulkerson_books file =
  let graph1= read_file file in 
  let (fl_max, fl_graph) = fordfulkerson graph1 0 0 source sink in 
  (fl_max, fl_graph)


(*Add_person_id prend une liste et une ligne et lit la personne qui se trouve sur cette ligne *)
let get_list_of_people_aux list line =
  try 
    Scanf.sscanf line "person %d" (fun id -> List.append list [id]) 
  with e ->
    Printf.printf "Impossible to read person in line : \n%s\n" line ; 
    failwith "from_file" 


(*Get_list_of_people retourne la liste des personnes dans un graph *)
let get_list_of_people file =
  let open_file = open_in file in 
  let init_list = [] in 

  let rec loop list =
    try
      let line = input_line open_file in 
      let line = String.trim line in
      let list_aux = 
        if line = "" then list
        else match line.[0] with 
          | 'p' -> get_list_of_people_aux list line
          | _ -> list
      in
      loop list_aux
    with End_of_file -> list 
  in
  let out = loop init_list in
  close_in open_file ;
  out


(*Is_person vérifie si l'id donnée est une id de personne*)
let rec is_person id = function 
  | [] -> false 
  | x :: rest -> if (x==id) then true else (is_person id rest)

(*Solution_found donne le texte qui va être affiché  *)
let solution_found = fun id1 id2 lbl list ->
  if (id1=source) then "Person " ^ (string_of_int id2) ^ " -> No Book \n"
  else if (id2=sink) then "Book " ^ (string_of_int id1) ^ " -> No Person \n"
  else "Person " ^ (string_of_int id2) ^ " -> Book " ^ (string_of_int id1) ^ " \n"


(*Aux affiche la solution *)
let aux file graph people_list =

  let out = open_out file in 
  Printf.printf "?? Which person will get which book ?? \n \n" ;

  e_iter graph (fun id1 id2 lbl -> if ((lbl <> 0) && (id2 <> source) && (id1 <> sink) && (not(is_person id1 people_list)) ) 
   then Printf.printf "%s \n" (solution_found id1 id2 lbl people_list)) ;

  close_out out ; 
  ()

(*Book_to_person est la fonction principale*)
let book_to_person infile outfile = 
  let people = get_list_of_people infile in 
  let (fl_max, fl_graph) = fordfulkerson_books infile in 
  let () = aux outfile fl_graph people in 

  fl_graph ;