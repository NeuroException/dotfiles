local wibox = require("wibox")
local awful = require("awful")
local vars  = require("config.variables")


local volume = wibox.widget {
    widget = wibox.widget.textbox,
    halign = "center",
    valign = "center",
    font = vars.font .. " 12",
    text = "",
}


return volume
