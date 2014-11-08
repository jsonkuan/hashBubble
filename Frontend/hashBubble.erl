-module(hashBubble).


%% Create Data
Tweet = #tweet{ 
			tweet_id= 1,
            text = "This is a tweet"}.


%% Remember to replace the ip and port parameters with those that match your cluster.
{ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8098).

%% Create Bucket
TweetBucket = <<"Tweets">>.



%% Store Data
TweetObj = riakc_obj:new(TweetBucket, 
                        list_to_binary(
                          integer_to_list(
                            Tweet#tweet.tweet_id)), 
                        Tweet).

riakc_pb_socket:put(Pid, TweetObj).

StoreTweet = fun(Tweet) ->
  TweetObj = riakc_obj:new(TweetBucket, 
                           list_to_binary(
                             integer_to_list(
                               Tweet#tweet.tweet_id)), 
                           Tweet),
  riakc_pb_socket:put(Pid, TweetObj)
end.

lists:foreach(TweetOrder, Tweets).


TweetObj = riakc_obj:new(TweetBucket, 
                                list_to_binary(
                                  integer_to_list(
                                   Tweet#tweet.tweet_id)), 
                                Tweet).

riakc_pb_socket:put(Pid, OrderSummaryObj).










{ok, FetchedCustomer} = riakc_pb_socket:get(Pid, 
                                            CustomerBucket, 
                                            <<"1">>).
{ok, FetchedSummary} = riakc_pb_socket:get(Pid, 
                                           OrderSummariesBucket, 
                                           <<"1">>).
rp({binary_to_term(riakc_obj:get_value(FetchedCustomer)),
    binary_to_term(riakc_obj:get_value(FetchedSummary))}).


{#customer{customer_id = 1,name = "John Smith",
           address = "123 Main Street",city = "Columbus",
           state = "Ohio",zip = "43210",phone = "+1-614-555-5555",
           created_date = {{2013,10,1},{14,30,26}}},
 #order_summary{customer_id = 1,
                summaries = [#order_summary_entry{order_id = 1,
                                                  total = 415.98,
                                                  order_date = {{2013,10,1},{14,42,26}}},
                             #order_summary_entry{order_id = 2,total = 359.99,
                                                  order_date = {{2013,10,15},{16,43,16}}},
                             #order_summary_entry{order_id = 3,total = 74.98,
                                                  order_date = {{2013,11,3},{17,45,28}}}]}}    

FormatDate = fun(DateTime) ->
  {{Year, Month, Day}, {Hour, Min, Sec}} = DateTime,
  lists:concat([Year,Month,Day,Hour,Min,Sec])
end.

AddIndicesToOrder = fun(OrderKey) ->
  {ok, Order} = riakc_pb_socket:get(Pid, OrderBucket, 
                                    list_to_binary(integer_to_list(OrderKey))),

  OrderData = binary_to_term(riakc_obj:get_value(Order)),
  OrderMetadata = riakc_obj:get_update_metadata(Order),

  MD1 = riakc_obj:set_secondary_index(OrderMetadata,
                                      [{{binary_index, "order_date"},
                                        [FormatDate(OrderData#order.order_date)]}]),

  MD2 = riakc_obj:set_secondary_index(MD1,
                                      [{{integer_index, "salesperson_id"},
                                        [OrderData#order.salesperson_id]}]),

  Order2 = riakc_obj:update_metadata(Order,MD2),
  riakc_pb_socket:put(Pid,Order2)
end.

lists:foreach(AddIndicesToOrder, [1,2,3]).







riakc_pb_socket:get_index_eq(Pid, OrderBucket, {integer_index, "salesperson_id"}, 9000).































