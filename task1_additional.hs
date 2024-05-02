-- Визначити кількість парних елементів у списку.
countEven :: [Int] -> Int
countEven xs = length (filter even xs)

main :: IO ()
main = do
    file <- readFile "input.txt"
    let myList = map read $ lines file :: [Int]
    putStrLn $ "Кількість парних елементів у списку: " ++ show (countEven myList)
