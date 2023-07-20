local awful 		= require("awful")
local vars 		= require("config.variables")

--- Modkey (Super)
local mod 		= vars.modkey

--- Variables
local terminal 	  	= vars.terminal
local browser  	  	= vars.browser
local ide      	  	= vars.ide
local filemanager 	= vars.filemanager


awful.keyboard.append_global_keybindings({

	--- Rofi
	awful.key({ mod }, " ", function()
		awful.spawn.with_shell("rofi -show drun")
	end, { description = "Rofi", group = "APP"}),

	--- Terminal
	awful.key({ mod }, "Return", function()
		awful.spawn.with_shell(terminal)
	end, { description = "Terminal", group = "APP" }),

	--- IDE
	awful.key({ mod }, "b", function()
		awful.spawn.with_shell(browser)
	end, { description = "Browser", group = "APP"}),

	--- IDE
	awful.key({ mod }, "x", function ()
		awful.spawn.with_shell(terminal .. " -e " .. ide)
	end, { description = "IDE", group = "APP"}),

	--- Filemanager
	awful.key({ mod }, "y", function()
		awful.spawn.with_shell(terminal .. " -e " .. filemanager)
	end, { description = "Filemanager", group = "APP"}),

})

