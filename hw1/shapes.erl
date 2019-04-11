-module(shapes).

-export([shapesArea/1]).
-export([squaresArea/1]).
-export([trianglesArea/1]).
-export([shapesFilter/1]).
-export([shapesFilter2/1]).

%==============================================================================
%                                   Aux
%==============================================================================

% check that the shapes struct is valid - safe.
checkShapes({shapes, []}) -> void;
checkShapes({shapes, [{rectangle, {dim, Width, Height}}|T]}) when Width > 0, Height > 0 ->
    checkShapes({shapes, T});
checkShapes({shapes, [{triangle, {dim, Base, Height}}|T]}) when Base > 0, Height > 0 ->
    checkShapes({shapes, T});
checkShapes({shapes, [{ellipse, {radius, Radius1, Radius2}}|T]}) when Radius1 > 0, Radius2 > 0 ->
    checkShapes({shapes, T}).


% compute area for single shape - not safe.
% ASSUMPTION: the shape struct is valid.
singleArea({rectangle, {dim, Width, Height}}) ->
    Width * Height;
singleArea({triangle, {dim, Base, Height}}) ->
    (Base * Height)/2;
singleArea({ellipse, {radius, Radius1, Radius2}}) ->
    math:pi() * Radius1 * Radius2.


% for tail recursion.
% ASSUMPTION: the shape struct is valid.
shapesAreaAux({shapes, []}, Sum) -> Sum;
shapesAreaAux({shapes, [H|T]}, Sum) ->
    shapesAreaAux({shapes, T}, Sum + singleArea(H)).


%==============================================================================
%                                   API
%==============================================================================

% safe
shapesArea({shapes, L}) ->
    checkShapes({shapes, L}),
    shapesAreaAux({shapes, L}, 0).


% safe
squaresArea({shapes, L}) ->
    checkShapes({shapes, L}),
    FL = [{rectangle, {dim, Width, Width}} || {rectangle, {dim, Width, Width}}<-L],
    shapesAreaAux({shapes, FL}, 0).


% safe
trianglesArea({shapes, L}) ->
    checkShapes({shapes, L}),
    FL = [{triangle, {dim, Base, Width}} || {triangle, {dim, Base, Width}}<-L],
    shapesAreaAux({shapes, FL}, 0).


% safe
shapesFilter(Shape) when Shape =:= rectangle ; Shape =:= triangle ; Shape =:= ellipse ->
    fun({shapes, L}) ->
        checkShapes({shapes, L}),
        {shapes, [{S, {X, Y, Z}} || {S, {X, Y, Z}}<-L, S =:= Shape]}
    end.


% safe
shapesFilter2(square) ->
    fun({shapes, L}) ->
        checkShapes({shapes, L}),
        {shapes, [{rectangle, {dim, Y, Y}} || {rectangle, {dim, Y, Y}}<-L]}
    end;
shapesFilter2(circle) ->
    fun({shapes, L}) ->
        checkShapes({shapes, L}),
        {shapes, [{ellipse, {radius, Y, Y}} || {ellipse, {radius, Y, Y}}<-L]}
    end;
shapesFilter2(Shape) when Shape =:= rectangle ; Shape =:= triangle ; Shape =:= ellipse ->
    shapesFilter(Shape).


