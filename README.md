<h1 align="center"> 👷🏾‍♂️Implementing a toy compiler from scratch</h1>

[![GitHub stars](https://img.shields.io/github/stars/adriacabeza/compiler-from-scratch?style=social&label=Star&maxAge=2592000)](https://GitHub.com/adriacabeza/compiler-from-scratch/stargazers/)
 
This is just a toy to learn more about compilers, based on the [Let's Build a Compiler](https://compilers.iecc.com/crenshaw/tutor1.txt) by by Jack W. Crenshaw and [Compiler Basics](http://www.cs.man.ac.uk/~pjj/farrell/compmain.html) by James Alan Farrell. 

<p align="center"><img src="http://www.cs.man.ac.uk/~pjj/farrell/cmpgif01.gif"/></p>



## Requirements
 If you are lazy, you can use the Dockerfile. 


## Front end of the compiler
### Lexer

First we have to define the lexical analysis phase of compilation, this process is commonly known as tokenization. So we will be converting the source file characters stream of our language into a list identifying the token type. You can find it in [**lexer**]() 

### Parser

Then we have to define the rules to parse a token stream produced by the lexer to produce intermediate code in the form of a list of abstract syntax trees. This part of the compiler has an understanding of the language's grammar. It is responsible for indentifying syntax errors. Here we will have to take into account different types of structures that we want to create: assignment statments, code blocks, if statements, for loops, goto statements, procedure calls...

You can find it in [**parser**](). 


## Back end of the compiler
### Encoder

The intermediate code that was generated using the parser has to be translated into "von Neumann type" assembly language. You cand find it in [**encoder**]() 

### Assembler 

Finally, we have to assembly the relocatable code into code containing absolute addresses. 
You cand find it in [**assembler**]() 
