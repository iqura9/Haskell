[Task_1_9.hs PDF](Звіт_1.1.pdf)
```haskell
import Data.List (elemIndex, sort)

findSmallestN :: (Ord a) => Int -> [a] -> [a]
findSmallestN n array = take n (sort array)

findIndexes :: (Eq a) => [a] -> [a] -> [Int]
findIndexes array1 array2 = mapMaybe (`elemIndex` array2) array1
  where
    mapMaybe _ [] = []
    mapMaybe f (x : xs) =
      case f x of
        Just index -> index : mapMaybe f xs
        Nothing -> mapMaybe f xs

getElementAtIndex :: (Num a) => Int -> [a] -> a
getElementAtIndex _ [] = -1
getElementAtIndex index (a : rest)
  | index < 0 = -1
  | index == 0 = a
  | otherwise = getElementAtIndex (index - 1) rest

main :: IO ()
main = do
  content <- lines <$> readFile "input.txt"
  let n = read (head content) :: Int
  let numbers = map read (words (content !! 1)) :: [Int]
  -- 0 show input
  putStrLn "input:"
  print n
  print numbers
  -- 1 find all smallest numbers of n
  let arrayOfSmallest = findSmallestN n numbers
  -- 2 find first indexes for those smallest and push to array
  let arrayOfIndexes = findIndexes arrayOfSmallest numbers
  -- 3 sort arrayOfIndexes
  let sortedArrayOfIndexes = sort arrayOfIndexes
  -- 4 substitute indexes with values
  let result = map (`getElementAtIndex` numbers) sortedArrayOfIndexes
  -- 5 show result
  putStrLn "outcome:"
  print result
```

[Task_1_52.hs PDF](Звіт_1.2.pdf)

```haskell
isNotDivisible :: Integer -> Integer -> Bool
isNotDivisible x n = n `mod` x /= 0

isPrime :: Integer -> Bool
isPrime n
  | n <= 1 = False
  | otherwise = all (`isNotDivisible` n) [2 .. limit]
  where
    limit = floor (sqrt (fromIntegral n))

keepPrimes :: [a] -> [a]
keepPrimes array = [x | (x, i) <- zip array [0 ..], isPrime i]

main :: IO ()
main = do
  contents <- readFile "input.txt"
  let numbers = map read (words contents) :: [Int]
  putStrLn "input:"
  print numbers
  putStrLn "outcome:"
  print $ keepPrimes numbers

```

[Task_2_25.hs PDF](Звіт_2.pdf)

``` haskell
printResult :: (Show a) => [a] -> IO ()
printResult array = putStrLn $ "Array: " ++ show array ++ ", Length: " ++ show (length array)

isNotDivisible :: Int -> Int -> Bool
isNotDivisible x n = n `mod` x /= 0

isPrime :: Int -> Bool
isPrime n
  | n <= 1 = False
  | otherwise = all (`isNotDivisible` n) [2 .. limit]
  where
    limit = floor (sqrt (fromIntegral n))

findNextPrime :: Int -> Int
findNextPrime num
  | isPrime (num + 1) = num + 1
  | otherwise = findNextPrime (num + 1)

subString :: [a] -> Int -> ([a], [a], [a])
subString array divider =
  let firstDivider = divider
      lastDivider = length array - divider
      (beforeFirst, rest) = splitAt firstDivider array
      (between, afterLast) = splitAt (lastDivider - firstDivider) rest
   in (beforeFirst, between, afterLast)

recursiveSubString :: (Show a) => [a] -> Int -> IO ()
recursiveSubString array divider
  | null array || divider <= 1 = return ()
  | divider * 2 > length array = printResult array
  | otherwise = do
      printResult first
      recursiveSubString between (findNextPrime divider)
      printResult last
  where
    (first, between, last) = subString array divider

main :: IO ()
main = do
  contents <- readFile "input.txt"
  let numbers = map read (words contents) :: [Int]
  putStrLn "input:"
  print numbers
  putStrLn "outcome:"
  if null numbers then putStrLn "[]" else recursiveSubString numbers (findNextPrime 0)

```

[Task_1_9.pl PDF](Звіт_1.1_prolog.pdf)
```prolog
sortArray(Array, SortedArray):-
	sort(0, @=<, Array, SortedArray).

findSmallestN(N, Array, SmallestN):-
	sortArray(Array, SortedArray),
    findSmallestN_(N, SortedArray, SmallestN).

findSmallestN_(0, _, []).
findSmallestN_(N, [X|Xs], [X|Rest]):-
    N > 0,
    N1 is N - 1,
    findSmallestN_(N1, Xs, Rest).

findIndexes(Array1, Array2, Result):-
    findIndexesHelper(Array1, Array2, Result).

findIndexesHelper([], _, []).
findIndexesHelper([X|Xs], Array2, Result):-
    ( nth0(Index, Array2, X) -> Result = [Index|Rest],  
	  findIndexesHelper(Xs, Array2, Rest); 
      findIndexesHelper(Xs, Array2, Result) ).

getElementAtIndex(Index,[A|Rest],Result):-
	Index < 0 -> Result = -1;
	Index =:=0 -> Result = A;
	nth0(Index, [A|Rest], Result).

iterate([], _, []).
iterate([I|Is], Array, [Res|Rest]):-
    getElementAtIndex(I, Array, Res),
    iterate(Is, Array, Rest).
	
run :-
	N = 3,
	Array=[2,2,2,1],
	write('input: '), 
	writeln(Array),
	findSmallestN(N, Array, SmallestN),
	findIndexes(SmallestN,Array,Indexes),
	sortArray(Indexes,SortedIndexes),
	iterate(SortedIndexes,Array,Result),
	write('outcome: '), write(Result).
```
[Task_1_52.pl PDF](Звіт_1.2_prolog.pdf)
```prolog
:- dynamic isNotDivisible/2.
:- dynamic isPrime/1.

isDivisible(X, Y) :-
    0 is X mod Y,!.

isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :-
	Limit is floor(sqrt(X)),
	\+ (between(2, Limit, Y), X \= Y, isDivisible(X, Y)).

keepPrimes(Array, Primes) :-
	keepPrimes(Array, 0, Primes).
	
keepPrimes([], _, []).
keepPrimes([H|T], Index, Primes) :-
	isPrime(Index),
	NextIndex is Index + 1,
	keepPrimes(T, NextIndex, Primes1),
	Primes = [H|Primes1].
keepPrimes([_|T], Index, Primes) :-
	NextIndex is Index + 1,
	keepPrimes(T, NextIndex, Primes).
	
run :-
	Array=[0, 1],
	write('input: '), 
	writeln(Array),
	keepPrimes(Array, Primes),
	write('outcome: '), write(Primes).
```
[Task_2_25.pl PDF](Звіт_2_prolog.pdf)
```prolog
printResult(Array):-
    length(Array, Length),
	Length =:= 0 -> write('');
	length(Array, Length),
    write(Array), 
    write(' Length: '), 
    write(Length), 
    nl.

isDivisible(X, Y):-
    0 is X mod Y,!.

isPrime(2):- true,!.
isPrime(X):- X < 2,!,false.
isPrime(X):-
	Limit is floor(sqrt(X)),
	\+ (between(2, Limit, Y), X \= Y, isDivisible(X, Y)).

findNextPrime(Num, Result):-
	Num1 is Num + 1,
	(isPrime(Num1) -> Result = Num1;
	findNextPrime(Num1, Result)).

subString(Array, Divider, BeforeFirst, Between, AfterLast):-
	length(Array, ArrayLength),
	FirstDivider is Divider,
	LastDivider is ArrayLength - Divider,
	split_at(FirstDivider, Array, BeforeFirst, Rest),
	RemainingLength is LastDivider - FirstDivider,
	split_at(RemainingLength, Rest, Between, AfterLast).
	
split_at(0, L, [], L).
split_at(N, [X|Xs], [X|Ys], Zs):-
	N > 0,
	N1 is N - 1,
	split_at(N1, Xs, Ys, Zs).

recursiveSubString(Array, Divider):-
	length(Array, ArrayLength),
	Divider * 2 > ArrayLength -> printResult(Array);
	subString(Array, Divider, BeforeFirst, Between, AfterLast),
	printResult(BeforeFirst),
	findNextPrime(Divider, Prime),
	recursiveSubString(Between, Prime),
	printResult(AfterLast).

run :-
	Array=[0,1],
	write('input: '), 
	writeln(Array),
	write('outcome: '),nl,
	length(Array,ArrayLength),
	(ArrayLength =:= 0 -> write([]), nl;
        findNextPrime(0, Prime),
        recursiveSubString(Array, Prime)).
```