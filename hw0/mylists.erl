-module(mylists).
-export([nth/2]).

% return the Nth element of a list
nth(_, []) -> "out of range";
nth(0, [Head | _]) -> Head;
nth(Nth, [_ | Tail]) -> nth(Nth-1, Tail).
