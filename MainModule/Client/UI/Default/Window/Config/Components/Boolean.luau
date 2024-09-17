return function(cdata)
	local new = cdata.new
	local functionify = cdata.functionify
	local create = cdata.create
	local GUI = cdata.GUI
	local data = cdata.data
	
	local enabled = data.Enabled
	local debounce = false
	local onToggle = functionify(data.OnToggle, new)
	local function toggle(isEnabled)
		if not debounce then
			debounce = true
			if (isEnabled ~= nil and isEnabled) or (isEnabled == nil and enabled) then
				enabled = false
				new.Text = "Disabled"
			elseif (isEnabled ~= nil and isEnabled == false) or (isEnabled == nil and not enabled) then
				enabled = true
				new.Text = "Enabled"
			end

			if onToggle then
				onToggle(enabled, new)
			end
			debounce = false
		end
	end

	--new.ZIndex = data.ZIndex
	new.Text = (enabled and "Enabled") or "Disabled"
	new.MouseButton1Down:Connect(function()
		if onToggle then
			toggle()
		end
	end)

	new:SetSpecial("Toggle",function(ignore, isEnabled) toggle(isEnabled) end)
	
end