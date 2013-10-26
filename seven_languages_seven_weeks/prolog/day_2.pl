% Reverse the elements of a list

% reverse([1, 2, 3], X)
% reverse([], [3, 2, 1])


revappend([], Ys, Ys).
revappend([X|Xs], Ys, Zs) :- revappend(Xs, [X|Ys], Zs).

reverse([], []).
reverse(Xs, Ys) :- revappend(Xs, [], Ys).

% reverse([1, 2, 3])

% find the smallest element of a list

min([], R, R).
min([H|T], M, R) :- min(T, M, R), M < H.
min([H|T], M, R) :- min(T, H, R), H =< M.
min([H|T], R) :- min(T, H, R).
