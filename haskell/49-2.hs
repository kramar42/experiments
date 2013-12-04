prime_list :: Integral a => [a] -> [[a]]
prime_list (x:xs) = ys : prime_list ys
	where ys = crossout x xs

crossout :: Integral a => a -> [a] -> [a]
crossout x ys = filter (p x) ys
	where p x y = y `mod` x /= 0

primes :: Integral a => [a]
primes = dropWhile (<1000) $ takeWhile (<10000) (map head $ prime_list [2..])

pairs :: [a] -> [[(a, a)]]
pairs [] = []
pairs (x:xs) = [zip (repeat x) xs] ++ pairs xs 

progression :: Integral a => [(a, a)] -> [(a, a, a)]
progression [] = []
progression ((f, s):xs)
	| elem (f, 2*s-f) xs = (f, s, 2*s-f) : progression xs
	| otherwise = progression xs

type Triple a = (a, a, a)
type Triples a = [Triple a]

progressions :: Integral a => Triples a
progressions = concat $ filter (/= []) $ map progression $ pairs primes

are_permutations :: Integral a => Triple a -> Bool
are_permutations (x, y, z) = to_list x == to_list y && to_list y == to_list z

to_list :: Integral a => a -> String
to_list x = qsort $ show x

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort [y | y <- xs, y <= x] ++ [x] ++ qsort [y | y <- xs, y > x]

prob :: Integral a => Triples a
prob = filter are_permutations progressions

show_triple :: Integral a => Triple a -> String
show_triple (x, y, z) = show x ++ show y ++ show z

result :: Integral a => Triples a -> [String]
result xs = map show_triple xs


main :: IO()
main = do
	print $ result $ prob
