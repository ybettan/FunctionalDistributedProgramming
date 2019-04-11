-module(game).

-export([canWin/1]).
-export([nextMove/1]).
-export([explanation/0]).

%==============================================================================
%                                   Aux
%==============================================================================

% safe
canWinAux(0) -> {false, 0};
canWinAux(1) -> {true, 1};
canWinAux(2) -> {true, 2};
canWinAux(N) ->
    CanWin1 = not element(1, canWinAux(N-1)),
    CanWin2 = not element(1, canWinAux(N-2)),
    if
        CanWin1 -> {true, 1};
        CanWin2 -> {true, 2};
        true -> {false, 0}
    end.

%==============================================================================
%                                   API
%==============================================================================

% safe
canWin(N) when is_integer(N), N >= 0 ->
    {Res, _} = canWinAux(N),
    Res.


% safe
nextMove(N) when is_integer(N), N >=0 ->
    {Res, Num} = canWinAux(N),
    if
        Res =:= true -> {Res, Num};
        Res =:= false -> false
    end.


% safe
explanation() ->
    {"We have to remember the first branch of the recursive tree in case we need to take only 1 match to win, therfore we need the result of the recursive call so tail recursion is probelmatic here."}.


