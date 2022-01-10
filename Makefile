
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1.txt 0 5 outfile
	@echo "\n"
	#@echo "\n==== RESULT ==== (content of outfile) \n" 
	#@cat outfile 

clean:
	-rm -rf _build/
	-rm ftest.native
	-rm bipartite_test.native
dot_svg : 
	dot -Tsvg dotfile_in > Svg_files/1_graph_initial.svg
	dot -Tsvg dotfile_out > Svg_files/2_graph_final.svg
	dot -Tsvg dotfile_medium > Svg_files/graph_Medium.svg
	dot -Tsvg dotfile_medium_sol > Svg_files/graph_Medium_sol.svg
build_bip:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild bipartite_test.native

demo_bip: build_bip
	@echo "\n==== EXECUTING ====\n"
	./bipartite_test.native graphs/graph_Medium -1 -2 outfile_medium
	#@echo "\n==== RESULT ==== (content of outfile_medium) \n" 
	#@cat outfile_medium