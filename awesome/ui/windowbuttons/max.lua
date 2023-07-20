local naughty   = require("naughty")
local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local dpi       = require("beautiful.xresources").apply_dpi
local colors    = require("config.colors")
local vars      = require("config.variables")
local my_table  = awful.util.table or gears.table

local button = {}

function button.create(c)

    local button_widget = wibox.widget{
        widget = wibox.container.background,
        shape = gears.shape.circle,
        forced_height = 20,
        forced_width = 20,
        bg = colors.base,
    }

    local max_button = wibox.widget{
        {
            widget = button_widget,
        },
        widget = wibox.container.margin,
        margins = 1,
    }

    button_widget:buttons(my_table.join(awful.button({ }, 1, function ()
        c.maximized = not c.maximized
    end)))

    button_widget:connect_signal("mouse::enter", function(_)
        button_widget.bg = colors.max_btn
    end)
    
    button_widget:connect_signal("mouse::leave", function(_)
        if c.maximized == false then
            button_widget.bg = colors.base
        end
    end)



    return max_button
end

return button



