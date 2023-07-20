local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local gears         = require("gears")
local my_table      = awful.util.table or gears.table
local colors        = require("config.colors")
local vars          = require("config.variables")
local close         = require("ui.windowbuttons.close")
local max           = require("ui.windowbuttons.max")
local min           = require("ui.windowbuttons.min")

client.connect_signal("request::titlebars", function(c)

    -- TITLEBAR BUTTONS --
    local close_btn = close.create(c)
    local max_btn   = max.create(c)
    local min_btn   = min.create(c)

    -- MAKE TITLEBAR DRAGABLE --
    local tbar_buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
              c:emit_signal("request::activate", "titlebar", {raise = true})
              awful.mouse.client.resize(c)
        end)
    )

    local tbar = awful.titlebar(c, { size = 25 })

    tbar:setup{
        layout = wibox.layout.stack,
        buttons = tbar_buttons,
        {
            layout = wibox.layout.align.horizontal,
            { -- Left
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal,
                wibox.container.margin(wibox.container.background(awful.titlebar.widget.iconwidget(c), colors.bg, gears.shape.rounded_rect), 15, 4, 4, 4),
            },
            nil,
            { -- Right
                wibox.container.margin(min_btn, 0, 3, 3, 3),
                wibox.container.margin(max_btn, 0, 3, 3, 3),
                wibox.container.margin(close_btn, 0, 15, 3, 3),
                layout = wibox.layout.fixed.horizontal(),
            },
        },
        {
            --layout = wibox.layout.flex.horizontal,
            {
                widget = wibox.container.margin(awful.titlebar.widget.titlewidget(c) , 6, 4, 4, 6),
            },
            widget = wibox.container.place,
        },
    }

end)

 -- GIVE NEW APPEARING WINDOW A TITLEBAR
 client.connect_signal("manage", function(c)
    if c.type ~= "dock"  then
        if c.requests_no_titlebar == false then
            if vars.zen == false then
                awful.titlebar.show(c)
            end
        end
    end
end)
