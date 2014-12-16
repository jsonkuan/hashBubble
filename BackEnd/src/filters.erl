-module(filters).


- export([filter_twitter/1, filter_instagram/1]).


filter_twitter({parsed_tweet, _L, B, {id, _I}}) ->

A = filter(B),
 case A of 
 	not_found -> not_found;
 	[{<<"hashtags">>,Hash}, {<<"media_url">>,Media_Url}, {<<"lang">>,Language}, {<<"location">>,Location}]  -> 
  Object = [{<<"hashtags">>,Hash}, {<<"media_url">>,Media_Url}, 
            {<<"lang">>,Language}, {<<"location">>,Location}],
  storing:store(<<"twitter_data">>, Object) end;
  filter_twitter(_) -> ok.


filter(Object)->
{List} = jiffy:decode(Object),
case lists:keysearch(<<"entities">>,1,List) of 
{value,{_,{E}}} ->
  case lists:keysearch(<<"hashtags">>,1,E) of
    {value, {<<"hashtags">>, Ss}} when Ss =/= []-> Hash = {<<"hashtags">>, getHashTag(Ss)},
    
    case lists:keysearch(<<"media">>,1, E) of
      {value, {_, [{Media}]}}->  case lists:keysearch(<<"media_url">>, 1, Media) of
                      {value, Media_Url} ->
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

%% End of Twitter filter %%



filter_instagram(Body) ->

A = filter_Inst(Body),
 case A of 
 not_found -> ok;
  [{Hashtag,Hash}, {URL,Media_Url}, {Lang,Language}, {Locate,Location}]  -> 
  Object = [{Hashtag,Hash}, {URL,Media_Url}, {Lang,Language}, {Locate,Location}],
  storing:store(<<"instagram_data">>, Object) end.


%%@author Saipirun Sanprom
%%filter recieved instagram data by decoding with Jiffy and using pattern matching to keep hashtag and url
%%found that Jiffy is not the best tool to use with instagram but twitter was the main focus so we dont have time to try mochiweb instead
%%if found desired info, print data
%%else print "not_found"
filter_Inst(Body) -> 
{List} = jiffy:decode(Body),
   case lists:keysearch(<<"data">>,1, List) of {value,{_,[{E}|_T]}} -> 
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