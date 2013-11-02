valid([]).
valid([H|T]) :- fd_all_different(H), valid(T).

valid_rows(_, _, 0).
valid_rows(Solution, Width, Count) :-
    Count > 0,
    Count2 is Count - 1,
    valid_rows(Solution, Width, Count2),
    Start is Count2 * Width,
    End is Count * Width,
    subsequence(Start, End, Solution, R),
    fd_all_different(R).

% test: valid_rows([0,1,1,0], 2, 2).

% get a subsequence between Start and End, from the List into Result R

subsequence(0, 0, _, []).

subsequence(Start, End, [_|T], R) :- 
    Start > 0, 
    Start2 is Start - 1,
    End2 is End - 1,
    subsequence(Start2, End2, T, R).

subsequence(0, End, [H|T], [H|R]) :-
    End > 0,
    End2 is End - 1,
    subsequence(0, End2, T, R).
    

sudoku(Puzzle, Length, Width, Height, Solution) :-
    Solution = Puzzle,
    fd_domain(Solution, 1, Length),
    valid_rows(Solution, Length, Length).


s :- sudoku([1, _, _, _, _, _,
             1, _, _, _, _, _,
             _, _, 3, _, _, _,
             _, _, _, 4, _, _,
             _, _, _, _, 5, _,
             _, _, _, _, _, 6], 6, 3, 2, Solution).
