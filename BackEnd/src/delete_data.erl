- module(delete_data).
-export([delete_keys_bucket/1, check_keys/1]).

% this function connect to the riak and return pid 
get_link() ->
 case riakc_pb_socket:start_link("127.0.0.1", 10017) of
	{ok, Pid} -> Pid end.

%this function delete everything in the bucket, connectint to the Riak, then delete bucket
delete_keys_bucket(Bucket) ->
	
	 Pid    = get_link(),

	{ok, Result} = riakc_pb_socket:list_keys(Pid, Bucket),
		complete_delete(Pid,Bucket,Result).
	 	%riakc_pb_socket:stop(Pid).

	 

% this function checks if the bucket still exists,  and return keys in the bucket or empty list
% it is called from complete_delete function to check if there is any keys inside the bucket.
check_keys(Bucket) ->

	Pid    = get_link(),

	case  riakc_pb_socket:list_keys(Pid, Bucket) of 
		{ok, Result} -> Result;
		_ -> key_deleted end.

%This function calls check_keys/1 to check if the bucket still exist, 
%it keep deleting keys in the bucket in case the keys still exist in the bucket.
complete_delete(Pid, Bucket,Result) ->
case check_keys(Bucket) of
	[] -> key_deleted;
	_ -> delete_keys(Pid,Bucket,Result), complete_delete(Pid,Bucket,Result) end.

	%riakc_pb_socket:stop(Pid).

%this function use list comprehension to delete keys in the bucket, but sometime it doesn't delete all keys in the bucket,
% that's why it is called from complete_delete/3 to check if all keys are not deleted then continue to delete keys again.
delete_keys(Pid, Bucket,Result) -> [riakc_pb_socket:delete(Pid, Bucket, X) || X <- Result].
