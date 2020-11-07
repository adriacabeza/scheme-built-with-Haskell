<h1 align="center"> 👷🏾‍♂️Implementing a Scheme with Haskell</h1>

[![made-with-Haskell](https://img.shields.io/badge/Made%20with-Haskell-1f425f.svg)](http://commonmark.org) [![GitHub stars](https://img.shields.io/github/stars/adriacabeza/compiler-from-scratch?style=social&label=Star&maxAge=2592000)](https://GitHub.com/adriacabeza/compiler-from-scratch/stargazers/)


It's been so long my friend Haskell...

> Following this book: https://en.wikibooks.org/wiki/Write_Yourself_a_Scheme_in_48_Hours (not finished tho)

It already does a bunch of things:

```
bash 
ghc --make -o parser parser.hs
./parser "(* 23 2 4)"
184
./parser "\"a string\""
"a string"
./parser "(- (+ 4 6 3) 3 5 2)"
3
./parser "(number? 4)"
#t
./parser "(mod 4 3)"
1
```



