-- Знайти останню цифру десяткового запису заданого натурального числа.
lastDigit :: Int -> Int
lastDigit n = n `mod` 10

main :: IO ()
main = do
    file <- readFile "input.txt"
    let myList = map read $ lines file :: [Int]
    putStrLn "Остання цифра числа"
    mapM_ (print . lastDigit) myList
