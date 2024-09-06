This is the commands table. It contains all commands to be used by administrators in-game. It does not contain any additional functions or variables.

To add a command, simply do:
server.Commands.CommandIndexHere = CommandDataTableHere

For example:
```Lua
server.Commands.SomeNewCommand = {	--// The index & table of the command
	Prefix = Settings.Prefix;				--// The prefix the command will use, this is the ':' in ':ff me'
	Commands = {"examplecommand"};	--// A table containing the command strings (the things you chat in-game to run the command, the 'ff' in ':ff me')
	Args = {"arg1", "arg2", "etc"};	--// Command arguments, these will be available in order as args[1], args[2], args[3], etc; This is the 'me' in ':ff me'
	Description = "Example command";--// The description of the command
	AdminLevel = 100; -- Moderators	--// The commands minimum admin level; This can also be a table containing specific levels rather than a minimum level: {124, 152, "HeadAdmins", etc};
	-- Alternative option: AdminLevel = "Moderators"
	Filter = true;									--// Should user supplied text passed to this command be filtered automatically? Use this if you plan to display a user-defined message to other players
	Hidden = true;									--// Should this command be hidden from the command list?
	Function = function(plr, args, data)	--// The command's function; This is the actual code of the command which runs when you run the command
		--// "plr" is the player running the command
		--// "args" is a table containing command arguments supplied by the user
		--// "data" is a table containing information related to the command and the player running it, such as data.PlayerData.Level (the player's admin level)
		print("This is 'arg1': ".. tostring(args[1]));
		print("This is 'arg2': ".. tostring(args[2]));
		print("This is 'etc'(arg 3): ".. tostring(args[3]));
	end
};
```

Note: After adding new commands it's always a good idea to call Admin.CacheCommands() to ensure they are added to the command cache (otherwise they won't be usable.)