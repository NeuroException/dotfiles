local awful 		= require("awful")
local vars  		= require("config.variables")
local helpers 		= require("utils.helpers")

local mod = vars.modkey



awful.keyboard.append_client_keybindings({

	-- Close
	awful.key({ mod, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "Close", group = "CLIENT" }),

	-- Maximize
	awful.key({ mod }, "m", function(c)
		c.maximized = not c.maximized
	end, { description = "Maximize", group = "CLIENT"}),

	-- Minimize
	awful.key({ mod }, "n", function(c)
		c:minimize()
	end, { description = "Minimize", group = "CLIENT"}),

	-- Toggle Floating
	awful.key({ mod }, "t", function(c)
		if c.floating == true then
			c.floating = false
			c.ontop = false
		else
			c.floating = true
			c.ontop = true
		end
	end, {description = "Toggle Floating", group = "CLIENT"}),

})