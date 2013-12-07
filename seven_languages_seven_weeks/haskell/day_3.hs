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
    data Exits = North | West | East | South deriving (Show, Eq)
    data Node = NodePath (Int, Int) [Exits] | TerminalNode (Int, Int) deriving (Show, Eq)
    type Maze = [[Node]]
    maze :: Maze
    maze = [
     [ (NodePath (0,0) [South]), (NodePath (1, 0) []), (NodePath (2, 0) []) ],
     [ (NodePath (0,1) [East]), (NodePath (1, 1) [East]), (NodePath (2, 1) [North, South]) ],
     [ (NodePath (0,2) []), (NodePath (1, 2) []), (TerminalNode (2, 2)) ]
           ]
-- getNode
    getNode :: Maze -> (Int, Int)-> Node
    getNode maze (x,y) = maze !! x !! y
-- getExists
    getExits :: Node -> [Exits]
    getExits (NodePath _ exits) = exits
    getExits (TerminalNode _) = []
-- getPosition
    getPosition :: Node -> (Int, Int)
    getPosition (NodePath (x,y) _) = (x, y)
    getPosition (TerminalNode (x,y)) = (x, y)
-- getNextNode
    getNextNode :: Node -> Maze -> Exits -> Node
    getNextNode node maze exit =
        let (x, y) = getPosition node
        in
          case exit of
            North -> getNode maze (x, y - 1)
            West -> getNode maze (x - 1, y)
            East -> getNode maze (x + 1, y)
            South -> getNode maze (x, y + 1)
    mazeStart = getNode maze (0, 0)
-- nextPaths
    nextPaths :: Maze -> [Node] -> [[Node]]
-- nextPaths maze node path = map (++ path) (map (getNextNode node maze) (getExits node))
    nextPaths maze nodeList =
        let nodeHead = head nodeList
        in
          map (:nodeList) (map (getNextNode nodeHead maze) (getExits nodeHead))
-- If the element already exists in the path, we're at a dead end.
    solveRoute :: Maze -> Node -> [Node] -> Exits -> Maybe [Node]
    solveRoute maze node path exit =
        let nextNode = getNextNode node maze exit
        in
          if (nextNode `elem` path)
          then
              Nothing
          else
              solveMaze maze node (nextNode:path)
-- solveMaze 2
    solveMaze :: Maze -> Node -> [Node] -> Maybe [Node]
    solveMaze maze node path =
        case node of
          TerminalNode _ -> Just (node:path)
          NodePath _ _->
                   let nodes = (filter (\x -> x /= Nothing) (map (solveRoute maze node path) (getExits node)))
                   in
                     if (length nodes > 0)
                     then
                         head nodes
                     else
                         Nothing
    mazeSolution = solveMaze maze mazeStart []
