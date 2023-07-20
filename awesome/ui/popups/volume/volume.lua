local awful         = require("awful")
local gears         = require("gears")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local dpi           = beautiful.xresources.apply_dpi
local colors        = require("config.colors")
local vol_slider    = require("ui.popups.volume.vol_control")
local mic_slider    = require("ui.popups.volume.mic_control")

local volume = awful.popup({
    screen = s,
    bg = colors.transparent,
    x = awful.screen.focused().geometry.width - dpi(310),
    y = 45,
    ontop = true,
    visible = false,
    minimum_height = 100,
    maximum_height = 100,
    minimum_width = 300,
    maximum_width = 300,
    widget = {
        {
            {
                layout = wibox.layout.flex.vertical,
                spacing = 10,
                {
                    widget = vol_slider,
                },
                {
                    widget = mic_slider,
                },
            },
            widget = wibox.container.margin,
            margins = 20,
        },
        widget = wibox.container.background,
        bg = colors.bg,
        shape = gears.shape.rounded_rect,
        border_width = 3,
        border_color = colors.base,
    },
})
volume:connect_signal("mouse::leave", function(_)
    volume.visible = false
end)

return volume
