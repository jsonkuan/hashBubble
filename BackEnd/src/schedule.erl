%% @author Nicole Musco


-module(schedule).
-export([start/0]).


%%schedule used for restarting twitter feed every minute and 
%%restarting the instagram feed every five seconds (only one object at a time)
start() -> 
	start(erlang:localtime()).

%%every day at this time, using map reduce to get 20 most popular hashtags, 
%%sleeps, starts local time again
start({_Date, {3,03,03}) ->
	hb_server:get_top_20_twitter(),
	timer:sleep(1*60*1000),
	hb_server:get_top_20_instagram(),
	timer:sleep(1000),
	start(erlang:localtime());

%%every new minute, get tweets then sleep for a second, start over
start({_Date, {_, _, 00}}) ->
	hb_server:get_tweets(),
	timer:sleep(1000),
	start(erlang:localtime());

%%every 5 seconds, get instagram data then sleep for a second, start over
start({_Date, {_,_, S}}) when S rem 5 =:= 0 ->
	hb_server:get_insta(),
	timer:sleep(1000),
	start(erlang:localtime());

%%if no pattern matches, sleep for a second then start over
%%the purpose of this is to prevent the schedule from stopping if the other patterns dont match
start({_Date, _Time}) ->
	timer:sleep(1000),
	start(erlang:localtime()).

