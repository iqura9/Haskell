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
  print (keepPrimes numbers)
