prime_list :: Integral a => [a] -> [[a]]
prime_list (x:xs) = ys : prime_list ys
	where ys = crossout x xs

crossout :: Integral a => a -> [a] -> [a]
crossout x ys = filter (p x) ys
	where p x y = y `mod` x /= 0

primes :: Integral a => [a]
primes = map head $ prime_list [2..]

primes_sum :: Integral a => a -> [a] -> [a]
primes_sum n [] = []
primes_sum sum (x:xs) = next : primes_sum next xs
	where next = sum + x

primes_sum_list n = [primes_sum 0 (drop n primes)] ++ primes_sum_list (n+1)

dividers :: Integral a => a -> [a]
dividers x = filter (is_divider x) [1..x]
	where is_divider x y = x `mod` y == 0

is_prime :: Integral a => a -> Bool
is_prime x = dividers x == [1, x]

result = map (takeWhile (<1000000)) (primes_sum_list 0)

qsort [] = []
qsort (x:xs) = qsort [y | y <- xs, y <= x] ++ [x] ++ qsort [y | y <- xs, y > x]
