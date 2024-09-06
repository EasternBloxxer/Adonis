This table contains functions that handle various events, such as calls to the RemoteEvent or player messages/commands.

## Variables
```Lua
MsgStringLimit = 500; --// Max message string length to prevent long length chat spam server crashing (chat & command bar); Anything over will be truncated;
MaxChatCharacterLimit = 250; --// Roblox chat character limit; The actual limit of the Roblox chat's textbox is 200 characters; I'm paranoid so I added 50 characters; Users should not be able to send a message larger than that;
RateLimits = { --// Rate limit values for various events that may occur to prevent spam/performance issues
	Remote = 0.01;
	Command = 0.1;
	Chat = 0.1;
	CustomChat = 0.1;
	RateLog = 10;
};
```

## Remote (userdata: Player, table: ClientData, string: Command, tuple: Arguments)
Handles client to server communication.
This is called whenever the RemoteEvent is triggered by the client.


## Command (userdata: Player, string: Message, table: Options, bool: noYield)
Processes player commands. 


## DataStoreUpdated (string: Key, table: Data)
Runs when the datastore updates and passes 'Key' and 'Data' to Core.LoadData


## CrossServerChat (table: Data)
Handles cross-server chat messages.


## CustomChat (userdata: Player, string: Message, string: Mode, bool CanCross)
Handles messages sent via Adonis's custom chat.


## Chat (userdata: Player, string: Message)
Handles player chats.


## WorkspaceChildAdded (userdata: Child)
Runs when a new child is added to Workspace. 
Previously, this was used as an alternative to player.CharacterAdded however is no longer in use. 


## LogService (Message, Trace, Script)
Runs whenever a new message is added by the LogService. Not currently used.


## PlayerAdded (userdata: Player)
Runs when a new player joins the game and handles the initial loading process, such as player removal (if banned) and client hooking.


## PlayerRemoving (userdata: Player)
Runs when a player is leaving.
Fires service.Events.PlayerRemoving(Player)


## NetworkAdded (userdata: NetworkClient)
Runs when a new NetworkClient object is added to NetworkServer
Fires service.Events.NetworkAdded(NetworkClient)


## NetworkRemoved (userdata: NetworkClient)
Runs when a NetworkClient is removed.
Fires service.Events.NetworkRemoved(NetworkClient)


## FinishLoading (userdata: Player)
Assuming the player isn't removed or leaves while loading (during PlayerAdded) this function will run when the player and client are fully finished loading and are ready for communication. This handles the "You're an admin!" messages as well as other things that happen when the player finishes loading, such as the enabling of various client-side anti-exploit handlers and misc features.
Fires service.Events.PlayerAdded(Player)

## CharacterAdded (userdata: Player)
Runs whenever a player's character loads.


## PlayerTeleported (userdata: Player, data)
Runs whenever a player teleports to the current server. Not currently used.



