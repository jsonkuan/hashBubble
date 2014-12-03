-module(my_behavior).
-export([behavior_info/1]).

%%init, are now expected callbacks
behavior_info(callbacks)-> [{init,1}, {handle_info}, {handle_cast,2}, {terminate,2}, {code_Change,3}, {handle_call,3}];
behavior_info(_)-> undefined.