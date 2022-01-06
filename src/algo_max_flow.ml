open Printf
open Graph
open Tools


type path = id list
type intgraph = int graph

(* Trouver path en utilisant la méthode DFS *)
let rec find_path graph path id1 id2=

  let rec loop list_arcs_s  =

    match list_arcs_s with 
    | [] -> None
    | (id , lbl)::rest-> 
      (* Si la capacité est nulle *)
      if lbl == 0 then loop rest 
      (* Si on a atteint le sink *)
      else if id == id2 then Some (List.append path [id])
      (* Si le noeud existe déja dans le path actuel *)
      else if List.exists (fun i -> i = id) path then loop rest

      else
        (* Appel recursif de find_path avec les parametres : graph , path+id , id , id2 *)
        let possible_path = find_path graph (List.append path [id] ) id id2 in
        if possible_path = None then loop rest else possible_path
  in 
  let outs = out_arcs graph id1 in
  loop outs 


(* Trouver bottleneck capacity *)
let rec get_bottleneck graph src acu = function
  (* On cherche le min des labels dans le path (id list) donné *)
  | [] -> acu
  | id :: rest -> 
    let lbl = find_arc graph src id in
    match lbl with 
    | None -> 0 
    | Some x -> get_bottleneck graph id (min acu x) rest 

(* Convertir un path en string (utilisé pour tester la fonction find path) *)
let rec aux_sop acu = function
  | [] -> acu
  | id::rest -> (aux_sop (" node " ^ (string_of_int id) ^ " -> " ^ acu) rest)

let string_of_path = function 
  | None -> "None"
  | Some p -> aux_sop "" (List.rev p)

(* Mettre à jour les flows du graph *)
let rec update graph fl src path =
  match path with 
  | [] -> graph
  | id :: rest -> 
    let inter_graph = add_arc graph src id (-fl) in
    let up_graph = add_arc inter_graph id src fl in
    update up_graph fl id rest 

(* Retourne le flow maximal *)
let get_flow_max graph id =
  (* On calcule la somme des labels des arcs sortants de l'id donné (l'id du sink) *)
  (* Ça marche dans notre cas vu la fonction update utilisé *)
  let rec sum = function
    | [] -> 0 
    | (_,lbl) :: rest -> lbl + sum rest
  in
  let outs = out_arcs graph id in
  sum outs 

(* Une fonction auxiliaire qui trouve la valeur bottleneck et met à jour le graph *)
let aux graph id path =
  let b = get_bottleneck graph id 999 path in
  update graph b id path 

(* FordFulkerson *)
(* Déroulé de l'algorithme *)
(* L'algorithme consiste à répéter ces trois étape tant qu'il y a un chemin possible : 
   1) Trouver un chemin possible entre source et sink 
   2) Calculer la valeur bottleneck
   3) Mettre à jour le graph en fonction de cette valeur

   Une fois l'algorithme terminé, on calcule le flow max

*)


let rec fordfulkerson graph n src sink =
  let () = Printf.printf "Algorithme Ford Fulkerson: iteration %d \n%!" n in
  match find_path graph [] src sink with
  | None -> Printf.printf "FLOW MAX DU GRAPH : %d " (get_flow_max graph sink); graph
  | Some path -> fordfulkerson (aux graph src path) (n+1) src sink




