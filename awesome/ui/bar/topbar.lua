local awful         = require("awful")
local wibox         = require("wibox")
local colors        = require("config.colors")
local gears         = require("gears")
local my_table      = awful.util.table or gears.table
local battery       = require("ui.bar.widgets.battery")
local controlcenter = require("ui.controlcenter.controlcenter")
local volumepopup   = require("ui.popups.volume.volume")
local taglist       = require("ui.bar.taglist")
local tasklist      = require("ui.bar.tasklist")
local clock         = require("ui.bar.widgets.clock")
local volume        = require("ui.bar.widgets.volume")
local bubble        = require("ui.bubble")


clock:buttons(my_table.join(awful.button({ }, 1, function ()
    controlcenter.visible = not controlcenter.visible
end)))

volume:buttons(my_table.join(awful.button({ }, 1, function ()
    volumepopup.visible = not volumepopup.visible
end)))

function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

-- Check if system has a battery. Hide widget if not.
local battery_widget = bubble(wibox.container.margin(battery, 10, 10, 0, 0), gears.shape.rounded_bar, colors.bg)
if not file_exists("/sys/class/power_supply/BAT0/capacity") then
    battery_widget.visible = false
end

local clock_widget = bubble(wibox.container.margin(clock, 10, 10, 0, 0), gears.shape.rounded_bar, colors.transparent)

local volume_widget = bubble(wibox.container.margin(volume, 10, 10, 0, 0), gears.shape.rounded_bar, colors.transparent)

local topbar = {}

function topbar.create(s)

    local tagl = taglist.create(s)
    local taskl = tasklist.create(s)

    if s.geometry.height > 1080 then -- Large screen

        local bar = awful.wibar({
            height = 35,
            type = "dock",
            screen = s,
            bg = colors.transparent,
            stretch = true,
        })

        bar:setup{
            {
                {
                    {
                        layout = wibox.layout.stack,
                        {

                            layout = wibox.layout.align.horizontal,
                            tagl, -- Taglist
                            nil,
                            {
                                battery_widget,
                                volume_widget,
                                clock_widget,
                                layout = wibox.layout.fixed.horizontal,
                                spacing = 2,
                            },

                        },
                        {
                            {
                                widget = taskl, -- Tasklist
                            },
                            widget = wibox.container.place,
                        },
                    },
                    widget = wibox.container.margin,
                    left = 15,
                    right = 15,
                },
                widget = wibox.container.background,
                bg = colors.bg,
                shape = gears.shape.rounded_rect,
                border_width = 2,
                border_color = colors.base,
            },
            widget = wibox.container.margin,
            left = 10,
            right = 10,
            top = 10,
        }
    else -- Small screen

        local bar = awful.wibar({
            height = 25,
            type = "dock",
            screen = s,
            bg = colors.transparent,
            stretch = true,
        })

        bar:setup{
            {
                {
                    layout = wibox.layout.stack,
                    {

                        layout = wibox.layout.align.horizontal,
                        tagl, -- Taglist
                        nil,
                        {
                            battery_widget,
                            volume_widget,
                            clock_widget,
                            layout = wibox.layout.fixed.horizontal,
                            spacing = 2,
                        },

                    },
                    {
                        {
                            widget = taskl, -- Tasklist
                        },
                        widget = wibox.container.place,
                    },
                },
                widget = wibox.container.margin,
                left = 15,
                right = 15,
            },
            widget = wibox.container.background,
            bg = colors.bg,
        }
    end


    return bar
end

return topbar
