Adonis expects any modules it's loading to return a function containing the module's code to run. Adonis will require the module, set the returned function's environment to a custom one containing all important variables, and will execute the function.

Plugins are loaded without yielding and will be loaded only after all of the core modules are loaded. 

## User-defined modules (plugins)
Developers can create custom modules for Adonis to load without needing to alter Adonis's MainModule. 
Simply add modules to `Adonis_Loader` > `Config` > `Plugins`

👉 Server modules should have names starting with "Server:" or "Server-"

👉 Client modules should have names starting with "Client:" or "Client-"

Example: "Server: CustomChatHandler"

The module's name will be used by Adonis to determine if the module is a client plugin or a server plugin. The modules will be loaded after the "Core" modules finish loading.

Plugins have the same level of access as any of Adonis's "Core" modules. Because of this, plugin modules are free to add, remove, and change whatever they like. It is advised, however, that you avoid removing any existing tables, functions, or objects and instead replace them with "dummy" alternatives to avoid causing serious errors.

## Example server plugin
The following is an example server plugin

```Lua
return function(Vargs)
	local server = Vargs.Server
	local service = Vargs.Service

        --// Add a new command to the Commands table at index "ExampleCommand1"
	server.Commands.ExampleCommand1 = {						--// The index & table of the command
		Prefix = server.Settings.Prefix;					--// The prefix the command will use, this is the ':' in ':ff me'
		Commands = {"examplecommand1", "examplealias1", "examplealias2"};	--// A table containing the command strings (the things you chat in-game to run the command, the 'ff' in ':ff me')
		Args = {"arg1", "arg2", "etc"};						--// Command arguments, these will be available in order as args[1], args[2], args[3], etc; This is the 'me' in ':ff me'
		Description = "Example command";					--// The description of the command
		AdminLevel = 100; -- Moderators						--// The command's minimum admin level; This can also be a table containing specific levels rather than a minimum level: {124, 152, "HeadAdmins", etc};
		--// Alternative option: AdminLevel = "Moderators";
		Filter = true;								--// Should user supplied text passed to this command be filtered automatically? Use this if you plan to display a user-defined message to other players
		Fun = false;								--// Is this command considered as fun?
		Hidden = true;								--// Should this command be hidden from the command list?
		Disabled = true;							--// Should this command be unusable?
		NoStudio = false;							--// Should this command be blocked from being executed in a Studio environment?
		NonChattable = false;							--// Should this command be blocked from being executed via chat?
		CrossServerDenied = false;						--// If true, this command will not be usable via :crossserver
		Function = function(plr: Player, args: {string}, data: {})		--// The command's function; This is the actual code of the command which runs when you run the command
			--// "plr" is the player running the command
			--// "args" is a table containing command arguments supplied by the user
			--// "data" is a table containing information related to the command and the player running it, such as data.PlayerData.Level (the player's admin level)
			print("This is 'arg1':", args[1])
			print("This is 'arg2':", args[2])
			print("This is 'etc'(arg 3):", args[3])
			error("this is an example error :o !")
		end
	}
end
```

In this example, we create a new command named "ExampleCommand1" which can be ran using ":examplecommand1" (assuming the command Prefix is set to ":" in loader settings).

In the same way we can add commands, we can use the same method to remove or alter commands. Instead of creating an entirely new command named ExampleCommand, the following would remove the command ":ff" from the script and make it so the :kick command still exists but does nothing. 

```Lua
return function(Vargs)
	local server = Vargs.Server
	local service = Vargs.Service

	--// Remove ForceField from the Commands table
	server.Commands.ForceField = nil

	--// Change the Kick command to do nothing:
	server.Commands.Kick.Function = function(plr: Player, args: {string})
		print(plr.Name .." tried to kick someone")
	end
end
```
If you wish to do this, refer to the appropriate commands module located under `MainModule` > `Server` > `Commands` to view the internal index of a command. Alternatively, you may run ``:cmdinfo <command>`` in-game which will also display the command's index.
