use_module(library(clpfd)).

% validate input 
valid_queen((_, Col)) :- member(Col, [1, 2, 3, 4, 5, 6, 7, 8]).

valid_queens([]).
valid_queens([H|T]) :-
    valid_queen(H), valid_queens(T).

% method to get rows

rows([], []).
rows([(Row, _)|QueenT], [Row|RowT]) :- rows(QueenT, RowT).

% method to get cols
cols([], []).
cols([(_, Col)|QueenT], [Col|ColT]) :- cols(QueenT, ColT).


% northwest-southeast diagonal
nwse([], []).
nwse([(Row, Col)|QueenT], [Diagonal|DiagonalT]) :- 
    Diagonal is Col - Row, nwse(QueenT, DiagonalT).

% northeast-southwest diagonal
nesw([], []).
nesw([(Row, Col)|QueenT], [Diagonal|DiagonalT]) :- 
    Diagonal is Col + Row, nesw(QueenT, DiagonalT).

eight_queens(Puzzle) :-
    Puzzle = [(1, _), (2, _), (3, _), (4, _), (5, _), (6, _), (7, _), (8, _)],
    % validate input
    length(Puzzle, 8),
    valid_queens(Puzzle),
    % validate column
    cols(Puzzle, Columns),
    fd_all_different(Columns),
    % validate diagonals
    nwse(Puzzle, NWSE),
    fd_all_different(NWSE),
    nesw(Puzzle, NESW),
    fd_all_different(NESW).
