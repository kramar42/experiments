
-- We hide "head", because we want it return not 'a', but 'Maybe a'
import Prelude hiding (head)

{- Give types Name and Memory that can represent variable names and the 
 - memory respectively.
 -}
-- Just String
type Name = [Char]
-- Tuple with name and value in it
type Variable = (Name, Integer)
-- List of variables
type Memory = [Variable]

{- Write a function 
 - update :: Name -> Integer -> Memory -> Memory 
 - that given a variable name, a value and a memory, will update the memory 
 - with the new value. This function should replace any previous value. If 
 - there is no previous value, then the memory should be extended with the 
 - values given. 
 -}
update :: Name -> Integer -> Memory -> Memory
-- If we reached end of a list -> return new Variable
update name integer [] = [(name, integer)]
-- If we found element with name 'name' -> append new Variable to start of 
-- memory
update name integer (m:memory) = 
	if  hasName name m 
		then (name, integer) : memory
	-- Else try to find Variable in tail of memory
		else m : (update name integer memory)

{- Write a function 
 - find :: Name -> Memory -> Integer 
 - that will return the contents associated with a memory location. 
 - If the variable does not exist in the memory, return 0.
 -}
find :: Name -> Memory -> Integer
{- First - filter from memory variables with names 'name'.
 - Then take head of this list. If list is empty -> out function 'head' will
 - return 'Nothing'.
 - Then 'getInteger' from 'Maybe Variable' and return it's integer or 0.
 -}
find name memory = getInteger . head $ filter (hasName name) memory

{- Define a datatype Aexp for arithmetic expressions. 
 - It holds:
 - 		Number
 -		Or Variable with name 'Name'
 - 		Or it is Sum of 2 arithmetic expressions
 -		Or Multiple of 2 arithmetic expressions
 -}
data Aexp = Number Integer | Var Name | Sum Aexp Aexp | Mult Aexp Aexp

{- Write a function
 - evalA :: Aexp -> Memory -> Integer
 - that will evaluate an arithmetic expression, using the values of variables
 - in the memory.
 -}
evalA :: Aexp -> Memory -> Integer
-- If Number -> return Number
evalA (Number number) _ = number
-- If Variable -> find and return Variable's number
evalA (Var name) memory = find name memory
-- Redefining "Sum" and "Mult" with "+" and "*"
evalA (Sum x y) memory = (evalA x memory) + (evalA y memory)
evalA (Mult x y) memory = (evalA x memory) * (evalA y memory)

{- Define a datatype Bexp for boolean expressions.
 - It holds:
 - 		Bool value
 -		Or "And" of 2 boolean expressions
 -		Or "Equal" of 2 arithmetic expression
 -		Or compare ("Less" then) 2 arithmetic expressions
 -		Or "Not" boolean expression.
 -}
data Bexp = Bool Bool | And Bexp Bexp | Eq Aexp Aexp | Less Aexp Aexp | Not Bexp

{- Write a function
 - evalB :: Bexp -> Memory -> Bool
 - that will evaluate a boolean expression, using the values of variables in
 - the memory.
 -}
evalB :: Bexp -> Memory -> Bool
-- If just Bool -> return Bool
evalB (Bool b) _ = b
-- If "And" -> return "and" of evalB x and evalB y
evalB (And x y) memory = and [evalB x memory, evalB y memory]
-- If "Equals" -> return Aexp x == Aexp y
evalB (Eq x y) memory = (evalA x memory) == (evalA y memory)
-- The same with "Less" check
evalB (Less x y) memory = (evalA x memory) < (evalA y memory)
-- If "Not" -> return not Bexp x
evalB (Not x) memory = not $ evalB x memory

{- Define a datatype Com to represent Commands.
 - It holds:
 -		Assigning of value with name 'Name' to Aexp
 -			(Assign "x" aexp) <=> x = aexp
 -		Or Sequence of Commands
 -			(Seq [com1, com2]) <=> com1; com2
 -		Or "If" statement
 -			(If bexp com1 com2) <=> If bexp then com1 else com2
 -		Or "While" loop
 -			(While bexp com) <=> While bexp do com
 -}
data Com = Assign Name Aexp | Seq [Com] | If Bexp Com Com | While Bexp Com

{- Write a function 
 - evalC :: Com -> Memory -> Memory
 - that will take a command and a memory, and evaluate the command in the
 - memory given, returning the new memory. The output of the interpreter is 
 - therefore the final memory.
 -}
evalC :: Com -> Memory -> Memory
-- If "Assign" -> return updated memory
evalC (Assign name exp) memory = update name (evalA exp memory) memory
-- If "Seq" is empty -> return not changed memory
evalC (Seq []) memory = memory
-- Else -> run recursive function with "newMemory", which is memory
-- updated with Command "x"
evalC (Seq (x:xs)) memory = evalC (Seq xs) newMemory
	where newMemory = evalC x memory
-- If "If" -> try evalB exp. If True -> return memory, updated with Com "then'"
-- Else -> return memory, updated with Com "else'"
evalC (If bexp then' else') memory =
	if evalB bexp memory 
		then evalC then' memory
		else evalC else' memory
-- If "While" -> try evalB bexp. If True -> run recursive function with memory,
-- updated with evalC "com" (newMemory)
-- Else -> return memory without any changes
evalC (While bexp com) memory =
	if evalB bexp memory
		then evalC (While bexp com) newMemory
		else memory
			where newMemory = evalC com memory
										
-- Checks if is variable name 'Name'
hasName :: Name -> Variable -> Bool
hasName name (n, _) = name == n

-- Returns integer of variable
getInteger :: Maybe Variable -> Integer
getInteger Nothing = 0
getInteger (Just (_, integer)) = integer

-- Returns first element of list
head :: [a] -> Maybe a
head [] = Nothing
head (x:_) = Just x

-- Print memory
printMemory :: Memory -> IO ()
printMemory = putStrLn . putMemory
	where
		-- If out of memory -> empty string
		putMemory [] = ""
		-- Else put variable and append recursive function
		putMemory (m:memory) = putVariable m ++ putMemory memory
		-- Put variable
		putVariable (name, integer) = name ++ " = " ++ show integer ++ "\n"

-- This is example function, that just runs commands and returns Memory
run :: Memory
run = evalC (Seq [
	
	-- Some assignments
	
	-- Assign with number
	Assign "x" (Number 1),
	-- Assign with another variable
	Assign "y" (Var "x"), 
	Assign "x" (Var "z"), 
	Assign "z" (Number 5), 
	Assign "x" (Number 4),
	
	-- If statement
	-- Compare 2 variables
	If (Less (Var "z") (Var "x"))
		-- then
		(Assign "y" (Var "z")) 
		-- else
		(Assign "y" (Var "x")),
		
	-- Some assignments
	Assign "z" (Number 5),
	Assign "x" (Number 3),
	
	-- While loop
	While
		-- Bool expression
		(Less (Var "x") (Var "z"))
		-- Do sequence of commands
		(Seq [
			-- Assignments
			Assign "y" (Sum (Var "y") (Number 1)),
			Assign "x" (Sum (Var "x") (Number 1))
		-- End of sequence
		]),
	
	-- Assignments
	Assign "y" (Number 1),
	Assign "z" (Number 5),
	Assign "x" (Number 1),
	
	-- While loop
	While
		-- Bool expression
		(Not ((Less (Var "z") (Var "x"))))
		-- Sequence of commands
		(Seq [
			-- Some assignments
			Assign "y" (Mult (Var "y") (Var "x")),
			Assign "x" (Sum (Var "x") (Number 1))
		-- End of sequence
		])
		
	-- End of program
	])
	-- Run commands with empty start memory
	[]
	
-- Main function
main :: IO ()
main = printMemory run
