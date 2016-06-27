def get_scores_with_optimal_play(array):
    # we do a bfs traversal, starting with the
    # final states (only one option left),
    # and updating every existing permutation
    # with the optimal choice.
    optimal_score_by_state = {}
    states_in_next_round = set()

    # O(n)
    for idx, i in enumerate(array):
        state = State(array, idx, idx)
        scores = [0, 0]
        scores[state.current_player] += i
        optimal_score_by_state[state] = scores
        states_in_next_round.add(state)

    # n iterations, runs once per potential array size
    while len(states_in_next_round) > 0:
        states_in_current_round = states_in_next_round
        states_in_next_round = set()
        # < n iterations, runs once per potential configuration
        # of a contigous array of m items.
        for s in states_in_current_round:
            optimal_score = optimal_score_by_state[s]

            # O(1) (2 times, once per operation)
            def _try_state(left_index, right_index, score_modifier_method):
                try:
                    state_to_try = State(array, left_index, right_index)
                    potential_optimal_score = list(optimal_score)
                    current_player = state_to_try.current_player
                    potential_optimal_score[current_player] += (
                        getattr(state_to_try, score_modifier_method)
                    )

                    if state_to_try not in optimal_score_by_state:
                        optimal_score_by_state[state_to_try] = potential_optimal_score
                        states_in_next_round.add(state_to_try)
                    else:
                        existing_optimal_score = optimal_score_by_state[state_to_try]
                        if existing_optimal_score[current_player] <\
                        potential_optimal_score[current_player]:
                            optimal_score_by_state[state_to_try] = potential_optimal_score
                except AssertionError:
                    pass

            # we try the states that would result in this one:
            # - removing the beginning of this arry, with left_index - 1
            _try_state(s.left_index - 1, s.right_index, "left")
            # - removing the end of this array, with right_index - 1
            _try_state(s.left_index, s.right_index + 1, "right")

    # now that we have the optimal action for every state, and the
    # points that are earned when following that plan,
    # we can return back the root node, to see, with optimal play,
    # how much each can possibly earn.

    # total complexity:
    # sum(i) from i=0 to i=n => n^2 / 2
    # O(n^2)
    return optimal_score_by_state[State(array, 0, len(array) - 1)]


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


assert get_scores_with_optimal_play([0, 1, 2, 3, 4]) == [6, 4]
assert get_scores_with_optimal_play([1, 5, 2, 5, 1]) == [4, 10]
