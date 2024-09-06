This table is responsible for all logging in Adonis.


## Log Tables
```Lua
Chats = {}; --// Chat logs
Joins = {}; --// Join logs
Script = {}; --// Script-related logs
RemoteFires = {}; --// RemoteEvent logs
Commands = {}; --// Command logs
Exploit = {}; --// Exploit logs
Errors = {}; --// Error logs
TempUpdaters = {} --// Temporary functions used as list updaters
```

## TabToType (table: Table)
Returns a string describing what the provided table is logging. 

Possible returns: "Chat", "Join", "Script", "RemoteFire", "Command", "Exploit", "Error", "ServerDetails", "DateTime"


## AddLog (table, string: LogTable, table, string: Log)
Adds 'Log' to 'LogTable' and automatically adds a timestamp if one is not provided (unless 'Log' is a table and Log.NoTime is true)

Fires service.Events.LogAdded:Fire(TabToType(LogTable), Log, LogTable)


## SaveCommandLogs ()
Saves command logs to the datastore as "OldCommandLogs"

## Table: ListUpdaters
These are functions used by lists to update their contents when the user refreshes the list. 

Here's the list updater for ChatLogs as an example:

```Lua
ListUpdaters = {
	ChatLogs = function()
		return Logs.Chats
	end;
}
```


