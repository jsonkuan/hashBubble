%% @author Nicole Musco

%%using a supervisor to to keep the (child) server running, if stops the supervisor should restart server
-module(twittersupervisor).
-export([start/0, init/1]).
-behavior(supervisor).

start() -> supervisor:start_link({local, ?MODULE}, ?MODULE, []),
			schedule:start().
init([]) ->
RestartStrategy = one_for_one,
MaxTime = 60,
MaxRestart = 5,
Something = {RestartStrategy, MaxTime, MaxRestart},        
Restart = permanent,
ChildSpec = worker,
Shutdown = 5000,
Child = {twitterserver, {twitterserver, start, []}, Restart, Shutdown, ChildSpec, [twitterserver]},

{ok, {Something, [Child]}}. 




