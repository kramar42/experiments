
toDec :: [Integer] -> Integer
toDec [] = 0
toDec (x:xs) = x + 2 * (toDec xs)

toBinary 0 = []
toBinary x = [x `mod` 2] : toBinary(x `div` 2)

toBin = concat . toBinary

takeThree (x:xs) = [take 3 (x:xs)] ++ takeThree xs
takeThree x = []

makeList x = init $ init $ takeThree $ toBin x

isGoo [] = True
isGoo (x:xs) =
	if x == [0, 0, 0] || x == [1, 1, 1]
	then False
	else isGoo xs
	
isGood x = isGoo $ makeList x