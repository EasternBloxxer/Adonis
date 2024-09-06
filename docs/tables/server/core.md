This is the "Core" table. It houses functions and variables that are essential to the core functionality of Adonis. If something happened to this table or its contents the entire system would become unusable. Functions within this table handle things like initial setup of the RemoteEvent/RemoteFunction, client loading, etc.

## (Table) Variables:
Contains Core-related variables, such as the TimeBans table.


## Datastore-related variables
```Lua
--// Datastore update/queue timers/delays
DS_SetDataQueueDelay = 0.5;
DS_UpdateQueueDelay = 1;
DS_AllPlayerDataSaveInterval = 30;
DS_AllPlayerDataSaveQueueDelay = 0.5;

--// Used to change/"reset" specific datastore keys
DS_RESET_SALTS = {
	SavedSettings = "32K5j4";
	SavedTables = 	"32K5j4";
};
```

## DisconnectEvent ()
Disconnects and destroys all events related to security and the RemoteEvent


## MakeEvent ()
Creates the RemoteEvent and RemoteFunction used for server-client communication.


## UpdateConnections ()
Updates the list of NetworkServer - Player connections


## UpdateConnection (Player: userdata)
Same as UpdateConnections but for a specific player.


## GetNetworkClient (Player: userdata)
Returns the NetworkClient belonging to 'Player'


## SetupEvent (Player: userdata)
Creates a new player-specific RemoteEvent to be used for client-server communication.
Not currently used. 


## PrepareClient ()
Creates a client loader in ReplicatedFirst. Not currently used in favor of handling the client loading process via HookClient(Player)


## HookClient (Player: userdata)
When a player joins this function is called and handles the process of preparing the client and parenting it to the player.


## LoadClientLoader (Player: userdata)
Handles the loading of existing players at server startup.
Calls Process.PlayerAdded(Player)


## MakeClient ()
Places the client into StarterPlayerScripts.
Not currently used in favor of HookClient


## ExecutePermission (SourceScriptObject: userdata, Code: string, isLocal: bool)
Determines if the given script object 'SourceScriptObject' is allowed to run. 
If 'Code' is provided it will be used as a pseudo-password.
If 'isLocal' is true it will be treated as a LocalScript.

Returns: if allowed, table containing Source, noCache, runLimit, number of Executions


## GetScript (ScriptObject: userdata, Code: string)
Returns the registered script object matching 'ScriptObject' or 'Code'


## UnRegisterScript (ScriptObject: userdata)
Unregisters 'ScriptObject' for execution.


## RegisterScript (Data: table)
Registers Data.Script as being allowed to execute along with it's related information.


## GetLoadstring ()
Returns a new loadstring module. 


## Bytecode (LuaCode: string)
Converts 'LuaCode' into bytecode and returns the result. This is used before sending any code to run to the client.


## NewScript (Class: string, Source: string, AllowCodes: bool, NoCache: bool, RunLimit: int)
Creates, registers, and returns a new script of class  'Class' 


## SavePlayer (Player: userdata, Data: table)
Updates Player's data (in Core.PlayerData) do 'Data'


## DefaultPlayerData (Player: userdata)
Returns the default player data for 'Player'


## GetPlayer (Player: userdata)
Returns the PlayerData for 'Player'
Also updates the PlayerData cache and will retrieve data from the datastore if not already cached. 


## ClearPlayer (Player: userdata)
Clears data related to a player, resetting it to the default values. 


## SavePlayerData (Player: userdata, CustomData: (opt)table)
Save's data for 'Player' to the datastore.


## SaveAllPlayerData ()
Saves all player data.


## GetDataStore ()
Returns the DataStore.


## DataStoreEncode (Key: string)
Returns the salted, encrypted, Base64 encoded version of a given key to be used in the datastore.


## SaveData (...)
Calls Core.SetData(...)


## RemoveData (Key: string)
Removes 'Key' and related data from the datastore.


## SetData (Key: string, Value)
Sets 'Key' to 'Value' in the datastore cache & datastore (when the datastore is updated)


## UpdateData (Key: string, Function: function)
Calls UpdateAsync for the given 'Key' with 'Function'


## GetData (Key: string)
Returns data related to 'Key' from the DataCache/datastore


## IndexPathToTable (string,TableAncestry: table)
Attempts to find the given table based on the path provided.
Returns: foundTable, foundTableIndex


## DoSave(Data: table)
Saves settings or tables to the datastore based on information provided in 'Data'


## LoadData (Key: string, Data: table)
Loads saved settings, tables, etc.


## StartAPI ()
Handles the creation and monitoring of _G.Adonis


