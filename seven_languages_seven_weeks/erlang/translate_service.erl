-module(translate_service).
-export([start/0, listen/0]).

% compile with:
% erl -compile translate_service.erl

% erl -noshell -s translate_service start -s init stop -sname translator

% to connect:
% erl -sname client
% >>> T = 'translator@tsutsumi-arch'.
% >>> net_kernel:connect_node(T).
% >>> c(translate_service).
% >>> P = spawn(fun translate_service:listen/0)).
% >>> {shell, T} ! {"casa", P}.

listen() ->
    receive
        Translation ->
            io:fwrite("~s~n", [Translation]), listen()
    end.

loop() ->
    receive
        {Token, From} ->
            case Token of
                "casa" -> From ! "house";
                "blanca" -> From ! "white";
                _ -> From ! "unable to translate!"
            end,
            io:fwrite("got translator!"),
            loop();
        _ ->
            io:fwrite("got incorrect message!"),
            loop()
    end.

start() ->
    io:fwrite("listening...\n"),
    io:fwrite("~s\n", [node()]),
    register(shell, self()),
    loop().
