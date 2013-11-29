module Day2 where
    import Data.Char
-- quicksort-ish
    mySortBy :: (a -> a-> Ordering) -> [a] -> [a]
    mySortBy cmp [] = []
    mySortBy cmp (p:list) =
        let lesser = [ x | x <- list, x `cmp` p == LT]
            greater = [ x | x <- list, x `cmp` p /= LT]
        in (mySortBy cmp lesser) ++ [p] ++ (mySortBy cmp greater)
    mySort :: (Ord a) => [a] -> [a]
    mySort = mySortBy compare
    stringToNum :: [Char] -> Int
    stringToNum rawNum =
        let nums = [ Data.Char.digitToInt x | x <- rawNum, x >= '0', x <= '9' ]
        in foldl (\y x -> y * 10 + x) 0 nums
    halve = (/ 2)
    third x = x:(third (x + 3))
    fifth x = x:(fifth (x + 5))
    eighth x y = zipWith (+) (third x) (fifth y)
    newline s = s ++ "\n"
-- the harder problems
-- x > y
    myGcd :: Integral a => a -> a -> a
    myGcd x 0 = x
    myGcd x y =
        let larger = max x y
            smaller = min x y
        in
          myGcd smaller (rem larger smaller)
    myPrime :: [Integer]
    myPrime = sieve [2..]
        where sieve (p:xs) = p : sieve [ x | x <- xs, x `mod` p > 0]
