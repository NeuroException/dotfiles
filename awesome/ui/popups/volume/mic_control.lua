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
    value = 5,
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
    awful.util.spawn("amixer set Capture " .. new_value .. "%")
end)

local mictoggle = wibox.widget {
    widget = wibox.widget.textbox,
    text = "",
    valign = "center",
    halign = "center",
    font = vars.font .. " 16",
}

mictoggle:buttons(my_table.join(awful.button({ }, 1, function ()
    mictoggle.toggle()
    mictoggle.check_state()
end)))

function mictoggle.check_state()
    if vars.mic == true then
        mictoggle.text = ""
    else
        mictoggle.text = ""
    end
end

function mictoggle.toggle()
    vars.mic = not vars.mic

    if vars.mic == true then
        awful.spawn.with_shell("amixer -D pulse sset Capture cap")
    else
        awful.spawn.with_shell("amixer -D pulse sset Capture nocap")
    end

    mictoggle.check_state()
end

local mic_slider = wibox.widget{
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    bubble(wibox.container.margin(mictoggle, 10, 10, 0, 0), gears.shape.rounded_rect, colors.bg),
    {
        widget = slider_widget,
    },
}

return mic_slider
