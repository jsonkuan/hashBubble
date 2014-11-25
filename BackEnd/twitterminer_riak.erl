-module(twitterminer_riak).

-export([twitter_example/0, twitter_save_pipeline/3, get_riak_hostport/1,filter/1,getHashTag/1,streaming/0,getLanguage/1,getLocation/1]).

-record(hostport, {host, port}).

% This file contains example code that connects to Twitter and saves tweets to Riak.
% It would benefit from refactoring it together with twitterminer_source.erl.

keyfind(Key, L) ->
  {Key, V} = lists:keyfind(Key, 1, L),
  V.

%% @doc Get Twitter account keys from a configuration file.
get_riak_hostport(Name) ->
  {ok, Nodes} = application:get_env(twitterminer, riak_nodes),
  {Name, Keys} = lists:keyfind(Name, 1, Nodes),
  #hostport{host=keyfind(host, Keys),
            port=keyfind(port, Keys)}.

%% @doc This example will download a sample of tweets and print it.
twitter_example() ->
	
   	URL = "https://stream.twitter.com/1.1/statuses/sample.json",

  % We get our keys from the twitterminer.config configuration file.
  Keys = twitterminer_source:get_account_keys(account1),

 % RHP = get_riak_hostport(riak1),
 % {ok, R} = riakc_pb_socket:start(RHP#hostport.host, RHP#hostport.port),
  {ok, R} = riakc_pb_socket:start("127.0.0.1",8087),
  % Run our pipeline
  P = twitterminer_pipeline:build_link(twitter_save_pipeline(R, URL, Keys)),

  % If the pipeline does not terminate after 60 s, this process will
  % force it.
  T = spawn_link(fun () ->
        receive
          cancel -> ok
        after 30000 -> % Sleep fo 60 s
            twitterminer_pipeline:terminate(P)
        end
    end),

  Res = twitterminer_pipeline:join(P),
  T ! cancel,
  Res.

%% @doc Create a pipeline that connects to twitter and
%% saves tweets to Riak. We save all messages that have ids,
%% which might include delete notifications etc.
twitter_save_pipeline(R, URL, Keys) ->


  Prod = twitterminer_source:twitter_producer(URL, Keys),

  % Pipelines are constructed 'backwards' - consumer is first, producer is last.
  [
    twitterminer_pipeline:consumer(
      fun(Msg, N) -> save_tweet(R, Msg), N+1 end, 0),
    twitterminer_pipeline:map(
      fun twitterminer_source:decorate_with_id/1),
    twitterminer_source:split_transformer(),
    Prod].

% We save only objects that have ids.
save_tweet(R, {parsed_tweet, _L, B, {id, I}}) ->
%save_tweet(R, {parsed_tweet, _L, MyBucket, {id, Val1}}) ->

%X = filter(B),
A = filter(B),
io:format("~p~n", [A]),
 case A of 
 	not_found -> not_found;
 	[{<<"hashtags">>,Hash}, {<<"media_url">>,Media_Url}, {<<"lang">>,Language}, {<<"location">>,Location}]  ->  
 
   
     Obj = riakc_obj:new(<<"twitter">>,
                    Media_Url,
                   <<"...user data...">>,
                    <<"text/plain">>
                    ),
MD1 = riakc_obj:get_update_metadata(Obj),
MD2 = riakc_obj:set_secondary_index(
    MD1,
    [{{binary_index, "hashtags"}, [Hash]},
     {{binary_index, "lang"}, [Language]},
     {{binary_index, "location"}, [Location]}]),
Obj2 = riakc_obj:update_metadata(Obj, MD2),
riakc_pb_socket:put(R, Obj2) end;
   
   
  %riakc_pb_socket:put(R, Obj, [{w, 0}]) end;

save_tweet(_, _) -> ok.

%try_Key(Object)->
%{List} = jiffy:decode(Object),
%case lists:keysearch(<<"entities">>,1,List) of 
%{value,{_,{E}}} ->
 % case lists:keysearch(<<"hashtags">>,1,E) of
  %  {value, {<<"hashtags">>, Ss}} when Ss =/= []-> Hash = {<<"hashtags">>, getHashTag(Ss)},
    
   % case lists:keysearch(<<"media">>,1, E) of
    %  {value, {_, [{Media}]}}->  case lists:keysearch(<<"media_url">>, 1, Media) of
     %                 {value, {_, Media_Url}} ->
                      %io:format("~p~n", [[Hash, Media_Url, getLanguage(List), getLocation(List)]]),
      %                Media_Url end; 
                     
    %_ -> io:format("It's not found ~n") end;

  %_-> io:format("It's not found ~n") end  end.


filter(Object)->
{List} = jiffy:decode(Object),
case lists:keysearch(<<"entities">>,1,List) of 
{value,{_,{E}}} ->
  case lists:keysearch(<<"hashtags">>,1,E) of
    {value, {<<"hashtags">>, Ss}} when Ss =/= []-> Hash = {<<"hashtags">>, getHashTag(Ss)},
    
    case lists:keysearch(<<"media">>,1, E) of
      {value, {_, [{Media}]}}->  case lists:keysearch(<<"media_url">>, 1, Media) of
                      {value, Media_Url} ->
                      %io:format("~p ~p ~p ~p~n", [Hash, Media_Url, getLanguage(List), getLocation(List)]),
                      [Hash, Media_Url, getLanguage(List), getLocation(List)] end; 
                  
        %             
    _ -> not_found end;

  _-> not_found end  end.

getLanguage(List) -> 
  case lists:keysearch(<<"user">>,1, List) of
    {value,{_,{User}}} -> case lists:keysearch(<<"lang">>,1, User) of 
      {value,{<<"lang">>,Language}} -> {<<"lang">>,Language} ;
      _ -> no_Language end end.
getLocation(List) ->
  case lists:keysearch(<<"user">>,1, List) of
    {value,{_,{User}}} -> case lists:keysearch(<<"location">>,1, User) of 
      {value,{<<"location">>,Location}} -> {<<"location">>,Location} ;
      _ -> no_Language end end.


getHashTag([{[{_,R},_]}|_T])-> R.

streaming() ->
application:ensure_all_started(twitterminer),
twitter_example().
