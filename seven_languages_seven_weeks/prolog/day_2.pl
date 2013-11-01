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

% insert

insert(X, [], [X]).
insert(X, [H|T], [X,H|T]) :- X < H.
insert(X, [H|T], [H|R]) :- insert(X, T, R).

mysort([X], [X]).
mysort([H|T], R) :- mysort(T, R2), insert(H, R2, R).

% fibonacci

fib(1, 1, 0).
fib(X, N1, N2) :- X > 1, 
                  X1 is X - 1,
                  fib(X1, N2, N3),
                  N1 is N2 + N3.
fib(X, R) :- fib(X, R, _).

% factorial

fact(0, 1).
fact(X, N1) :- X > 0, X1 is X - 1, fact(X1, N2), N1 is X * N2.
