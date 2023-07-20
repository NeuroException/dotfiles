local awful         = require("awful")
local gears         = require("gears")
local wibox         = require("wibox")
local colors        = require("config.colors")
local vars 	    = require("config.variables")
local my_table      = awful.util.table or gears.table

-- POWEROFF --
local poweroff_btn = wibox.widget{
    {
        widget = wibox.widget.textbox,
        text = "",
        halign = "center",
        valign = "center",
        font = vars.font .. " 30",
    },
    widget = wibox.container.background,
    bg = colors.mantle,
    shape = gears.shape.circle,
    border_width = 3,
    border_color = colors.base,
    forced_height = 100,
    forced_width = 100,
}
poweroff_btn:buttons(my_table.join(awful.button({ }, 1, function ()
    awful.spawn.with_shell("poweroff")
end)))
poweroff_btn:connect_signal("mouse::enter", function(_)
    poweroff_btn.bg = colors.accent
    poweroff_btn.fg = colors.bg
end)
poweroff_btn:connect_signal("mouse::leave", function(_)
    poweroff_btn.bg = colors.mantle
    poweroff_btn.fg = colors.fg
end)


-- REBOOT --
local reboot_btn = wibox.widget{
    {
        widget = wibox.widget.textbox,
        text = "",
        halign = "center",
        valign = "center",
        font = vars.font .. " 30",
    },
    widget = wibox.container.background,
    bg = colors.mantle,
    shape = gears.shape.circle,
    border_width = 3,
    border_color = colors.base,
    forced_height = 100,
    forced_width = 100,
}
reboot_btn:buttons(my_table.join(awful.button({ }, 1, function ()
    awful.spawn.with_shell("reboot")
end)))
reboot_btn:connect_signal("mouse::enter", function(_)
    reboot_btn.bg = colors.accent
    reboot_btn.fg = colors.bg
end)
reboot_btn:connect_signal("mouse::leave", function(_)
    reboot_btn.bg = colors.mantle
    reboot_btn.fg = colors.fg
end)


-- LOGOUT --
local logout_btn = wibox.widget{
    {
        widget = wibox.widget.textbox,
        text = "",
        halign = "center",
        valign = "center",
        font = vars.font .. " 30",
    },
    widget = wibox.container.background,
    bg = colors.mantle,
    shape = gears.shape.circle,
    border_width = 3,
    border_color = colors.base,
    forced_height = 100,
    forced_width = 100,
}
logout_btn:buttons(my_table.join(awful.button({ }, 1, function ()
    awesome.quit()
end)))
logout_btn:connect_signal("mouse::enter", function(_)
    logout_btn.bg = colors.accent
    logout_btn.fg = colors.bg
end)
logout_btn:connect_signal("mouse::leave", function(_)
    logout_btn.bg = colors.mantle
    logout_btn.fg = colors.fg
end)

-- SUSPEND --
local suspend_btn = wibox.widget{
    {
        widget = wibox.widget.textbox,
        text = "",
        halign = "center",
        valign = "center",
        font = vars.font .. " 30",
    },
    widget = wibox.container.background,
    bg = colors.mantle,
    shape = gears.shape.circle,
    border_width = 3,
    border_color = colors.base,
    forced_height = 100,
    forced_width = 100,
}
suspend_btn:buttons(my_table.join(awful.button({ }, 1, function ()
    awful.spawn.with_shell("systemctl suspend")
end)))
suspend_btn:connect_signal("mouse::enter", function(_)
    suspend_btn.bg = colors.accent
    suspend_btn.fg = colors.bg
end)
suspend_btn:connect_signal("mouse::leave", function(_)
    suspend_btn.bg = colors.mantle
    suspend_btn.fg = colors.fg
end)


-- MENU --
local powermenu = awful.popup({
    screen = s,
    bg = colors.transparent,
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
    minimum_height = 130,
    maximum_height = 130,
    minimum_width = 410,
    maximum_width = 550,
    widget = {
        {
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 30,
                poweroff_btn,
                reboot_btn,
                suspend_btn,
                logout_btn,
            },
            widget = wibox.container.margin,
            margins = 25,
        },
        widget = wibox.container.background,
        bg = colors.bg,
        border_width = 3,
        border_color = colors.base,
        shape = gears.shape.rounded_rect,
    },
})
powermenu:connect_signal("mouse::leave", function(_)
    powermenu.visible = false
end)

return powermenu
