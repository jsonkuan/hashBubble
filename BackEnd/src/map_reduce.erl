-module(map_reduce).
-export([mapHash/3, reduceHash/2, mapred/3, get_link/0,
		close_link/1, get_bucket_keys/1, start_date/0,
		end_date/0, format_date/1, reverse/2, start/1]).


start(Bucket) ->
	Pid = get_link(),
	BucketKey = get_bucket_keys(Bucket),
	mapred(Bucket, BucketKey, Pid).

% it connect to Riak and return a pid
get_link() ->
 case riakc_pb_socket:start_link("127.0.0.1", 10017) of
	{ok, Pid} -> Pid end.


%The function stop the connection for calling data from Riak 
close_link(Pid) -> riakc_pb_socket:stop(Pid).

%map-reduce function call function mapHash/3 (map function) and function reduceHash/2 (reduce function)
% it return list of hashtags and number of hashtags in lists format.
mapred(Bucket, Keys,Pid) ->
%	Pid = get_link(),
	{ok, [{1, [Result]}]} = riakc_pb_socket:mapred(
		Pid,
		Keys,
		[
			{map, {modfun, ?MODULE, mapHash}, none, false},
			{reduce, {modfun, ?MODULE, reduceHash}, none, true}
		]
	),
	A = dict:to_list(Result),
	B = lists:keysort(2,A),
	Top_hash = topHashtag(20,reverse(B,[]), []),
	storing:store_map(Bucket, Top_hash).
	% io:format("~p~n",[X]),

topHashtag(0, _List, TopHash) -> TopHash;
topHashtag(Number, [H|T], TopHash) -> topHashtag(Number-1, T , TopHash++[H] ).

reverse([],List_2) -> List_2;
reverse([H|T], List_2) -> reverse(T, [H]++List_2).

% this map function calls values from the bucket 
mapHash(Object,_,_) ->
	{_, X} = binary_to_term(riak_object:get_value(Object)),
	[dict:from_list([{X,1}])].

%the reduce function merges the values from Riak and count number of hashtags
reduceHash(Input, _) ->  %Once again we don't care about the static argument
		[lists:foldl(
			fun(Tag, Acc) ->
				dict:merge(
					fun(_, Amount1, Amount2) ->
						Amount1 + Amount2
					end,
					Tag,
					Acc
				)
			end,
			dict:new(),
			Input
		)].      

% this function return bucket and keys of the data in Riak which is streamed in 24 hours
%this is passed to be the Key in mapred function.
get_bucket_keys(Bucket) ->
			 Pid = get_link(),
			 {StartDate,EndDate_2} = start_date(),
			 Start = format_date(StartDate),
			 End = format_date(EndDate_2),
	{ok, {_, Keys, _, _}} = riakc_pb_socket:get_index_range(
													Pid,
													Bucket,
													{binary_index, "time"},
													list_to_binary(Start), 
													list_to_binary(End),
													[]
												  ),
	close_link(Pid),
	BucketKeys = [{Bucket, K} || K <- Keys],
	BucketKeys.

% this function transform time formet to [Year-Month-Minute, Hour:minute:second]
format_date({{Year,Month,Date},{Hour,Minute,Second}}) ->
	io_lib:format("~4.10.0B-~2.10.0B-~2.10.0B ~2.10.0B:~2.10.0B:~2.10.0B", [Year,Month,Date,Hour,Minute,Second]).


% return start and end value that the start value is 24 hours before current time and the end value is the current time
start_date() -> 

	{Date,_ }  = end_date(),
	EndDate_2 = {Date,{23,59,59}},
	StartDate = calendar:gregorian_seconds_to_datetime(calendar:datetime_to_gregorian_seconds(EndDate_2)- 24*60*60),
	{StartDate, EndDate_2}.


end_date() ->
	calendar:local_time().







