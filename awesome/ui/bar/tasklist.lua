local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local naughty       = require("naughty")
local dpi           = require("beautiful.xresources").apply_dpi
local beautiful     = require("beautiful")
local colors        = require("config.colors")
local bling         = require("utils.lib.bling")


local tasklist = {}

-- BLING --
beautiful.task_preview_widget_border_radius     = 10
beautiful.task_preview_widget_bg                = colors.bg
beautiful.task_preview_widget_border_color      = colors.base
beautiful.task_preview_widget_border_width      = 3
beautiful.task_preview_widget_margin            = 10

-- TASKLIST --
beautiful.tasklist_bg_normal                    = colors.mantle
beautiful.tasklist_bg_urgent                    = colors.critical
beautiful.tasklist_bg_focus                     = colors.base
beautiful.tasklist_bg_minimize                  = colors.crust

function tasklist.create(s)

    bling.widget.task_preview.enable {
        height = 200,
        width = 200,
        screen = s,
        placement_fn = function(c)
            awful.placement.top(c, {
                margins = {
                    top = 45
                }
            })
        end
    }

    local tasklist_widget = awful.widget.tasklist {
        screen = s,
        filter   = awful.widget.tasklist.filter.alltags,
        source = function()
            local ret = {}

            for _, t in ipairs(s.tags) do
                gears.table.merge(ret, t:clients())
            end

            return ret
        end,
        buttons = {
            awful.button({}, 1, function (c)
                if not c.active then
                    c:activate {
                        context = 'through_dock',
                        switch_to_tag = true,
                    }
                else
                    c.minimized = true
                end
            end),
            awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({}, 5, function() awful.client.focus.byidx( 1) end),
        },
        style = {
            shape = gears.shape.rounded_bar,
        },
        layout = {
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                    margins = 5,
                    widget = wibox.container.margin,
                },
                id = "background_role",
                widget = wibox.container.background,
                forced_width = 22,
            },
            widget = wibox.container.margin,
            margins = 1,
            create_callback = function (self, c, _, _)
                self:connect_signal('mouse::enter', function ()
                    awesome.emit_signal('bling::task_preview::visibility', s, true, c)
                end)
                self:connect_signal('mouse::leave', function ()
                    awesome.emit_signal('bling::task_preview::visibility', s, false, c)
                end)
            end
        }
    }

    return tasklist_widget
end

return tasklist


