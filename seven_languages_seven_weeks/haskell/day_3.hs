module Day3 where
-- hash table monad
    import Data.List
    myLookup :: [Char] -> [([Char], [Char])] -> Maybe [Char]
    myLookup key [] = Nothing
    myLookup key table =
        let (hash_key, value) = head table
        in
          if hash_key == key
             then Just value
             else (myLookup key (tail table))
