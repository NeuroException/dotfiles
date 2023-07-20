local wibox = require("wibox")
local awful = require("awful")
local vars  = require("config.variables")


local battery = wibox.widget{
    widget = wibox.widget.textbox,
    halign = "center",
    valign = "center",
    font = vars.font .. " 10",
}

awful.widget.watch("cat /sys/class/power_supply/BAT0/capacity", 30, function(widget, stdout)
    local battery_status_str = string.gsub(stdout, "\n", "")
    local battery_status = tonumber(battery_status_str)

    if battery_status > 80 then
        baticon = "  "
    elseif battery_status > 60 then
        baticon = "  "
    elseif battery_status > 40 then
        baticon = "  "
    elseif battery_status > 20 then
        baticon = "  "
    elseif battery_status < 10 then
        baticon = "  "
    end

    widget:set_text(baticon .. battery_status .. "%")
end, battery)

return battery