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
--    data Node = NodePath ((Int, Int), [Node]) | TerminalNode (Int, Int)
    data Exits = North | West | East | South deriving Show
    data Node = NodePath (Int, Int) [Exits] | TerminalNode deriving Show
    type Maze = [[Node]]
    maze :: Maze
    maze = [
     [ (NodePath (0,0) [South]), (NodePath (1, 0) []), (NodePath (2, 0) []) ],
     [ (NodePath (0,1) [East]), (NodePath (1, 1) [East]), (NodePath (2, 1) [North, South]) ],
     [ (NodePath (0,2) []), (NodePath (1, 2) []), (TerminalNode) ]
           ]
    getNode :: Maze -> (Int, Int)-> Node

    solveMaze :: [Node]
    solveMaze =
