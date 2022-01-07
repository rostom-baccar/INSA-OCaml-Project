open Printf
open Graph
open Tools

(* path = liste de différents noeuds *)
type path = id list
type intgraph = int graph

val find_path : intgraph -> id list -> id -> id -> path option

val string_of_path : path option -> string 

val fordfulkerson : intgraph -> int -> int -> id -> id -> int*intgraph

val get_flow_result : int*intgraph -> int 

val get_graph_result : int*intgraph -> intgraph


