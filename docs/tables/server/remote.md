Remote handles all remote server-client communication.


## Table: Returnables
This is a table containing functions that can be called via client.Remote.Get and will return something to the calling client.

## Table: UnEncrypted
This is a table containing functions that can be used by clients without needing encryption/various security checks.
This contains functions mostly related to initial loading before keys are exchanged, or communication with non-adonis-client localscripts, as well as very basic rapid fire events like chat handling.

## Table: Commands
These are functions which can be ran by clients via client.Remote.Send
They cannot return data and are purely "fire and forget." 


## NewSession (string: SessionType)
Creates and returns a new session handler that can be used to facilitate temporary communication between the server and multiple users with special commands/event defined. 

Clients can listen for session events as needed via service.Events.SessionData

Here's an example of NewSession in action in the form of a, at the time of writing this, work in process private chat command & GUI:

Server code:
```Lua
local newSession = Remote.NewSession("PrivateChat");
local eventConnection = newSession.SessionEvent.Event:Connect(function(p, ...)
	local args = {...};
	local cmd = args[1];

	if cmd == "SendMessage" then
		if newSession.Users[p] then
			table.insert(newSession.Users[p].Messages, args[2]);
		end

		newSession.SendToUsers("PlayerSentMessage", p, args[2]);
	elseif cmd == "LeaveSession" then
		newSession.Users[p] = nil;
		newSession.SendToUsers("PlayerLeftSession", p);
	elseif cmd == "EndSession" and p == plr then
		newSession.End();
	end
end)

for i,v in ipairs(service.GetPlayers(plr, args[1])) do
	newSession.AddUser(v, {
		Messages = {};
	});

	Remote.MakeGui(v, "PrivateChat", {
		Owner = plr;
		SessionKey = newSession.SessionKey;
	})

	-- testing stuff below
	wait(2)
	newSession.SendToUsers("PlayerSentMessage", plr, "this is a test message");
end
```

Client Code:
```Lua
local sessionEvent = service.Events.SessionData:Connect(function(sessionKey, cmd, ...)
    local vargs = {...};
    print("we got session thing!");
    if SessionKey == sessionKey then
      print("SESSION KEY VALID")
      if cmd == "PlayerSentChat" then
        local p = vargs[1];
        local message = vargs[2];

        print("got chat: ".. p.Name, "Message: ".. message)
      end
   end
end)
```

## GetSession (string: SessionKey)
Gets the session belonging to 'SessionKey'


## Fire (userdata: Player, tuple: Arguments)
(Raw fire)
Sends data to the client belonging to 'Player' with any arguments passed.
Does not handle command encryption before sending.
This should not be used for normal server-client communication.


## GetFire (userdata: Player, tuple: Arguments)
(Raw fire)
Functionally similar to Remote.Fire except it uses the RemoteFunction and is thus able to return data from the client.
This should not be used for normal server-client communication. 


## Send (userdata: Player, string: Command, tuple: Arguments)
Encrypts 'Command' and sends it with 'Arguments' to client of 'Player'
This should be used for normal communication.


## Get (userdata: Player, string: Command, tuple: Arguments)
Encrypts 'Command' and sends it with 'Arguments' to client of 'Player'
Functionally similar to Remote.Send except it uses the RemoteFunction and is thus able to return data from the client.
This should be used for normal communication. 


## CheckClient (userdata: Player)
Checks if the 'Player's client is hooked and ready for communication. 


## Ping (userdata: Player)
Runs Remote.Get(Player, "Ping") and returns the result. 


## MakeGui (userdata: Player, string: GuiName, table: Data, table: ThemeData)
Tells 'Player's client to create the specified GUI with the specified data provided.


## MakeGuiGet (userdata: Player, string: GuiName, table: Data, table: ThemeData)
Identical to Remote.MakeGui except this will yield and return any data returned by the GUI created.
This is used in conjunction with UI elements like the YesNoPrompt.


## GetGui (userdata: Player, string: GuiName, table: Data, table: ThemeData)
Alternative method of calling Remote.MakeGuiGet


## RemoveGui (userdata: Player, string: GuiName)
Removes the specified UI element belonging to 'GuiName' from 'Player'


## NewParticle (userdata: Player, userdata: Parent, string: Type, table: Properties)
Creates a new particle of 'Type' in 'Parent' locally for 'Player'


## RemoveParticle (userdata: Player, userdata: Parent, string: Name)
Removes particle from 'Parent' for 'Player'


## NewLocal (userdata: Player, string: ClassName, table: Properties, userdata: Parent)
Creates a new particle locally for 'Player' of 'ClassName' with 'Properties' in 'Parent'


## MakeLocal (userdata: Player, userdata: Object, userdata: Parent, bool: Clone)
Makes 'Object' local to 'Player' 


## MoveLocal (Player, Object, Parent, newParent)
Moves local object to new parent for 'Player'


## RemoveLocal (Player, Object, Parent, string: Match)
Removes local from 'Player' in 'Parent' matching 'Object' or 'Match'

## SetLighting (Player, string: Property, Value)
Sets game.Lighting[Property] to 'Value' for 'Player'


## FireEvent (Player, tuple: Arguments)
Triggers client event on 'Player' with 'Arguments'


## NewPlayerEvent (Player, string: Type, function: Function)
Creates a new player event and can be triggered by the client. 


## PlayAudio (Player, int: AudioId, int: Volume, int: Pitch, bool: Looped)
Plays audio locally on 'Player'


## StopAudio (Player, int: AudioId)
Stops current playing local audio on 'Player'


## StopAllAudio (userdata: Player)
Stops all playing audio (locally created by Adonis)



## LoadCode (Player, string: LuaCode, bool: GetResult)
Runs 'LuaCode' on the player's client and gets the result if 'GetResult' is true.



## Encrypt (string: String, string: Key, table: Cache)
Handles encryption.



## Decrypt (string: String, string: Key, table: Cache)
Handles decryption.



