-------- <Primes> --------
prime_list :: Integral a => [a] -> [[a]]
prime_list (x:xs) = ys : prime_list ys
	where ys = crossout x xs

crossout :: Integral a => a -> [a] -> [a]
crossout x ys = filter (p x) ys
	where p x y = y `mod` x /= 0

primes :: Integral a => [a]
primes = dropWhile (<1000) $ takeWhile (<10000) (map head $ prime_list [2..])
-------- </Primes> --------

-------- <Eyler> --------
filt :: Integral a => [a] -> Triples a
filt [] = []
filt (x:xs) = if elem y xs && elem z xs && are_permutations(x,y,z) then (x,y,z) : filt xs else filt xs
	where y = x+3330
	      z = x+6660

result :: Integral a => Triples a -> String
result xs = show_triple (last xs)
-------- </Eyler> --------

-------- <Triples> --------
type Triple a = (a, a, a)
type Triples a = [Triple a]

are_permutations :: Integral a => Triple a -> Bool
are_permutations (x, y, z) = to_list x == to_list y && to_list y == to_list z

to_list :: Integral a => a -> String
to_list x = qsort $ show x

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort [y | y <- xs, y <= x] ++ [x] ++ qsort [y | y <- xs, y > x]

show_triple :: Integral a => Triple a -> String
show_triple (x, y, z) = show x ++ show y ++ show z
-------- </Triples> --------

-------- <Main> --------
main :: IO()
main = do
	print $ result $ filt primes
-------- </Main> --------
