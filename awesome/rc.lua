local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local beautiful 	= require("beautiful")
local vars 			= require("config.variables")


require("utils.startup")                      	-- STARTUP
require("utils")      				            -- Utilities
require("config")             			        -- Config
require("utils.lib.bling")          		    -- BLING
require("utils.helpers")      			        -- HELPERS
require("ui") 					                -- UI
require("ui.notifications.notifications")       -- NOTIFICATIONS


-- THEME --
beautiful.init(gears.filesystem.get_configuration_dir() .. "/ui/themes/" .. vars.theme .. "/theme.lua")

-- CREATE WIBOX FOR EACH SCREEN --
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- Startup --
awful.spawn.with_shell("bash ~/Cloud/scripts/startup.sh")
