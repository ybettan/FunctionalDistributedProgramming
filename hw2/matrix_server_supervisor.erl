-module(matrix_server_supervisor).

-export([start_server/0]).

%==============================================================================
%                                   Aux
%==============================================================================

restarter(From) ->
    process_flag(trap_exit, true),
    Pid = spawn_link(matrix_server, loop, []),
    register(matrix_server, Pid),
    From ! started,
    receive
        {'EXIT', Pid, normal} -> ok;
        {'EXIT', Pid, _} -> restarter(From)
    end.

%==============================================================================
%                                   API
%==============================================================================

start_server() ->
    Self = self(),
    spawn(fun() -> restarter(Self) end),
    receive
        started -> ok
    end.


