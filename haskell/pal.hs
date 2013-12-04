
p = maximum $ [m | m <- [1..1000000], is_pal m]
is_pal = is_palin . digits 
digits x = map (`mod` 10) $ takeWhile (/= 0) (iterate (`div` 10) x)

is_palin [] = True
is_palin [x] = True
is_palin (x:xs) = (x == (last xs)) && is_palin(init xs)

f x = foldl (*) 1 [2..x]

nuls x n
	| 5^n > x = 0
	| otherwise = x `div` 5^n + nuls x (n+1) 

main = do
	print $ sum $ digits $ f 100
