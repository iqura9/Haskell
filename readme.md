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
