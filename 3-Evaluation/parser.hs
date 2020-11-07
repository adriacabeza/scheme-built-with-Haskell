module Main where
import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment
import Control.Monad (liftM)

symbol :: Parser Char
symbol = oneOf "!$%&|*+-/:<=>?@^_~"

spaces :: Parser ()
spaces = skipMany1 space

readExpr:: String -> LispVal
readExpr input = case parse parseExpr "lisp" input of 
	Left err -> String $ "No match: " ++ show err
	Right val -> val

main :: IO()
main = getArgs >>= print . eval . readExpr . head


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
		return $  Atom atom 

parseBool :: Parser LispVal
parseBool = do
    char '#'
    (char 't' >> return (Bool True)) <|> (char 'f' >> return (Bool False))


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
		 <|> parseBool
         <|> parseQuoted
         <|> do char '('
                x <- try parseList <|> parseDottedList
                char ')'
                return x					  

parseList :: Parser LispVal
parseList = liftM List $ sepBy parseExpr spaces

parseDottedList :: Parser LispVal
parseDottedList = do
	head <- endBy parseExpr spaces
	tail <- char '.' >> spaces >> parseExpr
	return $ DottedList head tail

parseQuoted :: Parser LispVal
parseQuoted = do
    char '\''
    x <- parseExpr
    return $ List [Atom "quote", x]

data LispVal = Atom String
	| List [LispVal]
	| DottedList [LispVal] LispVal
	| Number Integer
	| String String
	| Bool Bool 
	| Char Char
	| Float Double


unwordsList :: [LispVal] -> String
unwordsList = unwords . map showVal

showVal :: LispVal -> String
showVal (String contents) = "\"" ++ contents ++ "\""
showVal (Atom name) = name
showVal (Number contents) = show contents
showVal (Bool True) = "#t"
showVal (Bool False) = "#f"
showVal (List contents) = "(" ++ unwordsList contents ++ ")"
showVal (DottedList head tail) = "(" ++ unwordsList head ++ " . " ++ showVal tail ++ ")"

instance Show LispVal where show = showVal

eval :: LispVal -> LispVal
eval val@(String _) = val
eval val@(Number _) = val
eval val@(Bool _) = val
eval (List [Atom "quote", val]) = val
eval (List (Atom func : args)) = apply func $ map eval args


apply :: String -> [LispVal] -> LispVal
apply func args = maybe (Bool False) ($ args) $ lookup func primitives

primitives :: [(String, [LispVal] -> LispVal)]
primitives = [("+", numericBinop (+)),
              ("-", numericBinop (-)),
              ("*", numericBinop (*)),
              ("/", numericBinop div),
              ("mod", numericBinop mod),
              ("quotient", numericBinop quot),
              ("remainder", numericBinop rem),
			  ("symbol?", unaryOp symbolp),
			  ("stringp?", unaryOp stringp),
			  ("number?", unaryOp numberp),
			  ("bool?", unaryOp boolp),
			  ("list?", unaryOp listp)]

unaryOp :: (LispVal -> LispVal) -> [LispVal] -> LispVal
unaryOp f [v] = f v

symbolp, numberp, stringp, boolp, listp :: LispVal -> LispVal
symbolp (Atom _)   = Bool True
symbolp _          = Bool False
numberp (Number _) = Bool True
numberp _          = Bool False
stringp (String _) = Bool True
stringp _          = Bool False
boolp   (Bool _)   = Bool True
boolp   _          = Bool False
listp   (List _)   = Bool True
listp   (DottedList _ _) = Bool False
listp   _          = Bool False


numericBinop :: (Integer -> Integer -> Integer) -> [LispVal] -> LispVal
numericBinop op params = Number $ foldl1 op $ map unpackNum params

unpackNum :: LispVal -> Integer
unpackNum (Number n) = n
unpackNum _ = 0