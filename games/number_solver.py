import pprint

class State:

    def __init__(self, array, left_index, right_index):
        self.array = array
        self.left_index = left_index
        self.right_index = right_index
        assert right_index < len(self.array)
        assert left_index >= 0

    @property
    def current_player(self):
        """ the player who's turn it is. """
        total_length = len(self.array)
        remaining_length = self.left_index + 1 - self.right_index
        return (total_length - remaining_length) % 2

    @property
    def left(self):
        """ return the left value. """
        return self.array[self.left_index]

    @property
    def right(self):
        """ return the right value. """
        return self.array[self.right_index]

    def __hash__(self):
        return hash((self.left_index, self.right_index))

    def __eq__(self, other):
        return (self.left_index == other.left_index and
                self.right_index == other.right_index)

    def __str__(self):
        return str((self.left_index, self.right_index))

    def __repr__(self):
        return str((self.left_index, self.right_index))


def _add_optimal(optimal_scores, state, potential_optimal_score, player):
    if state not in optimal_scores:
        optimal_scores[state] = potential_optimal_score
    else:
        existing_optimal_score = optimal_scores[state]
        if existing_optimal_score[player] < \
           potential_optimal_score[player]:
            optimal_scores[state] = potential_optimal_score


def get_scores(array):
    """
    get the winner for this number game.
    assumptions:

    - player 1 always goes first.
    """
    optimal_scores = {}
    states_left_to_process = []
    # first we calculate all the base nodes.
    for idx, i in enumerate(array):
        state = State(array, idx, idx)
        scores = [0, 0]
        scores[state.current_player] += i
        optimal_scores[state] = scores
        states_left_to_process.append(state)

    # bfs search
    while len(states_left_to_process) > 0:
        s = states_left_to_process.pop(0)
        optimal_score = optimal_scores[s]
        # try permutations
        try:
            state_to_try = State(s.array, s.left_index - 1, s.right_index)
            current_player = state_to_try.current_player
            potential_optimal_score = list(optimal_score)
            potential_optimal_score[current_player] += state_to_try.left
            _add_optimal(optimal_scores, state_to_try,
                         potential_optimal_score, current_player)
            if state_to_try not in states_left_to_process:
                states_left_to_process.append(state_to_try)
        except AssertionError:
            continue
        try:
            state_to_try = State(s.array, s.left_index, s.right_index + 1)
            current_player = state_to_try.current_player
            potential_optimal_score = list(optimal_score)
            potential_optimal_score[current_player] += state_to_try.right
            _add_optimal(optimal_scores, state_to_try,
                         potential_optimal_score, current_player)
            if state_to_try not in states_left_to_process:
                states_left_to_process.append(state_to_try)
        except AssertionError:
            continue

    pprint.pprint(optimal_scores)
    return optimal_scores[State(array, 0, len(array) - 1)]

assert get_scores([0, 1, 2, 3, 4]) == [6, 4]
# assert get_scores([1, 5, 2, 5, 1]) == [4, 10]
