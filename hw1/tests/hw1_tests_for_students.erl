-module(hw1_tests_for_students).
-export ([run_test/0]).


%---valid shapes

validRectangle1() -> {rectangle,{dim,1,2}}.		% size 2
validRectangle3() -> {rectangle,{dim,5,5}}.		% size 25
validRectangle4() -> {rectangle,{dim,1,1}}.		% size 1

validTriangle2() -> {triangle,{dim,3,2}}.		% size 3
validTriangle3() -> {triangle,{dim,4,4}}.		% size 8

validEllipse1() -> {ellipse,{radius,1,2}}.       	
validEllipse2() -> {ellipse,{radius,3,2}}.			

%---valid structs
validShapes1() -> {shapes,[validEllipse1(), validEllipse1(), validRectangle1(), validTriangle2(), validRectangle3() ]}.
validShapes4() -> {shapes,[validEllipse2(),validRectangle1(), validTriangle2() , validTriangle3(), validRectangle3(), validRectangle4()]}.


run_test() ->
	io:format("expecting ~p and got ~p ~n",[57.84955592153876,shapes:shapesArea(validShapes4())]),
	RectFun1 = shapes:shapesFilter(rectangle),
	io:format("expecting ~p and got ~p ~n",[{shapes,[{rectangle,{dim,1,2}},{rectangle,{dim,5,5}}]},RectFun1(validShapes1())]),
	io:format("expecting ~p and got ~p ~n",[true,game:canWin(2)]),
	io:format("expecting ~p and got ~p ~n",[false,game:canWin(3)]).



	