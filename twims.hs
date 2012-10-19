
import Random

generator :: StdGen
generator = mkStdGen 42

rands :: [Float]
rands = randomRs (-1, 1) generator :: [Float]

get2rand :: [Float]
get2rand = take 2 rands

--get2norm :: [Float]
get2norm
	| s > 1 || s == 0 = get2norm
	| otherwise = t * head r : t * tail r : []
		where 
			r = get2rand 
			s = get_s . r 
			t = (-2 * log(s) / s) ^ 0.5

get_s :: [Float] -> Float
get_s (x:y:xs) = x^2 + y^2
