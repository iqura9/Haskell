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