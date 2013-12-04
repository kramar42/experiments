
dividers :: [Integer] -> Integer -> Integer
dividers xs x
	| filter (==0) (map (mod x) xs) /= [] = x
	| otherwise = 0

my_div :: Integer -> Integer
my_div = dividers [3, 5]

div_map :: Integer -> [Integer]
div_map (x + 1) = map (my_div) [1..x]

problem_1 :: Integer -> Integer
problem_1 x = foldl (+) 0 (div_map x)

foldl' f [x] e = f x e
foldl' f (x:xs) e = f x (foldl' f xs e)

fibo :: Integer -> Integer
fibo x
	| x <= 1 = 1
	| otherwise = fibo(x - 1) + fibo(x - 2)
	
until' :: (a -> Bool) -> (a -> a) -> a -> a
until' p f x
	| p x = x
	| otherwise = until' p f (f x)
	
problem_2 :: Integer -> Integer
problem_2 x = foldl (+) 0 (filter even (fib_list 1 1 x))

fib_list :: Integer -> Integer -> Integer -> [Integer]
fib_list x y big
	| x + y > big = []
	| otherwise = (x+y) : (fib_list y (x+y) big)
	
bpf_rec :: Integer -> Integer -> Integer
bpf_rec i x
	| i == x = x
	| x `mod` i == 0 = bpf_rec i (x `div` i) 
	| otherwise = bpf_rec (i + 1) x

problem_3 :: Integer -> Integer
problem_3 = bpf_rec 2

before_root = floor . sqrt

to_list :: Integer -> [Integer]
to_list 0 = []
to_list x = to_list (x `div` 10) ++ [x `mod` 10] 

reverse_num :: [Integer] -> Integer
reverse_num [] = 0
reverse_num (x:xs) = reverse_num (xs) * 10 + x	

is_polindrom x = x == (reverse_num . to_list) x
problem_4 = maximum [m | b <- [0..9], c <- [0..9], m <- [900009+10010*b+1100*c], is_polindrom m] 

eve x = [y | y <- [2..], y < x, even y]

positions :: Eq a => a -> [a] -> [Int]
positions x xs = [ i | (i, y) <- zip [0..] xs, x == y ] 

prime :: [Integer]
prime = map head (iterate crossout [2..])

crossout :: [Integer] -> [Integer]
crossout (x:xs) = filter (not . multiple x) xs

multiple :: Integer -> Integer -> Bool
multiple y x = x `rem` y == 0

quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort [y | y <- xs, y <= x] ++ [x] ++
	quicksort [y | y <- xs, y > x]

next_seed :: Integer -> Integer
next_seed n = 
	case test > 0 of
		True -> test
		False -> test + 2147483647
	where
		test = 48271 * lo - 3399 * hi
		hi = n `div` 44488
		lo = n `mod` 44488
		
rand :: Integer -> [Integer]
rand x = [x `mod` 100 | x <- iterate next_seed 1235523]

random x = [x `mod` 100 | x <- iterate next_seed 1235523]

i _ _ _ x f _ = take x (f 100)

want = 0
to = 0
numbers = 0

q x n
	| x < 5 ^ n = 0
	| otherwise = x `div` 5 ^ n + q x (n+1)

--f = head [m | b <- [0..9], c <- [0..9], m <- [900009 + 10010 * b + 1100 * c], [x | x <- [100..999], m `mod` x == 0 && m `div` x < 1000] /= []]

inits :: [a] -> [[a]]
inits [] = [[]]
inits [x] = [[], [x]]
inits (x:xs) = (inits . init) (x:xs) ++ [(last . inits . init) (x:xs) ++ [last xs]]