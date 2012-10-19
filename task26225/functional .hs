
-- For function fromMaybe
import Maybe

-- Name = String
type Name = [Char]
-- Set of variable names
type Set = [Name]
-- data type of Lambda expression
data Lam = Var Name | Abs Lam Lam | App [Lam]

-- Add name to a set
add :: Name -> Set -> Set
add name set = name : set

-- Join 2 sets
join :: Set -> Set -> Set
join x y = x ++ y

-- Remove (if existing) variable from set
remove :: Name -> Set -> Set
-- If end of list -> return empty list
remove _ [] = []
-- Else
remove name (s:set) =
	-- If match found
	if name == s
		-- Return set without "s" in it
		then set
		-- Else don't touch "s" and keep finding
		else s:(remove name set)

-- Return set of free variables in Lam
freeVar :: Lam -> Set
-- If just one variable -> return it
freeVar (Var name) = [name]
-- If abstraction -> return free variables of lam without "name" in it
--freeVar (Abs name lam) = map (freeVar name) (remove freeVar lam)
freeVar (Abs name lam) = freeVar lam
-- If application -> return concatenation of free variables
freeVar (App app) = concat (map freeVar app)
--join (freeVar lam1) (freeVar lam2)


-- Is lambda expression free?
isFree :: Lam -> Bool
-- Yes, if there is no free variables in it
isFree lam = freeVar lam == []

{- Form of a writing reduction
 - t [x := u]
 -
 - Example 
 - x [y := N] x [y := N] (\z.M) [y := N] (MN) [y := N] =
 - Reduction of Simple variable
 - = N (if x = y) = x (if x /= y) = 
 - Reduction of a abstraction
 - = (\z.M) (if x = y) = \z.(M [y := N]) (if x /= y) = 
 - Reduction of a application
 - = (M [y := N])(N [y := N]) 
 -}

-- Form of calling function:
-- subst x t u
subst :: Name -> Lam -> Lam -> Lam
-- If t is a variable
subst name (Var t) u =
	-- And if name == t
	if name == t
		-- Nothing to change
		then u
		-- Or return just variable
		else (Var name)

-- If t is abstraction
subst name (Abs (Var n) t) u =
	-- If names are equal
	if name == n
		-- Nothing to change
		then (Abs (Var n) t)
		-- Substitute "name" in "t" bu u
		else (Abs (Var n) (subst name t u))

-- If t is application of lambdas -> return concat of all substitutions
-- for all elements in lambdas
subst name (App (l:lam)) u = App ((subst name l u) : [subst name (App lam) u])

{- We are trying to reduce application of lambdas, so we just try every 2
 - lambdas to satisfy this condition.
 - So we evaluate "l" and trying to reduce it with "a". Then getting from
 - "Maybe [Lam]" -> [Lam] or empty list concatting it with tale.
 - If we can, we evaluate "l" to. So if it is application of lambdas ->
 - we reduce it too.
 -}
eval :: Lam -> Lam
-- Try to evaluate application of lambda expressions
eval (App (l:a:m)) = App (fromMaybe [] (reduce (eval l) a) ++  m)
-- Or just return it
eval t = t

{- If first of Lams is abstraction -> return list with substituated
 - lambda expression in it.
 - Or return "Nothing".
 -}
reduce :: Lam -> Lam -> Maybe [Lam]
-- Try to substituate
reduce (Abs (Var name) t) u = Just [subst name t u]
-- Or just return Nothing
reduce t u = Nothing

-- Convert Lam to IO ()
printLam :: Lam -> IO ()
printLam = putStrLn . putLam
	where
		-- If is variable -> put it
		putLam (Var name) = name
		-- If abstraction -> print something like "\x . t"
		putLam (Abs (Var name) t) = "\\ " ++ name ++ " . " ++ putLam t
		-- If list of applications is empty -> put empty string
		putLam (App []) = ""
		-- Else -> print lambda from application if brackets
		putLam (App (l:lam)) = "(" ++ putLam l ++ ")" ++ putLam (App lam)

-- This is identical function, using in examples
f :: Lam -> Lam
f x = x
		
-- Example of first lambda expression
run1 :: Lam
-- It is application
run1 = eval (App [
	-- of 2 abstractions
	-- from x to x
	(Abs (Var "x") (Var "x")),
	-- \x . x
	(Abs (Var "x") (Var "x"))
	-- end of application.
	])
	
-- Another example. This is application of 2 abstractions too.
run2 :: Lam
run2 = eval (App [
	-- \f x . f (f x)
	(Abs (f (Var "x")) (f (f (Var "x")))),
	-- \x . x
	(Abs (Var "x") (Var "x"))
	-- end of application.
	])

-- Application of 3 abstractions.
run3 :: Lam
run3 = eval (App [
	-- \f x . f (f x)
	(Abs (f (Var "x")) (f (f (Var "x")))),
	-- \x . x
	(Abs (Var "x") (Var "x")),
	-- \x . x
	(Abs (Var "x") (Var "x"))
	-- end of application.
	])

-- The hardest example.
-- This is application of abstraction and another application of 2 abstrations
-- with application of abstraction in each.
run4 :: Lam
run4 = eval (App [
	-- Abstraction \x . y
	(Abs (Var "x") (Var "y")),
	-- application
	(App [
		-- \x . xx
		(Abs (Var "x") (App [
			(Var ("x")),
			(Var ("x"))
		])),
		-- \x . xx
		(Abs (Var "x") (App [
			(Var ("x")),
			(Var ("x"))
		]))		
	])
	-- end.
	])

-- Main function
main :: IO ()
main = do
	printLam run1
	printLam run2
	printLam run3
	printLam run4
