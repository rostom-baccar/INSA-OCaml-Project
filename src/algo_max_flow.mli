open Printf
open Graph
open Tools

(* path = liste de différents noeuds *)
type path = id list
type intgraph = int graph

val find_path : intgraph -> id list -> id -> id -> path option

val string_of_path : path option -> string 

val aux_sop : string -> path -> string 

val update : intgraph -> int -> id -> path -> intgraph

val get_bottleneck : intgraph -> id -> int -> path -> int

val get_flow_max : intgraph -> int -> int 

val aux : intgraph -> id -> path -> intgraph

val fordfulkerson : intgraph -> int -> id -> id -> intgraph


