module Day2 where
-- quicksort-ish
    mySort :: Ord n => [n] -> [n]
    mySort [] = []
    mySort (p:list) =
        let lesser = [ x | x <- list, x <= p]
            greater = [ x | x <- list, x > p]
        in (mySort lesser) ++ [p] ++ (mySort greater)
