local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local colors    = require("config.colors")
local vars      = require("config.variables")
local my_table  = awful.util.table or gears.table
local bubble    = require("ui.bubble")


local slider_widget = wibox.widget{
    widget = wibox.widget.slider,
    minimum = 0,
    maximum = 100,
    value = 50,
    bar_shape = gears.shape.rounded_bar,
    bar_height = 17,
    bar_color = colors.base,
    bar_active_color = colors.accent,
    handle_color = colors.accent,
    handle_shape = gears.shape.circle,
    handle_margins = 0,
    handle_cursor = "hand2",
    handle_border_color = colors.accent,
    handle_border_width = 5,
}

slider_widget:connect_signal("property::value", function(_, new_value)
    awful.util.spawn("amixer set Master " .. new_value .. "%")
end)

local voltoggle = wibox.widget {
    widget = wibox.widget.textbox,
    text = "",
    valign = "center",
    halign = "left",
    font = vars.font .. " 16",
}

voltoggle:buttons(my_table.join(awful.button({ }, 1, function ()
    voltoggle.toggle()
    voltoggle.check_state()
end)))

function voltoggle.check_state()
    if vars.vol == true then
        voltoggle.text = ""
    else
        voltoggle.text = ""
    end
end

function voltoggle.toggle()
    vars.vol = not vars.vol

    if vars.vol == true then
        awful.spawn.with_shell("amixer -D pulse sset Master unmute")
    else
        awful.spawn.with_shell("amixer -D pulse sset Master mute")
    end

    voltoggle.check_state()
end

local vol_slider = wibox.widget{
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    bubble(wibox.container.margin(voltoggle, 10, 10, 0, 0), gears.shape.rounded_rect, colors.bg),
    {
        widget = slider_widget,
    },
}


voltoggle.check_state()

return vol_slider
