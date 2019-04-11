-module(test_shapes).

%% ====================================================================
%% API functions
%% ====================================================================
-export([test/0]).

test() ->


  Square1 = {rectangle, {dim, 1, 1}},
  Rectangle2 = {rectangle, {dim, 2, 4}},
  Rectangle_ill = {rectangle, {dim, 1, 0}},
  Rectangle_ill2 = {rectangle, {dim, -1, 1}},
  Triangle1 = {triangle, {dim, 1, 1}},
  Triangle2 = {triangle, {dim, 2, 2}},
  Triangle_ill = {triangle, {dim, -1, 1}},
  Ellipse1 = {ellipse, {radius, 1, 2}},
  Circle2 = {ellipse, {radius, 1, 1}},
  Ellipse_ill = {ellipse, {radius, -1, 1}},
  NotValidObject = {t, {t, 1, 1}},
  NotShape = {notShape, {radius, -1, 1}},

  0 = shapes:shapesArea({shapes, []}),
  1 = shapes:shapesArea({shapes, [Square1]}),
  14.141592653589793 = shapes:shapesArea({shapes, [Square1, Triangle2, Rectangle2, Circle2]}),

  try shapes:shapesArea({shapes, [Square1, Square1, Rectangle_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error0 -> erlang:display({error, caught, Error0})
  end,

  try shapes:shapesArea({shapes, [Square1, Square1, Rectangle_ill2]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error1 -> erlang:display({error, caught, Error1})
  end,

  0 = shapes:squaresArea({shapes, [Circle2, Triangle1, Triangle2, Ellipse1]}), %no squares.
  1 = shapes:squaresArea({shapes, [Circle2, Triangle1, Square1]}),

  try shapes:shapesArea({shapes, [Circle2, Triangle_ill, Square1]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error2 -> erlang:display({error, caught, Error2})
  end,

  try shapes:squaresArea({shapes, [Circle2, Triangle_ill, Square1]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error3 -> erlang:display({error, caught, Error3})
  end,
  2 = shapes:squaresArea({shapes, [Square1, Circle2, Rectangle2, Triangle1, Square1]}),

  0 = shapes:trianglesArea({shapes, [Circle2, Rectangle2, Rectangle2, Ellipse1]}), %no tri.
  0.5 = shapes:trianglesArea({shapes, [Circle2, Triangle1, Square1]}),

  try shapes:trianglesArea({shapes, [Circle2, Triangle_ill, Square1]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error4 -> erlang:display({error, caught, Error4})
  end,

  2.5 = shapes:trianglesArea({shapes, [Triangle2, Circle2, Rectangle2, Triangle1, Square1]}),

  F1 = shapes:shapesFilter(rectangle),
  F2 = shapes:shapesFilter(triangle),
  F3 = shapes:shapesFilter(ellipse),

  ({shapes, []}) = F1({shapes, []}), %empty
  ({shapes, []}) = F1({shapes, [Ellipse1]}), %no rectangle
  ({shapes, [Square1]}) = F1({shapes, [Square1]}),
  ({shapes, [Square1]}) = F1({shapes, [Square1, Ellipse1]}),
  ({shapes, [Square1, Rectangle2]}) = F1({shapes, [Square1, Triangle1, Rectangle2]}),

  try F1({shapes, [Square1, Ellipse_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error5 -> erlang:display({error, caught, Error5})
  end,


  ({shapes, []}) = F2({shapes, []}), %empty
  ({shapes, []}) = F2({shapes, [Ellipse1]}), %no triangle
  ({shapes, [Triangle1]}) = F2({shapes, [Triangle1]}),
  ({shapes, [Triangle1]}) = F2({shapes, [Triangle1, Ellipse1]}),
  ({shapes, [Triangle1, Triangle2]}) = F2({shapes, [Square1, Triangle1, Triangle2]}),

  try F2({shapes, [Square1, Ellipse_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error6 -> erlang:display({error, caught, Error6})
  end,

  ({shapes, []}) = F3({shapes, []}), %empty
  ({shapes, []}) = F3({shapes, [Rectangle2]}), %no ellipse
  ({shapes, [Ellipse1]}) = F3({shapes, [Ellipse1]}),
  ({shapes, [Ellipse1]}) = F3({shapes, [Square1, Ellipse1]}),
  ({shapes, [Ellipse1, Circle2]}) = F3({shapes, [Ellipse1, Triangle1, Circle2]}),

  try F3({shapes, [Square1, Ellipse_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error7 -> erlang:display({error, caught, Error7})
  end,

  F4 = shapes:shapesFilter(rectangle),
  F5 = shapes:shapesFilter2(square),
  F6 = shapes:shapesFilter(triangle),
  F7 = shapes:shapesFilter(ellipse),
  F8 = shapes:shapesFilter2(circle),

  ({shapes, []}) = F4({shapes, []}), %empty
  ({shapes, []}) = F4({shapes, [Ellipse1]}), %no rectangle
  ({shapes, [Square1]}) = F4({shapes, [Square1]}),
  ({shapes, [Square1]}) = F4({shapes, [Square1, Ellipse1]}),
  ({shapes, [Square1, Rectangle2]}) = F4({shapes, [Square1, Triangle1, Rectangle2]}),

  try F4({shapes, [Square1, Ellipse_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error8 -> erlang:display({error, caught, Error8})
  end,

  ({shapes, []}) = F5({shapes, []}), %empty
  ({shapes, []}) = F5({shapes, [Ellipse1]}), %no square
  ({shapes, [Square1]}) = F5({shapes, [Square1]}),
  ({shapes, [Square1]}) = F5({shapes, [Square1, Ellipse1]}),
  ({shapes, [Square1]}) = F5({shapes, [Square1, Triangle1, Rectangle2]}),

  try F5({shapes, [Square1, Ellipse_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error9 -> erlang:display({error, caught, Error9})
  end,

  ({shapes, []}) = F6({shapes, []}), %empty
  ({shapes, []}) = F6({shapes, [Ellipse1]}), %no triangle
  ({shapes, [Triangle1]}) = F6({shapes, [Triangle1]}),
  ({shapes, [Triangle1]}) = F6({shapes, [Triangle1, Ellipse1]}),
  ({shapes, [Triangle1, Triangle2]}) = F6({shapes, [Square1, Triangle1, Triangle2]}),

  try F6({shapes, [Square1, Ellipse_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error10 -> erlang:display({error, caught, Error10})
  end,


  ({shapes, []}) = F7({shapes, []}), %empty
  ({shapes, []}) = F7({shapes, [Rectangle2]}), %no ellipse
  ({shapes, [Ellipse1]}) = F7({shapes, [Ellipse1]}),
  ({shapes, [Ellipse1]}) = F7({shapes, [Square1, Ellipse1]}),
  ({shapes, [Ellipse1, Circle2]}) = F7({shapes, [Ellipse1, Triangle1, Circle2]}),

  try F7({shapes, [Square1, Ellipse_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error11 -> erlang:display({error, caught, Error11})
  end,

  ({shapes, []}) = F8({shapes, []}), %empty
  ({shapes, []}) = F8({shapes, [Rectangle2]}), %no circle
  ({shapes, [Circle2]}) = F8({shapes, [Circle2]}),
  ({shapes, [Circle2]}) = F8({shapes, [Square1, Circle2]}),
  ({shapes, [Circle2]}) = F8({shapes, [Ellipse1, Triangle1, Circle2]}),

  try F8({shapes, [Square1, Ellipse_ill]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error12 -> erlang:display({error, caught, Error12})
  end,


  try shapes:shapesArea({shapes, [NotShape]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error13 -> erlang:display({error, caught, Error13})
  end,

  try shapes:shapesArea({shapes, [NotValidObject]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error14 -> erlang:display({error, caught, Error14})
  end,

  try shapes:shapesArea({notShapes, [Square1, Triangle2, Rectangle2, Circle2]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error15 -> erlang:display({error, caught, Error15})
  end,

  try F4({shapes, [NotShape]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error16 -> erlang:display({error, caught, Error16})
  end,

  try F4({shapes, [NotValidObject]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error17 -> erlang:display({error, caught, Error17})
  end,

  try F4({notShapes, [Square1, Triangle2, Rectangle2, Circle2]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error18 -> erlang:display({error, caught, Error18})
  end,

  try F5({shapes, [NotShape]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error19 -> erlang:display({error, caught, Error19})
  end,

  try F5({shapes, [NotValidObject]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error20 -> erlang:display({error, caught, Error20})
  end,

  try F5({notShapes, [Square1, Triangle2, Rectangle2, Circle2]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error21 -> erlang:display({error, caught, Error21})
  end,

  try F6({shapes, [NotShape]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error22 -> erlang:display({error, caught, Error22})
  end,

  try F6({shapes, [NotValidObject]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error23 -> erlang:display({error, caught, Error23})
  end,

  try F6({notShapes, [Square1, Triangle2, Rectangle2, Circle2]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error24 -> erlang:display({error, caught, Error24})
  end,

  try F7({shapes, [NotShape]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error25 -> erlang:display({error, caught, Error25})
  end,

  try F7({shapes, [NotValidObject]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error26 -> erlang:display({error, caught, Error26})
  end,

  try F7({notShapes, [Square1, Triangle2, Rectangle2, Circle2]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error27 -> erlang:display({error, caught, Error27})
  end,

  try F8({shapes, [NotShape]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error28 -> erlang:display({error, caught, Error28})
  end,

  try F8({shapes, [NotValidObject]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error29 -> erlang:display({error, caught, Error29})
  end,

  try F8({notShapes, [Square1, Triangle2, Rectangle2, Circle2]}) of
    _ -> erlang:display("expected error not thrown!!! Problem in your code")
  catch
    error:Error30 -> erlang:display({error, caught, Error30})
  end,
  ok.
