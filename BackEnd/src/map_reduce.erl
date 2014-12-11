-module(map_reduce).
-export([mapHash/3, reduceHash/2, mapred/2, get_link/0,
		close_link/1, get_bucket_keys/1, start_date/0,
		end_date/0, format_date/1]).

get_link() ->
 case riakc_pb_socket:start_link("127.0.0.1", 10017) of
	{ok, Pid} -> Pid end.

close_link(Pid) -> riakc_pb_socket:stop(Pid).


mapred(Keys,Pid) ->
%	Pid = get_link(),
	{ok, [{1, [Result]}]} = riakc_pb_socket:mapred(
		Pid,
		Keys,
		[
			{map, {modfun, ?MODULE, mapHash}, none, false},
			{reduce, {modfun, ?MODULE, reduceHash}, none, true}
		]
	),
	dict:to_list(Result), io:format("~p~n", [Result] ).


% this map function should return everything in the bucket in the list format
mapHash(Object,_,_) ->
	{_, X} = binary_to_term(riak_object:get_value(Object)),
	[dict:from_list([{X,1}])].


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

format_date({{Year,Month,Date},{Hour,Minute,Second}}) ->
	io_lib:format("~4.10.0B-~2.10.0B-~2.10.0B ~2.10.0B:~2.10.0B:~2.10.0B", [Year,Month,Date,Hour,Minute,Second]).



start_date() -> 

	{Date,_ }  = end_date(),
	EndDate_2 = {Date,{23,59,59}},
	StartDate = calendar:gregorian_seconds_to_datetime(calendar:datetime_to_gregorian_seconds(EndDate_2)- 24*60*60),
	{StartDate, EndDate_2}.


end_date() ->
	calendar:local_time().







