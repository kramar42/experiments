-module(tutorial).
-export([start/0, listen/1, sum/0]).

start() ->
    SumPid = spawn(tutorial, sum, []),
    spawn(tutorial, listen, [SumPid]).


listen(SumPid) ->
    receive
        {One, Two} ->
            SumPid ! {self(), One, Two},
            listen(SumPid);
        {Sum} ->
            io:fwrite("Sum: ~w~n", [Sum]),
            listen(SumPid);
        stop -> ok;
        _ -> listen(SumPid)
    end.

sum() ->
    receive
        {Pid, One, Two} ->
            Pid ! {One + Two},
            sum();
        stop -> ok;
        _ -> sum()
    end.
