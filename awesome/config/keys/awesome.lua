local awful 			= require("awful")
local gears 			= require("gears")
local vars 				= require("config.variables")
local cc 	 			= require("ui.controlcenter.controlcenter")
local naughty 			= require("naughty")
local pwr_menu 				= require("ui.popups.powermenu")

local mod = vars.modkey
local alt = vars.altkey

local keys = ({

	--- AWESOMEWM

	--- Test Notification
	awful.key({ mod }, "p", function()
		naughty.notify({ title="Test" })
	end, { description = "Quit", group = "WM" }),

	--- Restart awesome
	awful.key({ mod, "Shift" }, "r", awesome.restart, { description = "Reload", group = "WM" }),

	--- Quit awesome
	awful.key({ mod, "Shift" }, "q", function() pwr_menu.visible = true  end, { description = "Quit", group = "WM" }),

	--- Controlcenter
	awful.key({ mod }, "Escape", function() cc.visible = not cc.visible end,
		{description = "Toggle", group = "CONTROLCENTER"}),

	-- Screenshot
	awful.key({ mod, "Shift" }, "s", function() awful.spawn.with_shell("scrot -s /tmp/screenshot.png && xclip -selection clipboard -t image/png /tmp/screenshot.png && rm /tmp/screenshot.png")  end,
			{description = "Take a screenshot of selection", group = "SCREENSHOT"}),

	awful.key({ mod }, "s", function() awful.spawn.with_shell("scrot /tmp/screenshot.png && xclip -selection clipboard -t image/png /tmp/screenshot.png && rm /tmp/screenshot.png")  end,
			{description = "Take a full screenshot", group = "SCREENSHOT"}),


	--- NAVIGATION

	-- Tag Browsing
	awful.key({ mod }, "Left",   awful.tag.viewprev,
		{description = "View Previous", group = "TAG"}),

	awful.key({ mod }, "Right",  awful.tag.viewnext,
		{description = "View Next", group = "TAG"}),

	awful.key({ mod }, "Tab",  awful.tag.viewnext,
		{description = "View Next", group = "TAG"}),


	--- FOCUS

	awful.key({ mod }, "j", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then client.focus:raise() end
	end, {description = "focus down", group = "FOCUS"}),

	awful.key({ mod }, "k", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then client.focus:raise() end
	end, {description = "focus up", group = "FOCUS"}),

	awful.key({ mod }, "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then client.focus:raise() end
	end, {description = "focus left", group = "FOCUS"}),

	awful.key({ mod }, "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then client.focus:raise() end
	end, {description = "focus right", group = "FOCUS"}),


	--- LAYOUT MANIPULATION
	awful.key({ mod, "Shift"   }, "j", function()
		awful.client.swap.byidx(1)
	end,{description = "swap with next client by index", group = "LAYOUT"}),

	awful.key({ mod, "Shift"   }, "k", function()
		awful.client.swap.byidx(-1)
	end, {description = "swap with previous client by index", group = "LAYOUT"}),

	awful.key({ mod, "Control" }, "j", function()
		awful.screen.focus_relative( 1)
	end, {description = "focus the next screen", group = "LAYOUT"}),

	awful.key({ mod, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, {description = "focus the previous screen", group = "LAYOUT"}),

	awful.key({ alt, "Shift" }, "l", function()
		awful.tag.incmwfact( 0.05)
	end, {description = "increase master width factor", group = "LAYOUT"}),

	awful.key({ alt, "Shift" }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, {description = "decrease master width factor", group = "LAYOUT"}),

	awful.key({ mod, "Shift" }, "h", function()
		awful.tag.incnmaster( 1, nil, true)
	end, {description = "increase the number of master clients", group = "LAYOUT"}),

	awful.key({ mod, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, {description = "decrease the number of master clients", group = "LAYOUT"}),

	awful.key({ mod, "Control" }, "h", function()
		awful.tag.incncol( 1, nil, true)
	end, {description = "increase the number of columns", group = "LAYOUT"}),

	awful.key({ mod, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, {description = "decrease the number of columns", group = "LAYOUT"})


})


--root.keys(keys) 
awful.keyboard.append_global_keybindings(keys)
