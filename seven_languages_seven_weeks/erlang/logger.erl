-module(logger).
-behaviour(gen_server).

% administration methods
-export([start_link/0, init/1, code_change/3, terminate/2]).
% handlers
-export([handle_call/3, handle_cast/2, handle_info/2]).

start_link() ->
    gen_server:start_link(?MODULE, [], []).


% server functions
init([]) ->
    case file:open("log.txt", [read, write, raw]) of
        {ok, Fd} ->
            file:position(Fd, bof),
            {ok, Fd};
        {error, Reason} ->
            io:format("Can't open log.txt!~n"),
            {stop, Reason}
    end.

handle_call(terminate, _From, Fd) ->
    {stop, normal, ok, Fd}.

handle_cast({return, _Channel}, Fd) ->
    {noreply, Fd}.

handle_info(Msg, Fd) ->
    io:format("writing message to log...~n"),
    file:write(Fd, io_lib:fwrite("~p.\n", [Msg])),
    {noreply, Fd}.

terminate(normal, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.

% start a server with:
% Server = logger:alloc()
% stop it with logger.stop()
