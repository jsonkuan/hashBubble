-module(sample).
-export([start/0]).

%-include("twitter.hrl").

start() ->
  % erl -pa ebin -s crypto -s inets
  crypto:start(),
  inets:start(),
  ssl:start(),

    Consumer_key = "BKBMw2DX7WcCHYQHtNjUZ5Ip7",
    Consumer_secret = "7bn2XloUssnY5aQxi1hrLVumdzU9ve6Ttgy3ROTcJ2gBmGmEkJ",
    Access_token = "2789867073-ANe9GLL3WLNwCK06emO4SoifBL2SCCSF2Xr8k6V",
    Access_token_secret = "S6WQntOsWEastkynxxffkFPlVyweoLbDjG4TLwsZUBv5w",

    Consumer = {Consumer_key, Consumer_secret, hmac_sha1},
  URL = "https://api.twitter.com/1.1/search/tweets.json?"	,
  Query = [{track, "media"}],
  oauth:get(URL, Query, Consumer, Access_token, Access_token_secret).
 
  

