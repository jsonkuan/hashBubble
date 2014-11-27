%% @author Nicole Musco


-module(schedule).
-export([start/0, stop/0]).

start() -> 
	erlang:display("timer started"),
	start(erlang:localtime()).

start({_Date, {_, _, 00}}) ->
	twitterserver:get_tweets(),
	CurrentTime = erlang:localtime(),
	erlang:display("i am sleeping now!, love twitter"),
	timer:sleep(1000),
	start(CurrentTime);

start({_Date, {_,_, S}}) when S rem 5 =:= 0 ->
	twitterserver:get_insta(),
	CurrentTime = erlang:localtime(),
	erlang:display("goodnight instagram!"),
	timer:sleep(1000),
	start(CurrentTime);

start({_Date, _Time}) ->
	CurrentTime = erlang:localtime(),
	timer:sleep(1000),
	start(CurrentTime).


stop() -> 
	{ok, stopped_schedule}.