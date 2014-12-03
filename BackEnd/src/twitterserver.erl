

-module(twitterserver).
-export([init/1, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start/0, get_tweets/0, get_insta/0, stop/0]).
- behavior(gen_server).

-record(state, {}).
-define(SERVER, ?MODULE).

%%register process locally as tweet
%%module is twitterserver
%%args, opts empty for now
start() ->
    gen_server:start_link({local, tweet}, twitterserver, [], []).

init([]) ->
    erlang:display("Server Started"),
    {ok, #state{}}.

get_tweets() -> gen_server:cast(tweet, twitter).

get_insta() -> gen_server:cast(insta, instagram).

stop() -> gen_server:cast(tweet, stop).

%%handling message from get_tweets/cast and spawning process to run twitterminer example
handle_cast(twitter, State) ->
    spawn(fun() -> twitter:streaming() end),
    {noreply, State};

%%handling message from get_insta/cast and spawning another process to run instagram code
handle_cast(instagram, State) ->
    spawn(fun() -> instagram:url() end),
    {noreply, State};

handle_cast(stop, State) ->
    {stop, normal, State}.


terminate(normal, _State) ->
erlang:display("Process has been terminated"),
ok.

%%handling exit messages so server doesnt crash when message comes in
handle_info({'EXIT', _Pid, normal}, State) ->
    {noreply, State};
handle_info({'EXIT', Pid, Reason}, State) ->
    io:format("Process: ~p exited with reason: ~p~n",[Pid, Reason]),
    {noreply, State};
handle_info(_Msg, State) ->
    io:format("Unexpected message: ~p~n", [_Msg]),
    {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
    %%no change planned, function is therefor behavior and is not used
    {ok, State}.