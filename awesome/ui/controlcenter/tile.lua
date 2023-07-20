local awful     = require("awful")
local wibox     = require("wibox")
local colors    = require("config.colors")
local gears     = require("gears")
local naughty   = require("naughty")
local my_table  = awful.util.table or gears.table
local vars 	= require("config.variables")

local tiles = {}

function tiles.create(msg, funcx, funcy)

    local tile = wibox.widget{
        {
            {
                widget = wibox.widget.textbox,
                text = msg,
                halign = "left",
                valign = "center",
                font = vars.font .. " 10",
            },
            widget = wibox.container.margin,
            top = 5,
            bottom = 5,
            left = 15,
        },
        widget = wibox.container.background,
        bg = colors.mantle,
        fg = colors.fg,
        shape = gears.shape.rounded_bar,
        forced_height = 40,
        forced_width = 130,
    }

    tile.powered = false

    function tile.check_state()
        if tile.powered == true then
            tile.bg = colors.accent
            tile.fg = colors.bg
        else
            tile.bg = colors.mantle
            tile.fg = colors.fg
        end
    end

    tile:buttons(my_table.join(awful.button({ }, 1, function ()
        tile.powered = not tile.powered
        if tile.powered == true then
            funcy()
        else
            funcx()
        end
        tile.check_state()
    end)))

    tile:connect_signal("mouse::enter", function() 
        if tile.powered == false then
            tile.bg = colors.base
        end
    end)
    tile:connect_signal("mouse::leave", function()
        if tile.powered == false then
            tile.bg = colors.mantle
        end
    end)



    return tile
end

return tiles
