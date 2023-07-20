local awful         = require("awful")
                      require("awful.autofocus")
local beautiful     = require("beautiful")
local wibox         = require("wibox")
local gears         = require("gears")
local my_table      = awful.util.table or gears.table
local colors        = require("config.colors")
local vars          = require("config.variables")
local close         = require("ui.windowbuttons.close")
local max           = require("ui.windowbuttons.max")
local min           = require("ui.windowbuttons.min")

-- AUTO FOCUS WINDOW BY HOVERING IF TILING MODE IS ACTIVE --
client.connect_signal("mouse::enter", function(c)
    if awful.layout.getname(s) == "tile" then
        c:emit_signal("request::activate", "mouse_enter", {raise = true})
    end
end)

client.connect_signal("focus", function(c)
    if awful.layout.getname(s) == "tile" then
        c.border_color = colors.fg
    end
end)

client.connect_signal("unfocus", function(c)
    if awful.layout.getname(s) == "tile" then
        c.border_color = colors.base
    end
end)
