-module(test_shapes_arik).
-export([testShapesArea1/0]).
-export([testShapesArea2/0]).
-export([testSquaresArea1/0]).
-export([testSquaresArea2/0]).
-export([testTrianglesArea1/0]).
-export([testTrianglesArea2/0]).
-export([testShapesFilter1/0]).
-export([testShapesFilter2/0]).
-export([testShapesFilter21/0]).
-export([testShapesFilter22/0]).

testShapesArea1() ->
Shapes = {shapes, [{rectangle, {dim, 1, 2}}, {rectangle, {dim, 2, 2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
_Result = shapes:shapesArea(Shapes). %Expected ~58.865

testShapesArea2() ->
Shapes = {shapes, [{rectangle, {dim, -1, -2}}, {rectangle, {dim, 2, 2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
_Result = shapes:shapesArea(Shapes). %Expected crash


testSquaresArea1() ->
Shapes = {shapes, [{rectangle, {dim, 1, 2}}, {rectangle, {dim, 2, 2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
_Result = shapes:squaresArea(Shapes). %Expected 4

testSquaresArea2() ->
Shapes = {shapes, [{rectangle, {dim, 1, 2}}, {rectangle, {dim, -2, -2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
_Result = shapes:squaresArea(Shapes). %Expected crash

testTrianglesArea1() ->
Shapes = {shapes, [{rectangle, {dim, 1, 2}}, {rectangle, {dim, 2, 2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
_Result = shapes:trianglesArea(Shapes). %Expected 2.6

testTrianglesArea2() ->
Shapes = {shapes, [{rectangle, {dim, 1, 2}}, {rectangle, {dim, 2, -2}}, {triangle, {dim, -4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
_Result = shapes:trianglesArea(Shapes). %Expected crash

testShapesFilter1() ->
Shapes = {shapes, [{rectangle, {dim, 1, 2}}, {rectangle, {dim, 2, 2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
Result = shapes:shapesFilter(rectangle),
Result(Shapes).

testShapesFilter2() ->
Shapes = {shapes, [{rectangle, {dim, -1, 2}}, {rectangle, {dim, 2, 2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
Result = shapes:shapesFilter(triangle),
Result(Shapes).

testShapesFilter21() ->
Shapes = {shapes, [{rectangle, {dim, 1, 2}}, {rectangle, {dim, 2, 2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
Result = shapes:shapesFilter2(square),
Result(Shapes).

testShapesFilter22() ->
Shapes = {shapes, [{rectangle, {dim, -1, 2}}, {rectangle, {dim, 2, 2}}, {triangle, {dim, 4, 1.3}}, {ellipse, {radius, 4, 3}}, {ellipse, {radius, 2, 2}}]},
Result = shapes:shapesFilter2(triangle),
Result(Shapes).

