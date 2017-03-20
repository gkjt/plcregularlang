

link: lexer.cmo parser.cmo langlang.cmo main.cmo parser.cmi langset.cmo
	ocamlc -o langlangi bin/langlang.cmo bin/langset.cmo bin/parser.cmo bin/lexer.cmo bin/main.cmo

clean:
	@rm -rf bin
	@rm -f bin

pre:
	@mkdir -p bin
	@cp -f langset.ml bin/langset.ml
	@cp -f parser.mly bin/parser.mly
	@cp -f lexer.mll bin/lexer.mll
	@cp -f parser.mly bin/parser.mly
	@cp -f main.ml bin/main.ml
	@cp -f langlang.ml bin/langlang.ml

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

langlang.cmo: pre langset.cmo
	ocamlc -c -I bin -o bin/langlang.cmo bin/langlang.ml

langset.cmo: pre
	ocamlc -c -I bin -o bin/langset.cmo bin/langset.ml

main.cmo: pre
	ocamlc -c -I bin -o bin/main.cmo bin/main.ml
