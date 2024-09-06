Contains various server-specific miscellaneous functions.

**ℹ️ This page is currently incomplete.**

### PlayerFinders

These are used when ``service.GetPlayers`` is called to search for players based on the user's input.
The default built-in player finders (at the time of writing this) can be found below to be used as examples:

```Lua
PlayerFinders = {
	["me"] = {
		Match = "me";
		Prefix = true;
		Absolute = true;
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			table.insert(players,plr)
			plus()
		end;
	};

	["all"] = {
		Match = "all";
		Prefix = true;
		Absolute = true;
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local everyone = true
			if isKicking then
				for i,v in next,parent:GetChildren() do
					local p = getplr(v)
					if p.Name:lower():sub(1,#msg)==msg:lower() then
						everyone = false
						table.insert(players,p)
						plus()
					end
				end
			end
			if everyone then
				for i,v in next,parent:GetChildren() do
					local p = getplr(v)
					if p then
						table.insert(players,p)
						plus()
					end
				end
			end
		end;
	};

	["@everyone"] = {
		Match = "@everyone";
		Absolute = true;
		Function = function(...)
			return Functions.PlayerFinders.all.Function(...)
		end
	};

	["others"] = {
		Match = "others";
		Prefix = true;
		Absolute = true;
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			for i,v in next,parent:GetChildren() do
				local p = getplr(v)
				if p ~= plr then
					table.insert(players,p)
					plus()
				end
			end
		end;
	};

	["random"] = {
		Match = "random";
		Prefix = true;
		Absolute = true;
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			if #players>=#parent:GetChildren() then return end
			local rand = parent:GetChildren()[math.random(#parent:children())]
			local p = getplr(rand)
				for i,v in pairs(players) do
				if(v.Name == p.Name)then
					Functions.PlayerFinders.random.Function(msg, plr, parent, players, getplr, plus, isKicking)
					return;
				end
			end
				table.insert(players,p)
			plus();
		end;
	};

	["admins"] = {
		Match = "admins";
		Prefix = true;
		Absolute = true;
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			for i,v in next,parent:GetChildren() do
				local p = getplr(v)
				if Admin.CheckAdmin(p,false) then
					table.insert(players, p)
					plus()
				end
			end
		end;
	};

	["nonadmins"] = {
		Match = "nonadmins";
		Prefix = true;
		Absolute = true;
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			for i,v in next,parent:GetChildren() do
				local p = getplr(v)
				if not Admin.CheckAdmin(p,false) then
					table.insert(players,p)
					plus()
				end
			end
		end;
	};

	["friends"] = {
		Match = "friends";
		Prefix = true;
		Absolute = true;
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			for i,v in next,parent:GetChildren() do
				local p = getplr(v)
				if p:IsFriendsWith(plr.userId) then
					table.insert(players,p)
					plus()
				end
			end
		end;
	};

	["@username"] = {
		Match = "@";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local matched = tonumber(msg:match("@(.*)"))
			local foundNum = 0
				if matched then
				for i,v in next,parent:GetChildren() do
					local p = getplr(v)
					if p and p.Name == matched then
						table.insert(players,p)
						plus()
						foundNum = foundNum+1
					end
				end
			end
		end;
	};

	["%team"] = {
		Match = "%";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local matched = msg:match("%%(.*)")
			if matched then
				for i,v in next,service.Teams:GetChildren() do
					if v.Name:lower():sub(1,#matched) == matched:lower() then
						for k,m in next,parent:GetChildren() do
							local p = getplr(m)
							if p.TeamColor == v.TeamColor then
								table.insert(players,p)
								plus()
							end
						end
					end
				end
			end
		end;
	};

	["$group"] = {
		Match = "$";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local matched = msg:match("%$(.*)")
			if matched and tonumber(matched) then
				for i,v in next,parent:children() do
					local p = getplr(v)
					if p:IsInGroup(tonumber(matched)) then
						table.insert(players,p)
						plus()
					end
				end
			end
		end;
	};

	["id-"] = {
		Match = "id-";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local matched = tonumber(msg:match("id%-(.*)"))
			local foundNum = 0
			if matched then
				for i,v in next,parent:children() do
					local p = getplr(v)
					if p and p.userId == matched then
						table.insert(players,p)
						plus()
						foundNum = foundNum+1
					end
				end
				if foundNum == 0 then
					local ran,name = pcall(function() return service.Players:GetNameFromUserIdAsync(matched) end)
					if ran and name then
						local fakePlayer = service.Wrap(service.New("Folder"))
						local data = {
							Name = name;
							ToString = name;
							ClassName = "Player";
							AccountAge = 0;
							CharacterAppearanceId = tostring(matched);
							UserId = tonumber(matched);
							userId = tonumber(matched);
							Parent = service.Players;
							Character = Instance.new("Model");
							Backpack = Instance.new("Folder");
							PlayerGui = Instance.new("Folder");
							PlayerScripts = Instance.new("Folder");
							Kick = function() fakePlayer:Destroy() fakePlayer:SetSpecial("Parent", nil) end;
							IsA = function(ignore, arg) if arg == "Player" then return true end end;
						}
						for i,v in next,data do fakePlayer:SetSpecial(i, v) end
						table.insert(players, fakePlayer)
						plus()
					end
				end
			end
		end;
	};

	["displayname-"] = {
		Match = "displayname-";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local matched = tonumber(msg:match("displayname%-(.*)"))
			local foundNum = 0
			if matched then
				for i,v in next,parent:children() do
					local p = getplr(v)
					if p and p.DisplayName == matched then
						table.insert(players,p)
						plus()
						foundNum = foundNum+1
					end
				end
			end
		end;
	};

	["team-"] = {
		Match = "team-";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			print(1)
			local matched = msg:match("team%-(.*)")
			if matched then
				for i,v in next,service.Teams:GetChildren() do
					if v.Name:lower():sub(1,#matched) == matched:lower() then
						for k,m in next,parent:GetChildren() do
							local p = getplr(m)
							if p.TeamColor == v.TeamColor then
								table.insert(players, p)
								plus()
							end
						end
					end
				end
			end
		end;
	};

	["group-"] = {
		Match = "group-";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local matched = msg:match("group%-(.*)")
			if matched and tonumber(matched) then
				for i,v in next,parent:children() do
					local p = getplr(v)
					if p:IsInGroup(tonumber(matched)) then
						table.insert(players,p)
						plus()
					end
				end
			end
		end;
	};

	["-name"] = {
		Match = "-";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local matched = msg:match("%-(.*)")
			if matched then
				local removes = service.GetPlayers(plr,matched,true)
				for i,v in next,players do
					for k,p in next,removes do
						if v.Name == p.Name then
							table.remove(players,i)
							plus()
						end
					end
				end
			end
		end;
	};

	["#number"] = {
		Match = "#";
		Function = function(msg, plr, ...)
			local matched = msg:match("%#(.*)")
			if matched and tonumber(matched) then
				local num = tonumber(matched)
				if not num then
					Remote.MakeGui(plr,'Output',{Title = 'Output'; Message = "Invalid number!"})
				end
					for i = 1,num do
					Functions.PlayerFinders.random.Function(msg, plr, ...)
				end
			end
		end;
	};

	["radius-"] = {
		Match = "radius-";
		Function = function(msg, plr, parent, players, getplr, plus, isKicking)
			local matched = msg:match("radius%-(.*)")
			if matched and tonumber(matched) then
				local num = tonumber(matched)
				if not num then
					Remote.MakeGui(plr,'Output',{Title = 'Output'; Message = "Invalid number!"})
				end
					for i,v in next,parent:GetChildren() do
					local p = getplr(v)
					if p ~= plr and plr:DistanceFromCharacter(p.Character.Head.Position) <= num then
						table.insert(players,p)
						plus()
					end
				end
			end
		end;
	};
};
```