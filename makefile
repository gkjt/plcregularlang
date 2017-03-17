link: lexer.cmo parser.cmo langlang.cmo main.cmo parser.cmi
	ocamlc -o langlangi langlang.cmo parser.cmo lexer.cmo main.cmo

clean:
	rm -rf bin

pre:
	mkdir -p bin

lexer: pre parser
	ocamllex lexer.mll -o bin/lexer.ml

parser: pre
	ocamlyacc -b bin/parser parser.mly

lexer.cmo: lexer
	ocamlc -c -o bin/lexer.cmo bin/lexer.ml

parser.cmi: parser
	ocamlc -c -o bin/parser.cmi bin/parser.mli

parser.cmo: parser
	ocamlc -c -o bin/parser.cmo parser.ml

langlang.cmo:
	ocamlc -c -o bin/langlang.cmo langlang.ml

main.cmo:
	ocamlc -c -o bin/main.cmo main.ml
