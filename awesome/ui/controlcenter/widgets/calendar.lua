local awful         = require("awful")
local gears         = require("gears")
local wibox         = require("wibox")
local naughty       = require("naughty")
local colors        = require("config.colors")
local vars 	    = require("config.variables")
local clock         = require("ui.bar.widgets.clock")
local bling         = require("utils.lib.bling")
local my_table      = awful.util.table or gears.table
local bubble        = require("ui.bubble")
local helpers 	    = require("utils.helpers")



local styles = {}
local function rounded_shape(size, partial)
    if partial then
        return function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height,
                    false, true, false, true, 5)
        end
    else
        return function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, size)
        end
    end
end
styles.month   = { padding      = 5,
                   bg_color     = '#555555',
                   border_width = 2,
                   shape        = rounded_shape(10)
}
styles.normal  = { shape    = rounded_shape(5) }
styles.focus   = { fg_color = '#000000',
                   bg_color = '#ff9800',
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = rounded_shape(5, true)
}
styles.header  = { fg_color = '#de5e1e',
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = rounded_shape(10)
}
styles.weekday = { fg_color = '#7788af',
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = rounded_shape(5)
}

local function decorate_cell(widget, flag, date)
    if flag=='monthheader' and not styles.monthheader then
        flag = 'header'
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape              = props.shape,
        shape_border_width = 0,
        fg                 = colors.fg,
        bg                 = colors.mantle,
        widget             = wibox.container.background,
        forced_width       = 37,
    }
    return ret
end

local cal = wibox.widget {
    date     = os.date('*t'),
    fn_embed = decorate_cell,
    widget   = wibox.widget.calendar.month
}



return cal
