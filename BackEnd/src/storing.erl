-module(storing).
- export([store/2]).
store(R,[{Hashtag,Hash}, {URL,Media_Url}, {Lang,Language}, {Locate,Location}]) ->
Object =[{Hashtag,Hash}, {URL,Media_Url}, {Lang,Language}, {Locate,Location}],
Time = erlang:term_to_binary(calendar:local_time()),
erlang:display(Time),
 Obj = riakc_obj:new(<<"hashtags_store">>,
                    Media_Url,
                   erlang:term_to_binary({Time, Hash}),
                    <<"text/plain">>
                    ),
MD1 = riakc_obj:get_update_metadata(Obj),
MD2 = riakc_obj:set_secondary_index(
    MD1,
    [{{binary_index, "hashtags"}, [Hash]},
     {{binary_index, "lang"}, [Language]},
     {{binary_index, "location"}, [Location]}]),
Obj2 = riakc_obj:update_metadata(Obj, MD2),
    riakc_pb_socket:put(R, Obj2), 
	io:format("~p~n", [Object]).