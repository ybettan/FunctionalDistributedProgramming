-module(test_game).

%% ====================================================================
%% API functions
%% ====================================================================
-export([test/0]).

test() ->

  try game:canWin(-1) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error0 -> erlang:display({error, caught, Error0})
  end,

  try game:canWin(2.2) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error1 -> erlang:display({error, caught, Error1})
  end,

  try game:nextMove(-1) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error2 -> erlang:display({error, caught, Error2})
  end,

  try game:nextMove(2.2) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error3 -> erlang:display({error, caught, Error3})
  end,

  true = game:canWin(1),
  true = game:canWin(2),
  false = game:canWin(3),
  true = game:canWin(4),
  true = game:canWin(5),
  true = game:canWin(7),
  true = game:canWin(4),
  {true, 1} = game:nextMove(1),
  {true, 2} = game:nextMove(2),
  false = game:nextMove(3),
  {true, 1} = game:nextMove(4),
  {true, 2} = game:nextMove(5),
  false = game:nextMove(6),
  erlang:display(game:explanation()),
  ok.
