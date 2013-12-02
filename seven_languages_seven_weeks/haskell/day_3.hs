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
    data Node = NodePath (Int, Int) [Exits] | TerminalNode (Int, Int) deriving Show
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
-- nextPaths
    nextPaths :: Maze -> [Node] -> [[Node]]
--    nextPaths maze node path = map (++ path) (map (getNextNode node maze) (getExits node))
    nextPaths maze nodeList =
        let nodeHead = head nodeList
        in
          map (:nodeList) (map (getNextNode nodeHead maze) (getExits nodeHead))
-- solvePath
--     solvePath :: Node -> Exits -> [Node] -> Maybe [Node]
--     solvePath node path direction =
--         let (x, y) = getNextNode (getPosition node) direction
--         in
--           if elem nextNode path
--           then
--              Nothing
--           else
--               solveMaze maze (x, y) (path ++ nextNode)
-- -
-- solveMaze
--     solveMaze :: Maze -> (Int, Int) -> [Node] -> Maybe [Node]
--     solveMaze maze (start_x, start_y) path =
--         let current_node = getNode maze (start_x, start_y)
--         in
--           case current_node of
--             TerminalNode -> return path
--             NodePath ->
--                 let nextPaths = map  (getExits current_node)
--                 in
--                   if length paths > 0
--                   then
--                       take 1 nextpaths
--                   else
--                       Nothing
--         in
--           map (getExists current_node)
--           do direction <- getExits current_node;
--              let (x, y) = getNextNode (getPosition current_node) direction
--                  nextNode = getNode (x, y)
--              in
--                if elem nextNode path
--
-- If the element already exists in the path, we're at a dead end.

-- solveMaze 2
    solveMaze :: Maze -> Node -> [[Node]]
    solveMaze maze node =
        let pathMonad = (nextPaths maze)
        in
          [node] >>= pathMonad
