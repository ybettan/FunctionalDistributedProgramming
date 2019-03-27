-module(mymath).
-export([power/2]).

% return X^Y
power(_, 0) -> 1;
power(X, 1) -> X;
power(X, Y) -> X * power(X, Y-1).
