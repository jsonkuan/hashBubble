

-module(hb_server).
-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2, code_change/3]).
-export([start/0, get_tweets/0, get_insta/0, stop/0, get_top_20_twitter/0, get_top_20_instagram/0]).
-behavior(gen_server).

-record(state, {}).
-define(SERVER, ?MODULE).

%%register process locally as tweet
%%module is twitterserver
%%args, opts empty for now
start() ->
    gen_server:start_link({local, tweet}, hb_server, [], []).

init([]) ->
    erlang:display("Server Started"),
    {ok, #state{}}.

get_top_20_twitter() -> gen_server:cast(tweet, mapreduce_twitter).

get_top_20_instagram() -> gen_server:cast(tweet, mapreduce_instagram).

get_tweets() -> gen_server:cast(tweet, twitter).

get_insta() -> gen_server:cast(tweet, instagram).

stop() -> gen_server:call(tweet, stop).

%%handling message from get_tweets/cast and spawning process to run map reduce and get 20 top instagram hashtags
handle_cast(mapreduce_instagram, State) ->
    spawn(fun() -> map_reduce:start(<<"instagram_data">>) end),
    {noreply, State};

%%handling message from get_tweets/cast and spawning process to run map reduce and get 20 top twitter hashtags
handle_cast(mapreduce_twitter, State) ->
    spawn(fun() -> map_reduce:start(<<"twitter_data">>) end),
    {noreply, State};

%%handling message from get_tweets/cast and spawning process to run twitterminer example
handle_cast(twitter, State) ->
    spawn(fun() -> streaming:twitter_streaming() end),
    {noreply, State};

%%handling message from get_insta/cast and spawning another process to run instagram code
handle_cast(instagram, State) -> 
    spawn(fun() -> streaming:instagram_streaming() end),
    {noreply, State}.

handle_call(stop, _From,  State) ->
    {stop, normal, State}.

%must be here to override, will crash if not implemented, dont argue.
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
