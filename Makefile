IN=main.c cradle.c
OUT=main
COMPILED=assembly.s
EXECUTABLE=out
FLAGS=-Wall -Werror

all : compile run assemble

compile:
	gcc -o $(OUT) $(IN) $(FLAGS)

run:
	./$(OUT) > $(COMPILED)

assemble: 
	gcc -m32 $(COMPILED) -o $(EXECUTABLE) && chmod +x $(EXECUTABLE)
	 