
insert :: Ord a => a -> [a] -> [a]
insert n [] = [n]
insert n (x:xs)
	| n <= x = n : x : xs
	| otherwise = x : insert n xs
	
isort :: Ord a => [a] -> [a]
isort = foldr insert []

merge :: Ord a => [a] -> [a] -> [a]
merge [] xs = xs
merge xs [] = xs
merge (x:xs) (y:ys)
	| x <= y = x : merge xs (y:ys)
	| otherwise = y : merge (x:xs) ys
	
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort [a | a <- xs, a <= x] ++ [x] ++
	qsort [a | a <- xs, a > x]
	
is_pal :: Integer -> Bool
is_pal x = show x == (reverse $ show x)

f x = foldr (*) 1 [2..x]

zeros :: [Char] -> Integer
zeros [x] = 0
zeros xs
	| last xs == '0'  = 1 + zeros (init xs)
	| otherwise = 0
	
nul_factor x n
	| x `mod` 10 == 0 = (nul_factor (x `div` 10) n) + 1
	| n == 1 = 0
	| otherwise = nul_factor (x*n) (n-1)
	
nul_fact n = nul_factor 1 n