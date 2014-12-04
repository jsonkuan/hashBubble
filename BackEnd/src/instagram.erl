%% @author Regine Aquino

%%this module handles pulling instagram data, decoding it, and filtering it to get the format we want
-module(instagram).
-export([start/0,url/0,insta_streaming/0]).
-compile(export_all).

%%need these applications started in order to run instagram code
start() ->
  ibrowse:start(),
  ssl:start().

insta_streaming() -> instagram_pull(0).

 instagram_pull(3) -> instagram_is_done_20_times;
  instagram_pull(N) ->
    url(), instagram_pull(N+1).

%%url is the link we need to pull media from instagram then send it to the filter
url ()-> 
  %io:format("Instagram_print~n"),
    URL = "https://api.instagram.com/v1/media/popular?access_token=1402100584.f45dfca.45b91c8f0be0487eb036f3220aeec143",
    case ibrowse:send_req(URL, [], get) of
      {ok,_,_,Body} -> 
     % jiffy:decode(Body)
    insta_save(Body)      
    end.


insta_save(Body) ->

A = filter_Inst(Body),
 case A of 
  not_found -> io:format("Instagram is not found Hashtag~n");
  [{Hashtag,Hash}, {URL,Media_Url}, {Lang,Language}, {Locate,Location}]  -> 
  Object = [{Hashtag,Hash}, {URL,Media_Url}, {Lang,Language}, {Locate,Location}],
            {ok, R} = riakc_pb_socket:start("127.0.0.1", 10017),
  storing:store(R, Object) end.


%%@author Saipirun Sanprom
%%filter recieved instagram data by decoding with Jiffy and using pattern matching to keep hashtag and url
%%found that Jiffy is not the best tool to use with instagram but twitter was the main focus so we dont have time to try mochiweb instead
%%if found desired info, print data
%%else print "not_found"
filter_Inst(Body) -> 
{List} = jiffy:decode(Body),
   case lists:keysearch(<<"data">>,1, List) of {value,{_,[{E}|_T]}} -> %io:format("~p~n",[List]),
    case lists:keysearch(<<"tags">>,1, E) of 
            {value,{_,Tag}} when Tag =/= [] -> 
            case lists:keysearch(<<"type">>,1, E) of
              {value,{_, <<"image">>}} ->
                [{<<"hashtags">>,getTag(Tag)}, 
                {<<"media_url">>, getURL(E)}, 
                {<<"lang">>,<<>>}, 
                {<<"location">>,<<>>}];
              _ -> not_found end;
            _ -> not_found end;
    _ -> not_found end.

%%only take url      
getURL(E) ->
case lists:keysearch(<<"link">>,1,E) of {value,{_,URL}} -> URL end. 

%%only take first hashtag in case of finding several
getTag([H|_T]) -> H. 
