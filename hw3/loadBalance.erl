-module(loadBalance).

-export([startServers/0]).
-export([stopServers/0]).
-export([numberOfRunningFunctions/1]).
-export([calcFun/3]).

%==============================================================================
%                                   Aux
%==============================================================================

lightest_server()->
    NumFuncServer1 = gen_server:call(server1, get_num_running_funcs),
    NumFuncServer2 = gen_server:call(server2, get_num_running_funcs),
    NumFuncServer3 = gen_server:call(server3, get_num_running_funcs),
    if
        NumFuncServer1=<NumFuncServer2 andalso NumFuncServer1=<NumFuncServer3->
            server1;
        NumFuncServer2=<NumFuncServer1 andalso NumFuncServer2=<NumFuncServer3->
            server2;
        NumFuncServer3=<NumFuncServer1 andalso NumFuncServer3=<NumFuncServer2->
            server3
    end.

%==============================================================================
%                                   API
%==============================================================================

startServers()->
    supervisor:start_link({local, serverSupervisor}, serverSupervisor, []).

stopServers()->
    SupervisorPid = whereis(serverSupervisor),
    exit(SupervisorPid, normal).

numberOfRunningFunctions(Num) when Num > 0, Num < 4 ->
    Server = case Num of
                 1 -> server1;
                 2 -> server2;
                 3 -> server3
             end,
    gen_server:call(Server, get_num_running_funcs).

calcFun(ClientPid, F, MsgRef)->
    LightestServer = lightest_server(),
    gen_server:cast(LightestServer, {calc_func, ClientPid, F, MsgRef}),
    ok.

    


