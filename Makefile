IN=main.c cradle.c
OUT=main
COMPILED=test.asm
FLAGS=-Wall -Werror

compile:
	gcc -o $(OUT) $(IN) $(FLAGS)

run:
	./$(OUT) > $(COMPILED) && chmod +x $(COMPILED)

execute: 
	nasm -o out.tmp -f macho64
	 $(COMPILED) && ./out.tmp