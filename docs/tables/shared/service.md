In Adonis, the "service" variable is a metatable provided by the Service core module containing many essential functions and variables used by both the server and client. The service table for the client is nearly identical to the service table for the server with the exception of a few variables added by either the client or server during loading. 

If an index is requested from the service table (eg. service.Players) it will first check if it contains the requested index. If it does not contain the requested index, the it will query game:GetService(index) and return the result instead. This offers a slightly quicker alternative to typing game:GetService() when getting a Roblox service. 


# Special Functions & Variables
The following is a list of functions and variables that can be found in the service metatable.

Note that ... implies user defined arguments that are not necessarily required to use a function or used directly by the function. This is almost always arguments to be passed to a user defined function. 

Variables starting with * indicate an optional variable.

# service.EventService
The EventService table/object contains functions related to event and task handling. All members of the EventService object can be accessed as members of the service metatable. 

## TrackTask(Name, Function, ...)
Creates a new Adonis-tracked "task" thread. If Name starts with "Thread:" Adonis will create the task as a coroutine, otherwise TrackTask will yield until function completion. TrackTask will pass ... as arguments to the specified task function and will return the result.

```Lua
--// Add existing players in case some are already in the server
for _, player in service.Players:GetPlayers() do
	service.TrackTask("Thread: LoadPlayer "..tostring(player.Name), server.Core.LoadExistingPlayer, player);
end
```
## EventTask(Name, Function)
Creates a special function that can be called by an event to spawn a new task each time the event fires.

```Lua
service.Players.PlayerAdded:Connect(service.EventTask("PlayerAdded", server.Process.PlayerAdded))
```

## GetTasks()
Returns a table containing currently tracked tasks.

## Events
Acts as a proxy to service.GetEvent(EventName) which will return a special event object for EventName.

The event object contains methods like :Connect(function), :Fire(...), and :Wait()

### :Connect(function)
Will attach a user specified function to the event. When :Fire(...) is called, the arguments passed to :Fire(...) will be passed to the attached function.

### :ConnectOnce(function)
Same as :Connect() except disconnects after firing once.

### :Fire(...)
Runs all functions attached to the event and passes ... to them.

### :Wait()
Waits for the event to fire once. Will return whatever arguments :Fire(...) sent. Yields.

### Adonis Events
Adonis has a number of custom events that can be used by plugins or Adonis itself. 

Events List:
```Lua
--// SERVER
CommandRan(Player, Data) 
--[[
  Data is a table containing the following: 
  {
    Message = msg,     --// The full message the player chatted; Previously the "Message" param
    Matched = matched, --// The :kick in :kick me (the MatchedString param previously (the command basically))
    Args = args,       --// The command arguments (the me in :kick me)
    Command = command, --// The command's data table (contains the function and all info about the command being ran)
    Index = index,     --// The command's index in the command table
    Success = success, --// Did the command run? Did it fail? Did it return anything for some reason? This will tell us..
    Error = error,     --// If it failed, what was the error?
    Options = opts,    --// The options ("opts" table) passed to Process.Command; Contains stuff like isSystem and CrossServer flags
    PlayerData = pDat  --// Data about the player, such as Level, isAgent, isDonor, and the Player object itself
  }
--]]

CustomChat(Player, Message, Mode)
PlayerChatted(Player, Message)
PlayerAdded(Player)
PlayerRemoving(Player)
CharacterAdded(Player)
NetworkAdded(NetworkClient)
NetworkRemoved(NetworkClient)
LogAdded(LogType, Log, LogTable)

--// Currently Disabled
ObjectAdded(Object) 
ObjectRemoved(Object)
Output(Message, Type)
ErrorMessage(Message, Trace, Script)

--// CLIENT
CharacterAdded()
CharacterRemoving()
```

Example:
```Lua
--// Connect to the LogAdded event
service.Events.LogAdded:Connect(function(LogType, Log, LogTable)
	print("New " .. LogType .." log: ".. Log.Text .. " - " .. Log.Desc)
end)

--// Wait for a log to be added
local LogType, Log, LogTable = service.Events.LogAdded:Wait()

--// Fire the LogAdded event
service.Events.LogAdded:Fire("Command", {Text = "Player1: :ff me", Desc = "Player1 ran a command"}, server.Logs.Commands)

--// Also here's the list of potential LogTypes:
--// Chats in the first entry of this table corresponds to server.Logs.Chats, it's log type is "Chat"
local indToName = {
	Chats = "Chat";
	Joins = "Join";
	Script = "Script";
	Replications = "Replication";
	NetworkOwners = "NetworkOwner";
	RemoteFires = "RemoteFire";
	Commands = "Command";
	Exploit = "Exploit";
	Errors = "Error";
}
```

## CheckEvents(*Waiting)
Currently disabled.
Responsible for determining which events are done and should be cleaned up.

## ForEach(Table, Function)
Iterates through a given table, calling Function(Table, Index, Value) for each item in the table.

## WrapEventArgs(Table)
Responsible for wrapping arguments passed to event functions.

## UnWrapEventArgs(Table)
Unwraps objects in the given table. 

## GetEvent(EventName)
Returns a special object for Adonis events. Refer to the Events section. Identical to service.Events.EventName

## HookEvent(EventName, Function)
Attaches a function to the specified EventName. Identical to calling service.Events.EventName:Connect()

## FireEvent(EventName, ...)
Identical to service.Events.EventName:Fire(...)

## RemoveEvents(EventName)
Removes all event hooks associated with EventName.



# service.ThreadService
The ThreadService object can be accessed via service.ThreadService. Unlike WrapService, EventService, and HelperService the functions and variables in ThreadService cannot be accessed as members of the service metatable. Instead, they can be accessed using the ThreadService object. 
## Tasks
Table containing running tasks.

## Threads
Table containing running threads.

## CheckTasks()
Responsible for removing "dead" tasks.

## NewTask(Name, Function, *Timeout)
Creates a new task and returns newTask.Resume,newTask

Tasks have a number of functions. At it's core a task is a proxy object to a coroutine.

Every task contains the following:
```
PID - a unique identifier for the task
Name - task name
Index - index in the Tasks table
Created - time the task was created
Changed - a table containing task related event functions, such as :connect(function), :fire(...); Fires when task changes
Timeout - how long the task can run for, default inf (0)
Running - bool that's true when the task is running
Function - the task's function
R_Status - current task status
Finished - table containing tasks related event functions, such as :connect(function), fire(...), and :wait(); Fires when task finishes
Function - task function handler
Remove - removes the task
Thread - task thread handler
Resume - resumes the task
Status - returns task status
Pause - suspends the task
Stop - stops and removes the task
Kill - ends and removes the task
End - ends the task
```

## RunTask(Name, Function, ...)
Creates a new task with Name and Function, then runs the new task with arguments ...

## TimeoutRunTask(Name, Function, Timeout, ...)
Same as RunTask but with a timeout.

## WaitTask(Name, Function, ...)
Same as RunTask, but yields until task.Finished fires.

## NewEventTask(Name, Function, *Timeout)
Returns a function that can be used to create a new task each time an event fires.

## Stop, Wait, Pause, Yield,
coroutine.yield

## Status
corotuine.status

## Running, Get
coroutine.running

## Create
coroutine.create

## Start
coroutine.resume

## Wrap
corotouine.wrap

## New(Function)
Creates a new coroutine and adds it to threads

## End(Thread)
Attempted to end the supplied thread and remove it

## Wrap(Function, ...)
Creates a new coroutine, adds it to threads, and then calls Resume with ...

## Resume(Thread, ...)
Calls resume on the specified thread with ...

## Remove(thread)
Removes the specified thread.

## StopAll()
Stops all threads.
