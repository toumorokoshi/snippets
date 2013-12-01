module Day3 where
-- hash table monad
    import Data.List
    myLookup :: [Char] -> [([Char], a)] -> Maybe a
    myLookup key [] = Nothing
    myLookup key table =
        let (hash_key, value) = head table
        in
          if hash_key == key
             then Just value
             else (myLookup key (tail table))
    deepLookup :: [Char] -> [Char] -> [([Char], [([Char], a)])] -> Maybe a
    deepLookup key1 key2 table = myLookup key1 table >>= myLookup key2
    deepExample = [("a", [("a1", "value")]),
                   ("b", [("b1", "valueb1")])]
