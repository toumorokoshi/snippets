module Day1 where
-- implementation book
       allEven :: [Integer] -> [Integer]
       allEven [] = []
       allEven (h:t) = if even h then h:allEven t else allEven t
-- implementation with list comprehension
       allEven2 :: [Integer] -> [Integer]
       allEven2 list = [ (x) | x <- list, rem x 2 == 0]
-- reverses list
       myReverse :: [t] -> [t]
       myReverse [] = []
       myReverse (h:t) = myReverse(t) ++ [h]
-- build two-tuples with multiple color combinations
       colors = ["Blue", "Black", "Red"]
       colorCombinations = [(c1, c2) | c1 <- colors, c2 <- colors, c1 < c2]
-- multiplication table
       multiplication = [(n1, n2, n1 * n2) | n1 <- [1..12], n2 <- [1..12], n1 <= n2]
       -- map coloring problem
       states = take 1 [(("Tennessee", tennessee),
                         ("Mississippi", mississippi),
                         ("Alabama", alabama),
                         ("Georgia", georgia),
                         ("Florida", florida))
                       | tennessee <- colors,
                         mississippi <- colors,
                         alabama <- colors,
                         georgia <- colors,
                         florida <- colors,
                         tennessee /= mississippi,
                         tennessee /= alabama,
                         tennessee /= georgia,
                         mississippi /= alabama,
                         alabama /= georgia,
                         alabama /= florida,
                         georgia /= florida]
