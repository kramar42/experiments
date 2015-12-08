import Data.Char

--main = readFile "input.txt" >>= return.reverse >>= writeFile "output.txt"

main = putStrLn "name" >> getLine >>= putStrLn . ("Hi " ++)

pf = (+ 5) . (/ 8)

facA :: Integer -> Integer
facA n = if n == 1 then 1 else n * facA (n - 1)

facB :: Integer -> Integer
facB n = product [2..n]

zipTogether [] xs = []
zipTogether xs [] = []
zipTogether (x:xs) (y:ys) = (x, y) : zipTogether xs ys

cipher :: String -> Int -> String
cipher l n = map (rotate n) l
    where rotate n c = chr . (+) (ord 'a') . modulate 26 . (+) n $ ord c - ord 'a'
          modulate n m = mod m n

caesar l n = map (\c -> ([c..'z'] ++ ['a'..c]) !! mod n 26) l

data Either' a b = Left' a | Right' b

instance Functor (Either' a) where
    fmap _ (Left' a) = Left' a
    fmap g (Right' b) = Right' (g b)

x :: Either' Int String
x = Right' ""


collatzChain :: Integer -> [Integer]
collatzChain x = takeWhile (/= 1) (iterate collatz x) ++ [1]
    where collatz x
            | even x    = x `div` 2
            | otherwise = 3 * x + 1

data Tree a = Leaf a | Node a (Tree a) (Tree a)
    deriving (Show, Eq)

add (Leaf l) = l
add (Node i left right) = i + add left + add right

data Person = Person { name :: String } deriving (Show)

strong :: String -> Bool
strong s = length s > 14 && any isUpper s && any isLower s && any isNumber s

solveRPN :: String -> Double
solveRPN = processRPN.words

processRPN :: [String] -> Double
{-
    processRPN values = 
            | o == "+"  = processRPN $ show (xi + yi):xs
            | otherwise = error $ "unknown operation " ++ o
                  where xi = read x
                        yi = read y
-}
processRPN [x] = read x
processRPN _   = error "bad parameters"


prime n = not $ any ((== 0).(n `mod`)) [2..n-1]

