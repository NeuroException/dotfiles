local wibox     = require("wibox")
local awful     = require("awful")
local vars      = require("config.variables")
local colors    = require("config.colors")

local clock = wibox.widget {
    widget = wibox.widget.textbox,
    halign = "center",
    valign = "center",
    font = vars.font .. " 10",
    fg = colors.fg,
}

awful.widget.watch("date +'%H:%M'", 10, function(widget, stdout)
    widget:set_text("  " .. string.format("%s", stdout))
end, clock)


return clock
