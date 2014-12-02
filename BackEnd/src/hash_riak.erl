- module(hash_riak).
- export([streaming/0,hash_save/2]).


hash_save(R, {parsed_tweet, _L, B, {id, I}}) ->
%save_tweet(R, {parsed_tweet, _L, MyBucket, {id, Val1}}) ->

%X = filter(B),
Time = erlang:term_to_binary(calendar:local_time()),
A = filter(B),
io:format("~p~n", [A]),
 case A of 
 	not_found -> not_found;
 	[{<<"hashtags">>,Hash}, {<<"media_url">>,Media_Url}, {<<"lang">>,Language}, {<<"location">>,Location}]  ->  
 
   
     Obj = riakc_obj:new(<<"twitter">>,
                    Media_Url,
                   erlang:term_to_binary({Time, Hash}),
                    <<"text/plain">>
                    ),
MD1 = riakc_obj:get_update_metadata(Obj),
MD2 = riakc_obj:set_secondary_index(
    MD1,
    [{{binary_index, "hashtags"}, [Hash]},
     {{binary_index, "lang"}, [Language]},
     {{binary_index, "location"}, [Location]}]),
Obj2 = riakc_obj:update_metadata(Obj, MD2),
riakc_pb_socket:put(R, Obj2) end.
   
   
  %riakc_pb_socket:put(R, Obj, [{w, 0}]) end;

%hash_save(_, _) -> ok.


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
twitterminer_riak:twitter_example().

