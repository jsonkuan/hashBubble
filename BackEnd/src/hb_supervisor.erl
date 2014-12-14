%% @author Nicole Musco

%%using a supervisor to to keep the (child) server running, if stops the supervisor should restart server


-module(hb_supervisor).
-export([start/0, init/1]).
-behavior(supervisor).

start() -> supervisor:start_link({local, ?MODULE}, ?MODULE, []),
	application:ensure_all_started(hashbubble),
			schedule:start(), hb_server:start().
init([]) ->
RestartStrategy = one_for_one,
MaxTime = 60,
MaxRestart = 5,
Something = {RestartStrategy, MaxTime, MaxRestart},        
Restart = permanent,
ChildSpec = worker,
Shutdown = 5000,
Child = {hb_server, {hb_server, start, []}, Restart, Shutdown, ChildSpec, [hb_server]},

{ok, {Something, [Child]}}. 




