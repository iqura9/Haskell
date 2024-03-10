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
