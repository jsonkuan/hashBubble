-module(instagram).
-export([start/0,url/0]).
-compile(export_all).

start() ->
  ibrowse:start(),
  ssl:start().

url ()-> 
    URL = "https://api.instagram.com/v1/media/popular?access_token=1402100584.f45dfca.45b91c8f0be0487eb036f3220aeec143",
    case ibrowse:send_req(URL, [], get) of
      {ok,_,_,Body} -> 
      filter_Inst(Body)      %io:format("~p~n", [X])
    end.

filter_Inst(Body) -> 
{List} = jiffy:decode(Body),
   case lists:keysearch(<<"data">>,1, List) of {value,{_,[{E}|_T]}} -> %io:format("~p~n",[List]),
    case lists:keysearch(<<"tags">>,1, E) of 
            {value,{_,Tag}} when Tag =/= [] -> 
            X = {{<<"insta_hashtags">>,getTag(Tag)}, {<<"media_url">>, getURL(E)}, {<<"lang">>,<<>>}, {<<"location">>,<<>>} }
            , io:format("~p~n", [X]);
            _ -> not_found, io:format("not_found_insta~n" ) end;
    _ -> not_found, io:format("not_found_insta~n" ) end.
      
getURL(E) ->
case lists:keysearch(<<"link">>,1,E) of {value,{_,URL}} -> URL end. 

getTag([H|_T]) -> H. 

%pull_Ins() ->
%application:ensure_all_started(twitterminer),
%url().
%stream!
