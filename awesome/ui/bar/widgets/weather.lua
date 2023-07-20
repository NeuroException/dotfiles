local wibox = require("wibox")
local awful = require("awful")
local vars  = require("config.variables")
local colors  = require("config.colors")


local weather = wibox.widget{
    widget = wibox.widget.textbox,
    halign = "center",
    valign = "center",
    font = vars.font .. " 10",
    fg = colors.fg,
}

weather_script  = os.getenv("HOME") .. "/.config/awesome/ui/bar/widgets/weather.py"
local api_key   = ""
local city_id   = ""

awful.widget.watch("python3 " .. weather_script .. " " .. city_id .. " " .. api_key, 3600, function(widget, stdout)
    widget:set_text("  " .. stdout)
end, weather)

return weather
