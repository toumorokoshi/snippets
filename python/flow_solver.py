"""
This is a matrix solver.
0 = no color
1-7 = whatever colors

To verify a solution is correct, one has to determine that:
* All the squares are filled
* All paths are completely connected
"""
from copy import deepcopy
from itertools import product

blank = \
[[0,0,0,0,0,0,0,0],
 [0,0,0,0,0,0,0,0],
 [0,0,0,0,0,0,0,0],
 [0,0,0,0,0,0,0,0],
 [0,0,0,0,0,0,0,0],
 [0,0,0,0,0,0,0,0],
 [0,0,0,0,0,0,0,0],
 [0,0,0,0,0,0,0,0]]

one_and_two = \
[[1,1,1,1,1,1,1,1],
 [1,1,1,1,1,1,1,1],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2]]

one_and_two_zeros = \
[[1,1,1,1,1,1,1,1],
 [1,1,1,1,1,1,1,1],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,0,2,2,2,2,2],
 [2,2,0,2,2,2,2,2],
 [2,2,0,2,2,2,2,2],
 [2,2,0,2,2,2,2,2]]

one_and_two_nozeros_unsolved = \
[[1,1,2,1,1,1,1,1],
 [1,1,2,1,1,1,1,1],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2],
 [2,2,2,2,2,2,2,2]]


SIZE = 8
solver_matrix = [[1,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,1]]


def fill_connected_paths(m, paths, i):
  """ Fills the adjacent paths of the matrix if they match the color of the tuple position i
  """
  x, y = i
  color = m[x][y]
  print color
  x_pos = [x + pos for pos in [-1, 1] if x + pos < SIZE and x - pos > 0]
  y_pos = [y + pos for pos in [-1, 1] if y + pos < SIZE and y - pos > 0]
  explore_paths = []
  for p in product(x_pos, y_pos):
    x_temp, y_temp = p
    if paths[x_temp][y_temp] == 0 and m[x - 1][y] == color:
	paths[x_temp][y_temp] = True
	explore_paths.append((x_temp, y_temp))
  for path in explore_paths:
	fill_connected_paths(m, paths, path)
  return paths


def path_connected(m, i):
  """ Checks if a value starting at initial tuple i is completely
      connected in a matrix m 
  >>> path_connected(one_and_two, (0,0))
  True
  """
  color = m[i[0]][i[1]]
  connected_paths = deepcopy(blank)
  
	
def matrix_solved(m):
  """ Verified a matrix m is solved 
  >>> matrix_solved(one_and_two)
  True
  """
  # starting positions for elements to verify connectivity
  initial_positions = {} 
  for i in range(SIZE):
    for j in range(SIZE):
      if m[i][j] == 0:
        return False
      elif m[i][j] not in initial_positions:
	# add an initial positions of the color if it doesn't exist.
	initial_positions[m[i][j]] = (i, j)
  # verify connectivity
  for color in initial_positions:
    if not path_connected(m, initial_positions[color]):
	return False
  return True

if __name__ == '__main__':
    import doctest
    doctest.testmod()
