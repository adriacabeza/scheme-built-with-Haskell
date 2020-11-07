<h1 align="center"> 👷🏾‍♂️Implementing a Scheme with Haskell</h1>

[![made-with-Haskell](https://img.shields.io/badge/Made%20with-Haskell-ff425f.svg)](http://commonmark.org) 
> Following this book: https://en.wikibooks.org/wiki/Write_Yourself_a_Scheme_in_48_Hours (not finished tho)

Toy repository I resort to when I randomly restore my dream of becoming a Haskell wizard. Ngl, that feeling usually vanishes fast. 

It already does a bunch of things though:

```bash 
> ghc --make -o parser parser.hs
> ./parser "(* 23 2 4)"
184
> ./parser "\"a string\""
"a string"
> ./parser "(- (+ 4 6 3) 3 5 2)"
3
> ./parser "(number? 4)"
#t
> ./parser "(mod 4 3)"
1
```



