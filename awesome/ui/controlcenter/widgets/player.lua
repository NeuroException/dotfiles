local awful         = require("awful")
local gears         = require("gears")
local wibox         = require("wibox")
local colors        = require("config.colors")
local vars 	    = require("config.variables")
local bling         = require("utils.lib.bling")
local my_table      = awful.util.table or gears.table
local bubble        = require("ui.bubble")
local helpers 	    = require("utils.helpers")
playerctl = bling.signal.playerctl.cli()

local art = wibox.widget {
    image = "default_image.png",
    resize = false,
    horizontal_fit_policy = "fit",
    vertical_fit_policy = "fit",
    forced_height = 50,
    forced_width = 50,
    widget = wibox.widget.imagebox
}

local title_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'left',
    valign = 'center',
    ellipsize = "end",
    font = vars.font .. " 10",
    fg = colors.fg,
    widget = wibox.widget.textbox
}

local player_name_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'left',
    valign = 'center',
    wrap = "word",
    fg = colors.bg,
    font = vars.font .. " 10",
    widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'left',
    valign = 'center',
    font = vars.font .. " 10",
    fg = colors.fg,
    widget = wibox.widget.textbox
}

local play_icon = wibox.widget{
    widget = wibox.widget.textbox,
    text = "",
    font = vars.font .. " 10",
}

local play_btn = wibox.widget{
    {
        {
            widget = play_icon,
        },
        widget = wibox.container.place,
    },
    widget = wibox.container.background,
    bg = colors.accent,
    fg = colors.bg,
    shape = gears.shape.rounded_rect,
    forced_height = 30,
    forced_width = 30,
}
play_btn:buttons(my_table.join(awful.button({ }, 1, function ()
    playerctl:play_pause()
end)))



local next_btn = wibox.widget{
    widget = wibox.widget.textbox,
    text = "",
    font = vars.font .. " 10",
}
next_btn:buttons(my_table.join(awful.button({ }, 1, function ()
    playerctl:next()
end)))

local prev_btn = wibox.widget{
    widget = wibox.widget.textbox,
    text = "",
    font = vars.font .. " 10",
}
prev_btn:buttons(my_table.join(awful.button({ }, 1, function ()
    playerctl:previous()
end)))

local player = wibox.widget {
    {
        {
            layout = wibox.layout.fixed.vertical,
            spacing = 7,
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    {
                        {
                            widget = player_name_widget,
                        },
                        widget = wibox.container.margin,
                        left = 7,
                        right = 7,
                        top = 1,
                        bottom = 1,
                    },
                    widget = wibox.container.background,
                    bg = colors.accent,
                    fg = colors.bg,
                    shape = gears.shape.rounded_bar,
                },
            },
            {
                layout = wibox.layout.align.horizontal,
                {
                    {
                        {
                            layout = wibox.layout.fixed.vertical,
                            artist_widget,
                            {
                                {
                                    widget = title_widget,
                                },
                                layout = wibox.container.scroll.horizontal,
                                speed = 50,
                            },
                        },
                        widget = wibox.container.background,
                        forced_width = 250,
                        forced_height = 35,
                        layout = wibox.layout.fixed.horizontal,
                    },
                    widget = wibox.container.place,
                },
                nil,
                {
                    {
                        widget = play_btn,
                    },
                    widget = wibox.container.place,
                },
            },
            {
                layout = wibox.layout.align.horizontal,
                bubble(wibox.container.margin(prev_btn, 10, 10, 10, 10), gears.shape.rounded_rect, colors.mantle),
                nil, -- <-- Make that a bar
                bubble(wibox.container.margin(next_btn, 10, 10, 10, 10), gears.shape.rounded_rect, colors.mantle),
            },
        },
        widget = wibox.container.margin,
        margins = 10,
    },
    widget = wibox.container.background,
    bg = colors.mantle,
    shape = gears.shape.rounded_rect,
    visible = false,
}

playerctl:connect_signal("metadata",
                       function(_, album_path, album, new)
    -- Set art widget
    art:set_image(gears.surface.load_uncached(album_path))
    title = helpers.get_command_output("playerctl metadata title")
    artist = helpers.get_command_output("playerctl metadata artist")
    player_name = helpers.get_command_output("playerctl metadata --format '{{playerName}}'")

    player_name_widget:set_markup_silently(player_name)
    title_widget:set_markup_silently(title)
    artist_widget:set_markup_silently(artist)
    player.visible = true
end)

playerctl:connect_signal("playback_status", function(_, playing)
    if playing == true then
        player.visible = true
        play_icon.text = ""
        play_btn.shape = gears.shape.rounded_rect
    else
        play_icon.text = ""
        play_btn.shape = gears.shape.circle
    end
end)

playerctl:connect_signal("no_players",function()
    player.visible = false
end)


return player
