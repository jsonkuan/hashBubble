-module(storing).
- export([store/1]).

-record(hostport, {host, port}).

keyfind(Key, L) ->
  {Key, V} = lists:keyfind(Key, 1, L),
  V.

%% @doc Get Twitter account keys from a configuration file.
get_riak_hostport(Name) ->
  {ok, Nodes} = application:get_env(twitterminer, riak_nodes),
  {Name, Keys} = lists:keyfind(Name, 1, Nodes),
  #hostport{host=keyfind(host, Keys),
            port=keyfind(port, Keys)}.


store([{_Hashtag,Hash}, {_URL,Media_Url}, {_Lang,Language}, {_Locate,Location}]) ->
 RHP = get_riak_hostport(riak1),
 {ok, R} = riakc_pb_socket:start(RHP#hostport.host, RHP#hostport.port),
%Time = erlang:term_to_binary(calendar:local_time()),
T = calendar:local_time(),
Time = list_to_binary(map_reduce:format_date(T)),
 Obj = riakc_obj:new(<<"image_data">>,
                    Media_Url,
                   erlang:term_to_binary({Time, Hash}),
                    <<"text/plain">>
                    ),
MD1 = riakc_obj:get_update_metadata(Obj),
MD2 = riakc_obj:set_secondary_index(
    MD1,
    [{{binary_index, "hashtags"}, [Hash]},
     {{binary_index, "lang"}, [Language]},
     {{binary_index, "location"}, [Location]},
     {{binary_index, "time"}, [Time]}]),
Obj2 = riakc_obj:update_metadata(Obj, MD2),
    riakc_pb_socket:put(R, Obj2),
    Object =[{Hash}, {Media_Url}],
    io:format("~p~n", [Object]), io:format("~p~n", [Time]), 
    riakc_pb_socket:stop(R).
