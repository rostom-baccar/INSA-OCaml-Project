open Graph
open Tools

let find_path graphe path id1 id2=

  let rec loop list_arc_s  =

    match list_arc_s with 
    | [] -> None
    | (id , capacite)::rest-> 
      if capacite == 0 then loop rest 
      else if id == id2 then Some (List.append path [id])

      else if List.exists (fun i -> i = id) path then loop rest

      else


