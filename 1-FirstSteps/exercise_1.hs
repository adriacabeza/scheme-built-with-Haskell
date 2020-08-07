module Main where
import System.Environment

main :: IO()
main = do
	args <- getArgs
	putStrLn ("I love " ++ args !! 0 ++ " and " ++ args !! 1)
