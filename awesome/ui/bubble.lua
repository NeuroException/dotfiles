local wibox     = require("wibox")
local colors    = require("config.colors")


function create_bubble(w, s, bg)

    local vars = require("config.variables")

    local bubble = wibox.widget({
        {
            widget = w,
        },
        widget = wibox.container.background,
        bg = bg,
        shape = s,
        fg = colors.fg,
    })

    bubble:connect_signal("mouse::enter", function() bubble.bg = colors.base end)
    bubble:connect_signal("mouse::leave", function() bubble.bg = colors.transparent end)
    return bubble
end

return create_bubble
