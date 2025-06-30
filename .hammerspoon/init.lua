local function open(name)
	return function()
		hs.application.launchOrFocus(name)
		if name == "Finder" then
			hs.appfinder.appFromName(name):activate()
		end
	end
end

--- Finder hotkey
hs.hotkey.bind({ "alt" }, "E", open("Finder"))

-- When connected to work Wifi, mute the computer to avoid awkward moment
local workWifi = "r-intra"
local outputDeviceName = "Built-in Output"
hs.wifi.watcher
	.new(function()
		local currentWifi = hs.wifi.currentNetwork()
		local currentOutput = hs.audiodevice.current(false)
		if not currentWifi then
			return
		end
		if currentWifi == workWifi and currentOutput.name == outputDeviceName then
			hs.audiodevice.findDeviceByName(outputDeviceName):setOutputMuted(true)
		end
	end)
	:start()

-- Define a hotkey to trigger the screen swap (e.g., Ctrl+Alt+Cmd+,)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, ",", function()
	-- Step 1: Get all connected screens
	local allScreens = hs.screen.allScreens()
	local externalScreens = {}

	-- Filter for external monitors
	for _, s in ipairs(allScreens) do
		if s:isExternal() then
			table.insert(externalScreens, s)
		end
	end

	-- Step 2: Validate that exactly two external monitors are found
	if #externalScreens ~= 2 then
		hs.notification
			.new({
				title = "Hammerspoon Screen Swap",
				informativeText = "Requires exactly two external monitors to be connected for this swap script.",
			})
			:send()
		return
	end

	-- Step 3: Sort screens by their X coordinate to identify left and right
	table.sort(externalScreens, function(a, b)
		return a:frame().x < b:frame().x
	end)

	local leftScreen = externalScreens[1]
	local rightScreen = externalScreens[2]

	-- Step 4: Get the frontmost window on each identified screen
	local windowOnLeft = leftScreen:frontmostWindow()
	local windowOnRight = rightScreen:frontmostWindow()

	-- Step 5: Validate that frontmost windows exist on both screens
	if not windowOnLeft or not windowOnRight then
		hs.notify
			.new({
				title = "Hammerspoon Screen Swap",
				informativeText = "Could not find frontmost windows on both external monitors. Make sure applications are active on both.",
			})
			:send()
		return
	end

	-- Step 6: Swap the windows between the screens
	-- The 'true' argument preserves the window's relative size and position on the new screen.
	windowOnLeft:moveToScreen(rightScreen, true)
	windowOnRight:moveToScreen(leftScreen, true)

	hs.notify
		.new({
			title = "Hammerspoon Screen Swap",
			informativeText = "Windows swapped between external monitors.",
		})
		:send()
end)
