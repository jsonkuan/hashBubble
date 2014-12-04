%% @author Nicole Musco


-module(schedule).
-export([start/0]).


%%schedule used for restarting twitter feed every minute and 
%%restarting the instagram feed every five seconds (only one object at a time)
start() -> 
	erlang:display("timer started"),
	start(erlang:localtime()).

%%every new minute, get tweets then sleep for a second, start over
start({_Date, {_, _, 00}}) ->
	twitterserver:get_tweets(),
	CurrentTime = erlang:localtime(),
	erlang:display("i am sleeping now!, love twitter"),
	timer:sleep(1000),
	start(CurrentTime);

%%every 5 seconds, get instagram data then sleep for a second, start over
start({_Date, {_,_, S}}) when S rem 5 =:= 0 ->
	twitterserver:get_insta(),
	CurrentTime = erlang:localtime(),
	erlang:display("goodnight instagram!"),
	timer:sleep(1000),
	start(CurrentTime);

%%if no pattern matches, sleep for a second then start over
%%the purpose of this is to prevent the schedule from stopping if the other patterns dont match
start({_Date, _Time}) ->
	CurrentTime = erlang:localtime(),
	timer:sleep(1000),
	start(CurrentTime).
