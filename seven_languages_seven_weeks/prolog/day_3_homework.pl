go :- write('hello world'), nl, fail.

% conditional prints would be those that print solutions at the end, after they succeed.
% since predicates run procedurely.

nope :- fail, write("this shoudn't print").
