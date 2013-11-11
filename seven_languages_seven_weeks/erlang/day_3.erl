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

% challenge two: monitoring translator + self

monitor_loop() ->
    process_flag(trap_exit, true),
    receive
        {monitor, Process} ->
            link(Process),
            io:format("Monitoring Process.~n"),
            monitor_loop();
        die -> exit({});
        isAlive -> io:format("I'm alive!~n");
        {'EXIT', _, _} ->
            io:format("Restarting monitor..."),
            register(monitor, spawn(fun monitor_loop/0)),
            monitor ! {monitor, monitor}
    end.

start_monitor() ->
    Monitor = spawn(fun monitor_loop/0),
    register(monitor, Monitor),
    monitor ! {monitor, Monitor},
    Monitor.
