open Printf
open Gfile
open Tools
open Algo_max_flow

let () =


  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  (* gmap Test *)
  (*let f x = string_of_int(2*(int_of_string x)) in
    let graph1 = gmap graph f in *)

  let graphint = gmap graph int_of_string in

  let graphford = get_graph_result(fordfulkerson graphint 0 0 source sink)  in 

  let graphout = gmap graphford string_of_int in

  let () = export "dotfile" graphout in 

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graphout in

  ()

