import Prelude hiding ((<*>), (<*), (*>))
import Data.List
import Data.Char

main = return ()

type Parser a b = [a] -> [ ([a], b) ]

satisfy :: (s -> Bool) -> Parser s s
satisfy p [] = []
satisfy p (x:xs) = [ (xs, x) | p x ]

symbol :: Eq s => s -> Parser s s
symbol a = satisfy (\x -> a == x)

token :: Eq s => [s] -> Parser s [s]
token k xs
    | k == take n xs = [ (drop n xs, k) ]
    | otherwise      = []
        where n = length k


succeed :: r -> Parser s r
succeed v xs = [ ( xs, v ) ]

epsilon :: Parser s ()
epsilon = succeed ()

fail :: Parser s r
fail _ = []

infixr 6 <*> , <* , *>
infixr 5 <@
infixr 4 <|>

(<*>) :: Parser s a -> Parser s b -> Parser s (a, b)
(p1 <*> p2) xs = [ (xs2, (v1, v2))
                 | (xs1, v1) <- p1 xs
                 , (xs2, v2) <- p2 xs1
                 ]

(<|>) :: Parser s a -> Parser s a -> Parser s a
(p1 <|> p2) xs = p1 xs ++ p2 xs

sp :: Parser Char a -> Parser Char a
sp = ( .dropWhile (== ' '))

just :: Parser s a -> Parser s a
just p = filter (null.fst) . p

(<@) :: Parser s a -> (a -> b) -> Parser s b
(p <@ f) xs = [ (ys, f v)
              | (ys, v) <- p xs
              ]

digit :: Parser Char Int
digit = satisfy isDigit <@ digitToInt

type DetParser symbol result = [symbol] -> result

some :: Parser s a -> DetParser s a
some p = snd.head.just p

data Tree = Nil | Bin (Tree, Tree) deriving Show

(<*) :: Parser s a -> Parser s b -> Parser s a
p <* q = p <*> q <@ fst


(*>) :: Parser s a -> Parser s b -> Parser s b
p *> q = p <*> q <@ snd

openb  = symbol '('
closeb = symbol ')'

foldparens :: ((a, a) -> a) -> a -> Parser Char a
foldparens f e = p
    where p = (openb *> p <* closeb) <*> p <@ f <|> succeed e

nesting :: Parser Char Int
nesting = foldparens (\(x,y) -> (1+x) `max` y) 0


parens :: Parser Char Tree
parens = foldparens Bin Nil
