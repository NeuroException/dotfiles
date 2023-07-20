local awful             = require("awful")
local gears             = require("gears")
local wibox             = require("wibox")
local beautiful         = require("beautiful")
local dpi               = beautiful.xresources.apply_dpi
local colors            = require("config.colors")
local player            = require("ui.controlcenter.widgets.player")
local notification_list = require("ui.controlcenter.widgets.ncenter")
local weather           = require("ui.bar.widgets.weather")
local cal               = require("ui.controlcenter.widgets.calendar")

-- QUICK TILES --
local tiles             = require("ui.controlcenter.tile")
local placeholder       = tiles.create("Placeholder", function() end, function()  end)
local dnd_tile          = require("ui.controlcenter.tiles.dnd")

local controlcenter = awful.popup({
    screen = s,
    bg = colors.transparent,
    fg = colors.fg,
    x = awful.screen.focused().geometry.width - dpi(360),
    y = 45,
    ontop = true,
    visible = false,
    minimum_height = 100,
    minimum_width = 350,
    maximum_width = 350,
    widget = {
        {
            {
                layout = wibox.layout.fixed.vertical,
                spacing = 20,
                {
                    {
                        {
                            layout = wibox.layout.align.horizontal,
                            {
                                widget = weather,
                            },
                            nil,
                            {
                                {
                                    widget = wibox.widget.systray(),
                                    base_size = 15,
                                },
                                widget = wibox.container.place,
                            },
                        },
                        widget = wibox.container.margin,
                        left = 10,
                        right = 10,
                    },
                    widget = wibox.container.background,
                    forced_height = 20,
                },
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = 10,
                    {
                        layout = wibox.layout.flex.horizontal,
                        spacing = 10,
                        {
                            widget = dnd_tile,
                        },
                        {
                            widget = placeholder,
                        },
                    },
                    {
                        layout = wibox.layout.flex.horizontal,
                        spacing = 10,
                        {
                            widget = placeholder,
                        },
                        {
                            widget = placeholder,
                        },
                    },
                },
                {
                    widget = cal,
                },
                {
                    widget = player,
                },
                {
                    widget = notification_list,
                },
            },
            widget = wibox.container.margin,
            top = 20,
            bottom = 20,
            left = 15,
            right = 15,
        },
        widget = wibox.container.background,
        bg = colors.bg,
        border_width = 3,
        border_color = colors.base,
        shape = gears.shape.rounded_rect,
    },
})
controlcenter:connect_signal("mouse::leave", function(_)
    controlcenter.visible = false
end)


return controlcenter
