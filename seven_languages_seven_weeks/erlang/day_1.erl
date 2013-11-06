-module(day_1).
-export([count_words/1, test/1, count_to_ten/0, success_or_error/1]).


count_words([]) -> 0;
count_words([C1, C2 | T]) ->
if
    (C1 /= $ ) and (C2 /= $ ) ->
        0;
    true ->
        0
end + count_words(T).

test([C|_]) ->
    if
        C == $  ->
            1;
        true ->
            0
    end.

% count_to_n
count_to_n(N, Max) ->
    if N < Max ->
            io:fwrite("~B~n", [N + 1]),
            count_to_n(N + 1, Max);
       true ->
            0
    end.
count_to_ten() -> count_to_n(0, 10).

% success_or_error
success_or_error(success) -> io:fwrite("success!~n");
success_or_error({error, Message}) ->  io:fwrite("error: ~s!~n", [Message]).
