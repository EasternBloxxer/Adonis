This table contains all server-side anti-exploit related functions/variables. They can be accessed via server.Anti

## ClientTimeoutLimit
Default: 120
How long a player's client can 'go dark' before the player is kicked from the game. 

## RemovePlayer (Player (Object), Reason (Optional String))
Removes 'Player' for 'Reason'


## CheckAllClients ()
Checks if all clients are alive and responding. If client has not communicated for more than Anti.ClientTimeoutLimit the player the client belongs to will be removed from the server.


## UserSpoofCheck (Player (Object))
Attempts to detect username/userid spoofing.

Returns: true if spoofing detected

## Sanitize (Object, ClassList (Table))
Searches 'Object' for children matching 'ClassList' and attempts to remove them if found. An example use case would be removing all scripts from a given hat.


## isFake (Player (Object))
Attempts to determine if a player object is a real player. 

Returns: true if "fake"


## RemoveIfFake (Player (Object))
Removes 'Player' if isFake returns true


## FindFakePlayers ()
Attempts to find and remove "fake" players.


## GetClassName (Object)
Attempts to get the class name of the given 'Object' regardless of whether or not it's RobloxLocked.


## RLocked (Object)
Returns true if 'Object' is RobloxLocked


## ObjRLocked (Object)
Identical to RLocked.


## AssignName ()
Returns a random 6 digit number.


## Detected (Player (Object), Action (String), Info (String))
Actions:
Log - Only logs the event
Kick - Logs the event and kicks the player
Crash - Logs the event and attempts to crash the player in addition to kicking them.

This function is called whenever a player is detected by the anti-exploit system. The player and 'Info' are logged and the specified action is performed. 


## CheckNameID (Player (Object))
Another method to attempt to detect Name/UserId spoofing.
