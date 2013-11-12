-module(day_3).
-export([translate_monitor/0, start_monitor/0]).

% question 1: translating monitor translator

translate_loop() ->
    receive
        "casa" -> io:format("house~n"), translate_loop();
        "blanca" -> io:format("white~n"), translate_loop();
        "choque" -> exit({});
        _ -> io:format("unable to translate!~n"), translate_loop()
    end.

translate_monitor() ->
    process_flag(trap_exit, true),
    receive
        new -> io:format("Creating process...~n"),
               register(translator, spawn_link(fun translate_loop/0)),
               translate_monitor();
        {'EXIT', translator, _} -> io:format("Restarting translator...~n"),
                                   self() ! new,
                                   translate_monitor()
    end.

% I'm skipping challenge 2 + 3, because it sounds like this is a bad pattern for Erlang. If a process dies,
% it's very difficult to catch it, and the Erlang community believes that using a supervisor process is a better
% idea.
