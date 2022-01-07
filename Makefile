
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

dot_svg : 
	dot -Tsvg dotfile > Svg_files/graph.svg
