{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}

data Transition = Transition
  { fromState :: String,
    toState :: String,
    symbol :: String
  }

data FiniteAutomaton = FiniteAutomaton
  { states :: [String],
    symbols :: [String],
    transitions :: [Transition],
    startState :: String,
    finalStates :: [String]
  }

generateAllStringsHelper :: FiniteAutomaton -> String -> String -> [String] -> Int -> [String]
generateAllStringsHelper _ _ currentString allStrings k | length currentString > k = allStrings
generateAllStringsHelper fa currentState currentString allStrings k
  | length currentString == k && currentState `elem` finalStates fa = currentString : allStrings
  | otherwise =
      foldr
        ( \transition acc ->
            if fromState transition == currentState
              then generateAllStringsHelper fa (toState transition) (currentString ++ symbol transition) acc k
              else acc
        )
        allStrings
        (transitions fa)

generateAllStrings :: FiniteAutomaton -> Int -> [String]
generateAllStrings fa k = generateAllStringsHelper fa (startState fa) "" [] k

main :: IO ()
main = do
  states <- readConstantsFromFile "states.txt"
  symbols <- readConstantsFromFile "symbols.txt"
  finalStates <- readConstantsFromFile "final_states.txt"
  transitionsContent <- readConstantsFromFile "transitions.txt"
  kContent <- readConstantsFromFile "k.txt"

  let startState = head states
  let transitions = map parseTransition transitionsContent
  let automaton = FiniteAutomaton states symbols transitions startState finalStates
  let k = read (head kContent) :: Int

  print $ generateAllStrings automaton k

parseTransition :: String -> Transition
parseTransition line =
  let [fromState, toState, symbol] = words line
   in Transition fromState toState symbol

readConstantsFromFile :: FilePath -> IO [String]
readConstantsFromFile filePath = do
  contents <- readFile filePath
  return $ lines contents
