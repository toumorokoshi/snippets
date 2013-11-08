-module(day_2).
-export([get_value_from_tuplelist/2, create_total_price/1, tic_tac_toe_board/1]).
-include_lib("eunit/include/eunit.hrl").


get_value_from_tuplelist(TupleList, Keyword) ->
    element(2, lists:keyfind(Keyword, 1, TupleList)).

% tests

get_value_from_tuplelist_test() ->
    "test" = get_value_from_tuplelist([{test, "test"}, {foo, "bar"}], test).


create_total_price(Shopping_list) ->
    [{Item, Quantity * Price} || {Item, Quantity, Price} <- Shopping_list].

% tests

create_total_price_test() ->
    [{"Cheese", 2}, {"Cookies", 6}] = create_total_price([{"Cheese", 1, 2},
                                                            {"Cookies", 2, 3}]).

% return a symbol no_winner, x, o, depending on who won that row.
elements_won(List) ->
case List of
    [x, x, x] -> x;
    [o, o, o] -> o;
    _ -> no_winners
end.

% generate the rows we want
get_rows(Board) ->
    lists:map(fun(I) -> lists:sublist(Board, I, 3) end, lists:seq(1, 9, 3)).

% get the columns we want
get_cols(Board) ->
    lists:map(fun(I) -> lists:map(fun(J) -> lists:nth(J, Board) end, lists:seq(I, I + 6, 3)) end,
              lists:seq(1, 3)).


get_diagonals(Board) ->
    [[lists:nth(1, Board),
      lists:nth(5, Board),
      lists:nth(9, Board)],
     lists:map(fun(I) -> lists:nth(I, Board) end, lists:seq(3, 7, 2))
    ].

tic_tac_toe_board(Board) ->
    Results = [elements_won(L) || L <- lists:append([get_rows(Board),
                                                     get_cols(Board),
                                                     get_diagonals(Board)])],
    case {lists:any(fun(El) -> El == x end, Results),
          lists:any(fun(El) -> El == o end, Results),
          lists:any(fun(El) -> El == n end, Board)} of
        {true, true, _} -> tie;
        {true, false, _} -> x;
        {false, true, _} -> o;
        {_, _, true} -> no_winner;
        _ -> cat
    end.

% tests
no_winner_test() -> no_winner = tic_tac_toe_board([n, n, x,
                                                   n, x, n,
                                                   o, n, o]).

x_horizontal_winner_test() -> x = tic_tac_toe_board([x, x, x,
                                                     n, n, n,
                                                     n, n, n]).

o_vertical_winner_test() -> o = tic_tac_toe_board([o, n, n,
                                                   o, n, n,
                                                   o, n, n]).

x_diagonal_winner_test() -> x = tic_tac_toe_board([x, n, n,
                                                   o, x, n,
                                                   o, n, x]).

tie_test() -> tie = tic_tac_toe_board([x, x, x,
                                       o, o, o,
                                       o, n, x]).

cat_test() -> cat = tic_tac_toe_board([x, o, x,
                                       o, x, o,
                                       o, x, o]).


get_cols_test() -> [[1, 4, 7], [2, 5, 8], [3, 6, 9]] = get_cols([1,2,3,4,5,6,7,8,9]).
