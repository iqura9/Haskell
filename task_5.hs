n :: Double
n = 9.0 

-- Задача 1
-- f7
maybeLog10F7 :: Double -> Maybe Double
maybeLog10F7 x =
  let value = x * x - n
  in if value <= 0 then Nothing else Just (logBase 10 value)

-- f8
maybeLog10F8 :: Double -> Maybe Double
maybeLog10F8 x =
  let value = x - (1/n)
  in if value <= 0 then Nothing else Just (logBase 10 value)

-- f9
maybeSqrtF9 :: Double -> Maybe Double
maybeSqrtF9 x =
  let value = x - (1/n)
  in if value < 0 then Nothing else Just (sqrt value)

-- Задача 2
composedFunctionDo :: Double -> Maybe Double
composedFunctionDo x = do
  fx <- maybeLog10F7 x
  gx <- maybeLog10F8 fx
  maybeSqrtF9 gx

composedFunctionBind :: Double -> Maybe Double
composedFunctionBind x = maybeLog10F7 x >>= maybeLog10F8 >>= maybeSqrtF9

-- Задача 3
maybeSqrtF9T3 :: (Ord a, Floating a) => a -> a -> Maybe a
maybeSqrtF9T3 x n =
  let value = x - (1/n)
  in if value < 0 then Nothing else Just (sqrt value)


-- Задача 4
composedFunctionDoT4 :: Double -> Maybe Double
composedFunctionDoT4 x = do
  fx <- maybeLog10F7 x
  gx <- maybeLog10F8 x
  maybeSqrtF9T3 fx gx

composedFunctionBindT4 :: Double -> Maybe Double
composedFunctionBindT4 x =
  maybeLog10F7 x >>= \fx ->
  maybeLog10F8 x >>= \gx ->
  maybeSqrtF9T3 fx gx

main :: IO ()
main = do
  print $ "Task 1"
  print $ "f7"
  print $ maybeLog10F7 4 -- Just 0.8450980400142567
  print $ maybeLog10F7 5 -- Just 1.2041199826559246
  print $ maybeLog10F7 1 -- Nothing

  print $ "f8"
  print $ maybeLog10F8 1 -- Just (-5.115252244738131e-2)
  print $ maybeLog10F8 2 -- Just 0.276206411938949
  print $ maybeLog10F8 (1/9) -- Nothing

  print $ "f9"
  print $ maybeSqrtF9 2 -- Just 1.3743685418725535
  print $ maybeSqrtF9 (-1) -- Nothing
  print $ maybeSqrtF9 (1/9) -- Just 0.0

  print $ "Task 2"
  -- Тестування з додатніми числами, що дають валідний результат
  print $ composedFunctionDo 4
  print $ composedFunctionBind 4
  -- Тестування з числом, що призводить до від'ємного результату у maybeLog10F7
  print $ composedFunctionDo 2
  print $ composedFunctionBind 2
  -- Тестування з числом, що призводить до від'ємного результату у maybeLog10F8
  print $ composedFunctionDo 3
  print $ composedFunctionBind 3
  -- Тестування з числом, що призводить до від'ємного результату у maybeSqrtF9
  print $ composedFunctionDo 1
  print $ composedFunctionBind 1
  -- Тестування з числом, що дає валідний результат для всіх функцій
  print $ composedFunctionDo 10
  print $ composedFunctionBind 10

  print $ "Task 3"
  print $ maybeSqrtF9T3 2 9 -- Just (sqrt (2 - 1/9))
  print $ maybeSqrtF9T3 (-1) 9 -- Nothing
  print $ maybeSqrtF9T3 (1/9) 9 -- Just 0
  print $ maybeSqrtF9T3 (1/9 + 0.1) 9 -- Just (sqrt (1/9 + 0.1 - 1/9))
  print $ maybeSqrtF9T3 1 4 -- Just (sqrt (1 - 1/4))
  print $ maybeSqrtF9T3 0.5 1 -- Nothing
  print $ maybeSqrtF9T3 1 1000000 -- Just (sqrt (1 - 1/1000000))
  print $ maybeSqrtF9T3 0 9 -- Nothing

  print $ "Task 4"
  print $ composedFunctionDoT4 10  -- Just 0.9768138143604054
  print $ composedFunctionBindT4 10 -- Just 0.9768138143604054
  
  print $ composedFunctionDoT4 2  -- Nothing
  print $ composedFunctionBindT4 2 -- Nothing
  
  print $ composedFunctionDoT4 0.1 -- Nothing
  print $ composedFunctionBindT4 0.1 -- Nothing
  
  print $ composedFunctionDoT4 1 -- Nothing
  print $ composedFunctionBindT4 1 -- Nothing
  
  print $ composedFunctionDoT4 4 -- Just value
  print $ composedFunctionBindT4 4 -- Just value