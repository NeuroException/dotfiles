local naughty   	= require("naughty")
local wibox     	= require("wibox")
local gears     	= require("gears")
local dpi       	= require("beautiful.xresources").apply_dpi
local colors    	= require("config.colors")
local vars      	= require("config.variables")
local notification_list = require("ui.controlcenter.widgets.ncenter")


naughty.connect_signal("request::display", function(n)
    if n.icon == nil then
        n.icon = os.getenv("HOME") .. "/.config/awesome/media/info.png"
    end
    if vars.dnd == false then
        n.timeout = 10
    else
        n.timeout = 99999
    end
    local widget = naughty.layout.box({
        notification = n,
        type = "notification",
        cursor = "hand2",
        minimum_width = dpi(250),
        minimum_height = dpi(65),
        maximum_width = dpi(250),
        maximum_height = dpi(500),
        bg = colors.transparent,
        buttons = nil,
        widget_template = {
            {
                layout = wibox.layout.fixed.vertical,
                {
                    {
                        {
                            widget = wibox.widget.textbox,
                            text = n.title,
                        },
                        widget = wibox.container.margin,
                        left = 10,
                        right = 10,
                        bottom = 5,
                        top = 5,
                    },
                    widget = wibox.container.background,
                    bg = colors.mantle,
                },
                {
                    {
                        layout = wibox.layout.fixed.horizontal,
                        spacing = 10,
                        { -- ICON, TITLE & MESSAGE
                            {
                                widget = wibox.widget.imagebox,
                                image = n.icon,
                                forced_height = 40,
                                forced_width = 40,
                                resize = true,
                            },
                            widget = wibox.container.background,
                            shape = gears.shape.circle,
                            border_width = 3,
                            border_color = colors.base,
                        },
                        {
                            {
                                widget = wibox.widget.textbox,
                                text = n.message,
                            },
                            layout = wibox.container.scroll.horizontal,
                            speed = 50,
                        },
                    },
                    widget = wibox.container.margin,
                    margins = 10,
                },
            },
            widget = wibox.container.background,
            bg = colors.bg,
            border_width = 3,
            border_color = colors.base,
            shape = gears.shape.rounded_rect,
        },
    })
    if vars.dnd == true then
        widget.visible = false
    else
        widget.visible = true
    end

    resize_ncenter()
end)

function resize_ncenter()
    local nc = tonumber(#naughty.active)
    notification_list.visible = nc > 0
    if nc > 0 then
        local newsize = math.min(nc * 60, 300)
        notification_list.forced_height = newsize
    end
end

naughty.connect_signal("destroyed", function()
    resize_ncenter()
end)

resize_ncenter()
