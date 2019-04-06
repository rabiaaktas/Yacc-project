krlang:
	lex krlang.l
	gcc -o krlang lex.yy.c -ll
clean:
	rm krlang lex.yy.c
