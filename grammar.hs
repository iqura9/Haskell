import qualified Data.Set as Set
import Data.List (intercalate)

type NonTerminal = Char

type Terminal = Char

type Production = (NonTerminal, String)

type Grammar = [Production]

exampleGrammar :: Grammar
exampleGrammar =
  [ ('S', "aB"),
    ('S', "BaC"),
    ('S', "e"),
    ('S', "B"),
    ('S', "q"),
    ('B', "nbC"),
    ('B', "c"),
    ('C', "d"),
    ('D', "e")
  ]

first1 :: Grammar -> NonTerminal -> Set.Set Terminal
first1 grammar symbol = Set.unions $ map (calculateFirst1 grammar) productions
  where
    productions = [body | (headSymbol, body) <- grammar, headSymbol == symbol]
    calculateFirst1 :: Grammar -> String -> Set.Set Terminal
    calculateFirst1 _ [] = Set.empty
    calculateFirst1 _ (x : _) | isTerminal x = Set.singleton x
    calculateFirst1 grammar' (x : xs) =
      if Set.member 'e' firstX 
        then Set.union (Set.delete 'e' firstX) (calculateFirst1 grammar' xs)
        else firstX
      where
        firstX = first1 grammar' x

isTerminal c = not $ elem c ['A' .. 'Z']

showSet :: (Show a) => Set.Set a -> String
showSet set = intercalate ", " (map show $ Set.toList set)

main :: IO ()
main = do
  let nonTerminals = ['S', 'B', 'C', 'D']
      firstSets = map (\nt -> (nt, first1 exampleGrammar nt)) nonTerminals
  mapM_ (\(nt, set) -> putStrLn $ "First 1(" ++ [nt] ++ ") = " ++ showSet set) firstSets
