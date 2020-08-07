module Main where
import System.Environment

main :: IO()
main = do
	args <- getArgs
	putStrLn("What is your name?")
	line <- getLine
	putStrLn("Hi, nice to meet you " ++ line)
