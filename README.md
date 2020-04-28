<h1 align="center"> 👷🏾‍♂️Prologpiler: Implementing a toy compiler using Prolog.</h1>

          
This is just a toy to learn more about compilers, based on "Logic Programming and Compiler Writing" by D.H.D. Warren and [Compiler Basics](http://www.cs.man.ac.uk/~pjj/farrell/compmain.html) by James Alan Farrell. The idea is to create a simple C-like language that I am gonna call **Drien**.

<p align="center"><img src="http://www.cs.man.ac.uk/~pjj/farrell/cmpgif01.gif"/></p>

## Front end of the compiler
### Lexer

First we have to define the lexical analysis phase of compilation, this process is commonly known as tokenization. So we will be converting the source file characters stream of our language into a Prolog list identifying the token type.  

You can find it in [**lexer.pl**](lexer.pl)

### Parser

Then we have to define Prolog rules to parse a token stream produced by the lexer to produce intermediate code in the form of a list of abstract syntax trees. This part of the compiler has an understanding of the language's grammar. It is responsible for indentifying syntax errors. Here we will have to take into account different types of structures that we want to create: assignment statments, code blocks, if statements, for loops, goto statements, procedure calls...

You can find it in [**parser.pl**](parser.pl)


## Back end of the compiler
### Encoder

The intermediate code that was generated using the parser has to be translated into "von Neumann type" assembly language. 

You can find it in [**encoder.pl**](encoder.pl)

### Assembler 

Finally, we have to assembly the relocatable code into code containing absolute addresses. 

You can find it in [**assembler.pl**](assembler.pl)
