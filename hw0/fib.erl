-module(fib).
-export([fib/1]).

% the Nth element in the Fibonacci series
fib(0) -> 0;
fib(1) -> 1;
fib(N) -> fib(N-1) + fib(N-2).
