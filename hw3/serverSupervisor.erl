-module(serverSupervisor).

-behaviour(supervisor).

-export([init/1]).

%==============================================================================
%                                Callbacks
%==============================================================================

init([])->
    SupFlags = {one_for_one, 3, 600},
    ChildSpec1 = {server1, {serverWorker, start, [server1]}, permanent, 5000,
                  worker, [serverWorker]},
    ChildSpec2 = {server2, {serverWorker, start, [server2]}, permanent, 5000,
                  worker, [serverWorker]},
    ChildSpec3 = {server3, {serverWorker, start, [server3]}, permanent, 5000,
                  worker, [serverWorker]},
    {ok,{SupFlags,[ChildSpec1, ChildSpec2, ChildSpec3]}}.

