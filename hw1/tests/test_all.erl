-module(test_all).
-author("IdoYe & ohadZ").

%% API
-export([test_all/0]).

test_all() ->
  compile:file(shapes),
  compile:file(game),
  compile:file(test_game),
  compile:file(test_shapes),
  compile:file(hw1_tests_for_students),
  erlang:display("all modules compiled successfully"),
  erlang:display("testing hw1_tests_for_students"),
  hw1_tests_for_students:run_test(),
  erlang:display("testing shapes module"),
  test_shapes:test(),
  erlang:display("testing game module"),
  test_game:test().
