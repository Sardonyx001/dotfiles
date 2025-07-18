local function open(name)
	return function()
		hs.application.launchOrFocus(name)
		if name == "Finder" then
			hs.appfinder.appFromName(name):activate()
		end
	end
end

local function directoryLaunchKeyRemap(mods, key, dir)
	local mods = mods or {}
	hs.hotkey.bind(mods, key, function()
		local shell_command = "open " .. dir
		hs.execute(shell_command)
	end)
end

--- Finder hotkey
hs.hotkey.bind({ "alt" }, "E", open("Finder"))

-- Bind Cmd + Alt + O to open the directory in Finder
directoryLaunchKeyRemap({ "alt" }, "D", "~/Downloads/")

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

-- Precompute displays once at startup
local displays = {
	builtin = nil,
	left = nil,
	right = nil,
	all = {},
}

-- Function to update display cache
local function updateDisplays()
	local screens = hs.screen.allScreens()
	local externalScreens = {}

	displays.all = screens

	for _, screen in ipairs(screens) do
		if screen:name():match("Built%-in") then
			displays.builtin = screen
		else
			table.insert(externalScreens, screen)
		end
	end

	-- Sort external screens by x-coordinate
	if #externalScreens >= 2 then
		table.sort(externalScreens, function(a, b)
			return a:frame().x < b:frame().x
		end)
		displays.left = externalScreens[1]
		displays.right = externalScreens[2]
	elseif #externalScreens == 1 then
		displays.left = externalScreens[1]
		displays.right = nil
	end
end

-- Update displays on startup
updateDisplays()

-- Watch for display changes
local screenWatcher = hs.screen.watcher.new(updateDisplays)
screenWatcher:start()

-- Alternative smoother version without hide/unhide
local function swapDisplays(screen1, screen2)
	if not screen1 or not screen2 then
		hs.alert.show("Both displays must be available")
		return
	end

	local frame1 = screen1:frame()
	local frame2 = screen2:frame()

	-- Get all windows at once
	local allWindows = hs.window.orderedWindows()
	local windowMoves = {}

	-- Helper to check if window is maximized
	local function isMaximized(windowFrame, screenFrame)
		local threshold = 10
		return math.abs(windowFrame.x - screenFrame.x) < threshold
			and math.abs(windowFrame.y - screenFrame.y) < threshold
			and math.abs(windowFrame.w - screenFrame.w) < threshold
			and math.abs(windowFrame.h - screenFrame.h) < threshold
	end

	-- Process all windows
	for _, window in ipairs(allWindows) do
		if window:isVisible() and window:isStandard() then
			local windowScreen = window:screen()
			local currentFrame = window:frame()

			if windowScreen == screen1 then
				if isMaximized(currentFrame, frame1) then
					table.insert(windowMoves, { window = window, frame = frame2 })
				else
					local relativeX = (currentFrame.x - frame1.x) / frame1.w
					local relativeY = (currentFrame.y - frame1.y) / frame1.h
					local relativeW = currentFrame.w / frame1.w
					local relativeH = currentFrame.h / frame1.h

					table.insert(windowMoves, {
						window = window,
						frame = {
							x = frame2.x + (relativeX * frame2.w),
							y = frame2.y + (relativeY * frame2.h),
							w = relativeW * frame2.w,
							h = relativeH * frame2.h,
						},
					})
				end
			elseif windowScreen == screen2 then
				if isMaximized(currentFrame, frame2) then
					table.insert(windowMoves, { window = window, frame = frame1 })
				else
					local relativeX = (currentFrame.x - frame2.x) / frame2.w
					local relativeY = (currentFrame.y - frame2.y) / frame2.h
					local relativeW = currentFrame.w / frame2.w
					local relativeH = currentFrame.h / frame2.h

					table.insert(windowMoves, {
						window = window,
						frame = {
							x = frame1.x + (relativeX * frame1.w),
							y = frame1.y + (relativeY * frame1.h),
							w = relativeW * frame1.w,
							h = relativeH * frame1.h,
						},
					})
				end
			end
		end
	end

	-- Disable animations
	local animationDuration = hs.window.animationDuration
	hs.window.animationDuration = 0

	-- Execute all moves at once
	for _, move in ipairs(windowMoves) do
		move.window:setFrame(move.frame)
	end

	-- Restore animations
	hs.window.animationDuration = animationDuration

	-- Quick flash
	hs.alert.show("↔", 0.5)
end

-- Swap left and right external monitors
hs.hotkey.bind({ "ctrl", "cmd", "alt" }, ".", function()
	swapDisplays(displays.left, displays.right)
end)

-- Swap built-in and left external
hs.hotkey.bind({ "ctrl", "cmd", "alt" }, ",", function()
	swapDisplays(displays.builtin, displays.left)
end)

-- Swap built-in and right external
hs.hotkey.bind({ "ctrl", "cmd", "alt" }, "/", function()
	swapDisplays(displays.builtin, displays.right)
end)
