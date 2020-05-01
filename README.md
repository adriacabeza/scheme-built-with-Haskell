<h1 align="center"> 👷🏾‍♂️Implementing a toy compiler from scratch</h1>

[![GitHub stars](https://img.shields.io/github/stars/adriacabeza/compiler-from-scratch?style=social&label=Star&maxAge=2592000)](https://GitHub.com/adriacabeza/compiler-from-scratch/stargazers/)
 
This is just a toy to learn more about compilers, based on the [Let's Build a Compiler](https://compilers.iecc.com/crenshaw/tutor1.txt) by by Jack W. Crenshaw and [Compiler Basics](http://www.cs.man.ac.uk/~pjj/farrell/compmain.html) by James Alan Farrell. It takes C and compiles it to x86. Note that this is just a toy to learn, not planning to make it very efficent or difficult, just want to make it work.  

[NOT FINISHED THO]

## Requirements
Just gcc and a text editor.

## This compiler is capable of
- Work
- Deal with numbers and basic arithmetic operations: add, sum, division and multiplication
- Using the stack in order not to run out of registers. 


## Structure
<p align="center"><img src="http://www.cs.man.ac.uk/~pjj/farrell/cmpgif01.gif"/></p>
Normally a compiler is separated by different parts:
- Front end of the compiler
	- Lexer: it makes the lexical analysis of compilation, this process is commonly known as tokenization. It converts the source file characters stream of our language into a list identifying the token type. 
	- Parser: it consists in different rules to parse a token stream produced by the lexer to produce intermediate code in the form of a list of abstract syntax trees. This part of the compiler has an understanding of the language's grammar. It is responsible for indentifying syntax errors. This step is very important for the different types of structures that are being created: assignment statments, code blocks, if statements, for loops, goto statements, procedure calls...

- Back end of the compiler
	- Encoder: The intermediate code that was generated using the parser has to be translated into some kind of assembly language. This is done by the encoder.  
	- Assembler: Finally the assembler relocates code into code containing absolute addresses. 

However, since this is a toy compiler, I'll just keep everything together just like Jack W. Crenshaw does for Turbo Pascal. 

## Usage
Just use the [Makefile](./Makefile)



