-module(day_2).
-export([get_value_from_tuplelist/2, create_total_price/1]).
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
