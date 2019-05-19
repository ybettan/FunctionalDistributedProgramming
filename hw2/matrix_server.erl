-module(matrix_server).

-export([start_server/0]).
-export([shutdown/0]).
-export([get_version/0]).
-export([mult/2]).
-export([explanation/0]).

-export([loop/0]).


%==============================================================================
%                                   Aux
%==============================================================================

cleanup() ->
    unregister(matrix_server),
    ok.


rpc(Request) ->
    Timeout = 1000,
    Self = self(),
    MsgRef = make_ref(),
    matrix_server ! {Self, MsgRef, Request},
    receive
        Res -> Res
    after
        Timeout ->
            rpc(Request)
    end.


vec_mul(Pid, [], [], Sum) -> Pid ! Sum;
vec_mul(Pid, [H1|T1], [H2|T2], Sum) ->
    vec_mul(Pid, T1, T2, Sum + (H1 * H2)).


mat_mul_compute_single_elem(Pid, Mat1, Mat2, Index) ->
    NCols = tuple_size(matrix:getRow(Mat2,1)),
    Row_idx = (Index div NCols) + 1,
    Col_idx = (Index rem NCols) + 1,
    Row = tuple_to_list(matrix:getRow(Mat1, Row_idx)),
    Col = tuple_to_list(matrix:getCol(Mat2, Col_idx)),
    Elem = vec_mul(Pid, Row, Col, 0),
    Pid ! {Row_idx, Col_idx, Elem}.


% all elements where updated, send the result back to caller.
mat_mul_aux(Pid, MsgRef, _, _, -1, 0, Res) ->
    Pid ! {MsgRef, Res};
% gather all results
mat_mul_aux(Pid, MsgRef, _Mat1, _Mat2, -1, NElemsToUpdate, Res) ->
    receive
        {Row_idx, Col_idx, Elem} ->
            NewRes = matrix:setElementMat(Row_idx, Col_idx, Res, Elem),
            mat_mul_aux(Pid, MsgRef, _Mat1, _Mat2, -1, NElemsToUpdate - 1, NewRes)
    end;
% create a process for each element in the result matrix
mat_mul_aux(Pid, MsgRef, Mat1, Mat2, Index, NElemsToUpdate, Res) ->
    Self = self(),
    spawn(fun() ->mat_mul_compute_single_elem(Self, Mat1, Mat2, Index) end),
    mat_mul_aux(Pid, MsgRef, Mat1, Mat2, Index - 1, NElemsToUpdate, Res).


% Index is in range [0, NRows * NCols - 1].
mat_mul(Pid, MsgRef, Mat1, Mat2) ->
    NRows = tuple_size(Mat1),
    NCols = tuple_size(matrix:getRow(Mat2,1)),
    ZeroMat = matrix:getZeroMat(NRows, NCols),
    MaxIndex = NRows * NCols - 1,
    mat_mul_aux(Pid, MsgRef, Mat1, Mat2, MaxIndex, MaxIndex + 1, ZeroMat).


loop() ->
    receive
        shutdown ->
            cleanup(),
            ok;
        {Pid, MsgRef, get_version} ->
            Pid ! {MsgRef, version_1},
            loop();
        {Pid, MsgRef, {multiple, Mat1, Mat2}} ->
            % mat_mul is sending the result directly to rpc caller.
            spawn(fun() -> mat_mul(Pid, MsgRef, Mat1, Mat2) end),
            loop();
        sw_upgrade ->
            ?MODULE:loop();
        % don't keep garbage messages
        _Other ->
            loop()
    end.


%==============================================================================
%                                   API
%==============================================================================

start_server() ->
    matrix_server_supervisor:start_server().


shutdown() ->
    matrix_server ! shutdown.


get_version() ->
    {_MsgRef, Version} = rpc(get_version),
    Version.


mult(Mat1, Mat2) ->
    {_MsgRef, Res} = rpc({multiple, Mat1, Mat2}),
    Res.


explanation() ->
    {"If they are both in the same module then, when we upgrade the server,
     the supervisor will stay in the old version therefore we will have 2
     version of the same module loaded and since Erlang VM can hold only 2
     version of the same module at any time we won't be able to upgrade again"}.




