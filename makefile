

link: lexer.cmo parser.cmo langlang.cmo main.cmo parser.cmi
	ocamlc -o langlangi langlang.cmo parser.cmo lexer.cmo main.cmo

clean:
	@rm -rf bin
	@rm -f bin

pre:
	@mkdir -p bin
	cp -f parser.mly bin/parser.mly
	cp -f lexer.mll bin/lexer.mll
	cp -f parser.mly bin/parser.mly
	cp -f main.ml bin/main.ml
	cp -f langlang.ml bin/langlang.ml

lexer: pre parser
	ocamllex bin/lexer.mll -o bin/lexer.ml

parser: pre
	ocamlyacc -b bin/parser bin/parser.mly

lexer.cmo: lexer parser.cmi parser.cmo
	ocamlc -c -I bin -o bin/lexer.cmo bin/lexer.ml

parser.cmi: parser langlang.cmo
	ocamlc -c -I bin -o bin/parser.cmi bin/parser.mli

parser.cmo: parser
	ocamlc -c -I bin -o bin/parser.cmo bin/parser.ml

langlang.cmo: pre
	ocamlc -c -I bin -o bin/langlang.cmo bin/langlang.ml

main.cmo: pre
	ocamlc -c -I bin -o bin/main.cmo bin/main.ml
