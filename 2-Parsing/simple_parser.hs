module Main where
import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment
import Control.Monad (liftM)


symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

spaces :: Parser ()
spaces = skipMany1 space

readExpr:: String -> String
readExpr input = case parse parseExpr  "lisp" input of 
	Left err -> "No match: " ++ show err
	Right val -> "Found value"

main :: IO()
main = do
	(expr:_) <- getArgs
	putStrLn (readExpr expr)

parseString :: Parser LispVal
parseString = do
		char '"'
		x <- many $ escapedChars <|> (noneOf ['\\', '"'])
		char '"'
		return $ String x

escapedChars :: Parser Char
escapedChars = do
				char '\\'
				c <- oneOf ['\\', '"', 'n', 'r', 't']
				return $ case c of 
					'\\' -> c
					'"' -> c
					'n' -> '\n'
					'r' -> '\r'
					't' -> '\t'


parseAtom :: Parser LispVal
parseAtom = do 
		first <- letter <|> symbol
		rest <- many (letter <|> digit <|> symbol)
		let atom = first:rest
		return $ case atom of
			"#t" -> Bool True
			"#f" -> Bool False
			_ -> Atom atom 

parseNumber :: Parser LispVal
-- parseNumber = do
-- 			numbers <- many1 digit
-- 			return $ (Number . read) $ numbers
parseNumber = (many1 digit) >>= (\x -> return ((Number . read) x))

parseFloat :: Parser LispVal
parseFloat = do
           whole <- many1 digit
           char '.'
           decimal <- many1 digit
           return $ Float (read (whole++"."++decimal) :: Double)

parseExpr :: Parser LispVal
parseExpr = parseAtom 
	<|> parseString
	<|> try parseFloat
	<|> parseNumber


data LispVal = Atom String
	| List [LispVal]
	| DottedList [LispVal] LispVal
	| Number Integer
	| String String
	| Bool Bool 
	| Char Char
	| Float Double
