local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local naughty   = require("naughty")
local colors    = require("config.colors")
local vars      = require("config.variables")
local my_table  = awful.util.table or gears.table
local bubble    = require("ui.bubble")

local list = wibox.widget({

    base_layout = wibox.widget {
        forced_height = 30,
        spacing       = 10,
        layout        = wibox.layout.fixed.vertical
    },

    widget_template = {
        {
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 5,
                {
                    {
                        widget = naughty.widget.icon,
                    },
                    widget = wibox.container.background,
                    shape = gears.shape.circle,
                    border_width = 2,
                    border_color = colors.base,
                },
                {
                    {
                        layout = wibox.layout.fixed.vertical,
                        {
                            widget = naughty.widget.title,
                        },
                        {
                            {
                                widget = naughty.widget.message,
                            },
                            layout = wibox.container.scroll.horizontal,
                            speed = 50,
                        },
                    },
                    widget = wibox.container.place,
                },
            },
            widget = wibox.container.margin,
            margins = 10,
        },
        widget = wibox.container.background,
        shape = gears.shape.rounded_rect,
        bg = colors.mantle,
        forced_height = 50,
    },
    widget = naughty.list.notifications,
})

local ncenter = wibox.widget({
    {
        widget = list,
    },
    widget = wibox.container.background,
    bg = colors.mantle,
    shape = gears.shape.rounded_rect,
    forced_height = 170,
})


return ncenter
