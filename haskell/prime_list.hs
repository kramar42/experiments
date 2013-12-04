
prime_list [x] = [x]
prime_list (x:xs) = x : prime_list (crossout x xs)

crossout x [] = []
crossout x (y:ys)
	| y `mod` x == 0 = crossout x ys
	| otherwise = y : crossout x ys

main = do
	print (prime_list [2..1000000])
