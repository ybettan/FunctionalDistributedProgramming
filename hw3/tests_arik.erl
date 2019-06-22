-module(tests_arik).
-export([test/0, test2/0, test3/0]).


test() ->
    loadBalance:startServers(),
    0 = loadBalance:numberOfRunningFunctions(1),
    0 = loadBalance:numberOfRunningFunctions(2),
    0 = loadBalance:numberOfRunningFunctions(3),
    ok = loadBalance:calcFun(self(),fun() -> timer:sleep(10), 5*5 end, make_ref()),
    1 = loadBalance:numberOfRunningFunctions(1),
    0 = loadBalance:numberOfRunningFunctions(2),
    0 = loadBalance:numberOfRunningFunctions(3),
    receive
        {_MsgRef , Res} -> 25 = Res
    end,
    loadBalance:stopServers(),
    test_passed.

test2() ->
    loadBalance:startServers(),
    0 = loadBalance:numberOfRunningFunctions(1),
    0 = loadBalance:numberOfRunningFunctions(2),
    0 = loadBalance:numberOfRunningFunctions(3),
    ok = loadBalance:calcFun(self(),fun() -> timer:sleep(10), 5*5 end, make_ref()),
    ok = loadBalance:calcFun(self(),fun() -> timer:sleep(10), 5*6 end, make_ref()),
    ok = loadBalance:calcFun(self(),fun() -> timer:sleep(10), 5*7 end, make_ref()),
    1 = loadBalance:numberOfRunningFunctions(1),
    1 = loadBalance:numberOfRunningFunctions(2),
    1 = loadBalance:numberOfRunningFunctions(3),
    receive
        {_, 25} -> ok
        after 1000 -> 
            loadBalance:stopServers(),
            erlang:error(test_failed)
    end,
    receive
        {_ , 30} -> ok
        after 1000 -> 
            loadBalance:stopServers(),
            erlang:error(test_failed)
    end,
    receive
        {_ , 35} -> ok
        after 1000 -> 
            loadBalance:stopServers(),
            erlang:error(test_failed)
    end,
    loadBalance:stopServers(),
    test_passed.
    
test3() ->
    loadBalance:startServers(),
    0 = loadBalance:numberOfRunningFunctions(1),
    0 = loadBalance:numberOfRunningFunctions(2),
    0 = loadBalance:numberOfRunningFunctions(3),
    spawn_functions(29),
    10 = loadBalance:numberOfRunningFunctions(1),
    10 = loadBalance:numberOfRunningFunctions(2),
    9 = loadBalance:numberOfRunningFunctions(3),
    loadBalance:stopServers(),
    test_passed.
    
spawn_functions(0) ->
    ok;

spawn_functions(N) ->
    ok = loadBalance:calcFun(self(),fun() -> timer:sleep(rand:uniform(100)), 5*5 end, make_ref()),
    spawn_functions(N - 1).


