-module(streaming).

-export([instagram_streaming/0, twitter_streaming/0]).


-record(insta_key, {access_token}).

keyfind(Key, L) ->
  {Key, V} = lists:keyfind(Key, 1, L),
  V.

instagram_streaming() -> instagram_pull(0).

 instagram_pull(3) -> instagram_is_done_20_times;
  instagram_pull(N) ->
    url(), instagram_pull(N+1).

get_instagram_key(Name) ->
  {ok, Nodes} = application:get_env(twitterminer, instagram),
  {Name, Key} = lists:keyfind(Name, 1, Nodes),
 #insta_key{access_token=keyfind(access_token, Key)}.

%%url is the link we need to pull media from instagram then send it to the filter
url ()-> 
 
AK = get_instagram_key(insta1),

    URL = string:concat("https://api.instagram.com/v1/media/popular?access_token=", AK#insta_key.access_token),
    case ibrowse:send_req(URL, [], get) of
      {ok,_,_,Body} -> 
    filters:filter_instagram(Body)      
    end.

    %%  end of instagram streaming  %%

    twitter_streaming() ->
	
   	URL = "https://stream.twitter.com/1.1/statuses/sample.json",


  % We get our keys from the twitterminer.config configuration file.
  Keys = twitterminer_source:get_account_keys(account1),

 
  % Run our pipeline
 % P = twitterminer_pipeline:build_link(twitter_save_pipeline(R, URL, Keys)),
P = twitterminer_pipeline:build_link(twitter_save_pipeline(URL, Keys)),
  % If the pipeline does not terminate after 60 s, this process will
  % force it.
  T = spawn_link(fun () ->
        receive
          cancel -> ok
        after 60000 -> % Sleep fo 60 s
            twitterminer_pipeline:terminate(P)
        end
    end),

  Res = twitterminer_pipeline:join(P),
  T ! cancel,
  Res.

%% @doc Create a pipeline that connects to twitter and
%% saves tweets to Riak. We save all messages that have ids,
%% which might include delete notifications etc.
%twitter_save_pipeline(R, URL, Keys) ->
twitter_save_pipeline(URL, Keys) ->

  Prod = twitterminer_source:twitter_producer(URL, Keys),

  % Pipelines are constructed 'backwards' - consumer is first, producer is last.
  [
    twitterminer_pipeline:consumer(
   % fun(Msg, N) -> save_tweet(Msg), N+1 end, 0),
fun(Msg, N) -> filters:filter_twitter(Msg), N+1 end, 0),
    twitterminer_pipeline:map(
      fun twitterminer_source:decorate_with_id/1),
    twitterminer_source:split_transformer(),
    Prod].

