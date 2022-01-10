open Gfile
open Tools 
open Algo_max_flow
open Printf
open Bipartite
open Graph

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Read_file test and export initial graph *)
  let graph = read_file infile in
  let graphstring = gmap graph string_of_int in 
  let () = export "dotfile_medium" graphstring in

  (* Main application test and export result graph *)
  let graphsol = book_to_person infile outfile in 
  let graphsolstring = gmap graphsol string_of_int in 
  let () = export "dotfile_medium_sol" graphsolstring in
  
  let () = write_file outfile graphsolstring in

  ()