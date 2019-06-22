-module(serverWorker).

-behaviour(gen_server).

% callbacks
-export([start/1]).
-export([calc_fun_aux/3]). %make private ?

-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).

%==============================================================================
%                                   Aux
%==============================================================================

calc_fun_aux(ClientPid, F, MsgRef)->
    Res = F(),
    ClientPid ! {MsgRef, Res}.


%==============================================================================
%                                Callbacks
%==============================================================================

init([])->
    process_flag(trap_exit, true),
    {ok, 0}.

handle_call(get_num_running_funcs, _From, State)->
    {reply, State, State}.

handle_cast({calc_func, ClientPid, F, MsgRef}, State)->
    spawn_link(?MODULE, calc_fun_aux, [ClientPid, F, MsgRef]),
    {noreply, State+1}.

% the linked process that computed the function is done, update the state
handle_info({'EXIT', _Pid, _Reason}, State)->
    {noreply, State-1}.

terminate(_Reason, _State)->
    ok.

code_change(_OldVsn, State, _Extra)->
    {ok, State}.

%==============================================================================
%                                API
%==============================================================================

start(Name)->
    gen_server:start_link({local, Name}, ?MODULE, [], []).


