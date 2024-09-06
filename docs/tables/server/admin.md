The 'Admin' sub-table (server.Admin) contains admin-related functions and variables.
The below functions can be accessed as members of server.Admin (For example: server.Admin.GetLevel(p))

## DoHideChatCmd (Player (Object), Message (String), Data (Optional Player Data Table))
Checks whether or not to hide commands ran from the chat for the specific player.


## GetTrueRank (Player (Object), GroupId (Int))
Deprecated
Runs GetRankInGroup from the target player's client and returns the result. This is intended to be a less secure way to avoid group rank caching, however due to security concerns should really not be used. 


## GetPlayerGroup (Player (Object), GroupName or GroupId (String or Int))
Checks groups the player is in against the GroupName/GroupId provided and returns the group if found.

Returns: Group


## IsMuted (Player (Object))
Checks if the given player is muted.

Returns true if muted


## DoCheck (Player (Object, String, Int), Check (String, Int, Table))
Checks the given player/string/int (Player) against the given string/int/table (Check) and will return true if they match. This function is responsible for checking if a given player/input matches something else. For example, DoCheck(Player, "Group:181") would return true if Player is in the group with ID 181.

Returns: true if matched, false or nil if not

## UpdateCachedLevel (Player (Object))
Updates the cached version of the player's admin level. Admin levels are cached for a set period of time to lower any performance impacts that may arise from constantly checking if a player is an admin.

Returns: AdminLevel


## LevelToList (Level (Int))
Takes a given level value and returns the list the level belongs to. This may become inaccurate if there are multiple lists/admin ranks that share the same level. If there are multiple ranks with the same level, built in/default ranks (HeadAdmins, Admins, Moderators, Creators) will be preferred over custom ranks.

Returns: list.Users, listName, list


## LevelToListName (Level (Int))
Similar to LevelToList however only returns the name of the found rank. 

Returns: RankName


## GetLevel (Player (Object))
Returns the admin level for the given player. This will match the level of the highest admin rank the player belongs to.
The default level values are:
Place Owner: 1000
Creators: 900
HeadAdmins: 300
Admins: 200
Moderators: 100
Players: 0

Returns: AdminLevel


## GetUpdatedLevel (Player (Object))
Gets the updated admin level for the provided player. This called automatically when the cached version of the player's admin level expires and should not be used too often for performance reasons.

Returns: AdminLevel

## CheckAdmin (Player (Object))
Returns true if the player is an admin (level > 0), false if not.

Returns: boolean


## SetLevel (Player (Object), NewLevel (Int))
Sets the target player's level to the new level indicated. Cannot set level of any user at level 1000 or higher (place owner)
This will not change the player's rank, but will rather set a "level override" via Admin.SpecialLevels which takes priority over rank tables.


## IsTempAdmin (Player (Object))
Returns true if the player is a temporary administrator.


## RemoveAdmin (Player (Object), isTemp (Optional Bool))
Removes the target player as an admin. If isTemp is true, it will remove them from the TempAdmins table. 


## AddAdmin (Player (Object), Level (String/Int), isTemp(Bool))
Makes the target player an admin, removing them from the admin table they are currently in (if any.) If isTemp is true, will make them a temporary admin. If Level is a string it will be converted to it's level equivalent if possible. 


## CheckDonor (Player (Object))
Checks if the player is a donor.

Returns: true if donor


## CheckBan (Player (Object))
Checks if the given player is banned.

Returns: true if banned


## AddBan (Player (Object), Reason (String), doSave (Bool), moderator (Object))
Bans Player with the given Reason and will save if doSave is true.


## DoBanCheck (Player (String, Int), Check (String, Int, Table))
Similar to Admin.DoCheck but specifically for bans. 

Returns: true if matched, false if not


## RemoveBan (Player (String, Int), doSave (Bool))
Unbans the given player name/id/etc and will save if doSave is true.


## RunCommand (Command (String), ArgsTuple (Tuple))
Runs the given command with the given arguments as the server.


## RunCommandAsPlayer (Command (String), Player (Object), ArgsTuple (Tuple))
Runs the given command as the given player with the given arguments. Overrides player's level.


## RunCommandAsNonAdmin (Command (String), Player (Object), ArgsTuple (Tuple))
Runs the given command as the given player with the given arguments. Treats the player as a non-admin. Overrides command level.


## CacheCommands ()
Updates the command cache. Commands are cached to avoid performance impacts caused by constantly iterating through and checking the entirety of the commands table whenever a player chats or runs a command. If a command is added after this is called, it might not appear in-game until this function is called to forcibly re-cache all commands. 


## GetCommand (Command (String))
Based on the command provided, will return the command's Index, DataTable, and the command string that was matched from the given string. 

Returns: String, Table, String


## FindCommands (Command (String))
Returns a list of commands matching 'Command'


## SetPermission (Command (String), NewLevel (String, Int))
Sets the AdminLevel of all commands matching 'Command' to 'NewLevel'


## FormatCommand (Command (Table))
Converts data about the given command into a string that can be used in :cmds, the console, etc.


## CheckTable (Check1 (Player, String, Int), Table)
Check 'Check1' against all entries in 'Table'

Returns: true if match is found


## CheckAliasBlacklist (Alias (String)
Checks if a given alias is blacklisted. This is to prevent the accidental override of important commands, such as those used to alter aliases. 

Returns: true if blacklisted


## GetArgs (Message (String), NumArgs (Int), AdditionalArgs (Tuple))
Returns a table containing all arguments extracted from 'Message'

Returns: Args table


## AliasFormat (Aliases (Table), Message (String))
Alters the given message based on aliases found in the provided alias table 'Aliases.'

Returns: Updated message string


## IsComLevel (TestLevel (Int, String, Table), ComLevel (Int, String, Table))
Checks if 'TestLevel' matches 'ComLevel'

Returns: true or index,value if found.

## StringToComLevel (Rank (String))
Converts 'Rank' to it's level if found.

Returns: level


## CheckComLevel (PlayerLevel (Int), ComLevel (Int, String))
Checks if the player's level matches 'ComLevel'

Returns: true if matched


## IsBlacklisted (Player (Object))
Checks if 'Player' is blacklisted.

Returns: true if blacklisted


## CheckPermission (PlayerData (Table), Command (Table))
Checks if 'PlayerData' has permission to use 'Command.' This is responsible for command permission checks when a player runs a command.

Returns: true if allowed


## SearchCommands (Player (Object), Search (String))
Searches commands matching 'Search' that the player is allowed to run. This is mainly used by the console.

Returns: Table containing matched commands
