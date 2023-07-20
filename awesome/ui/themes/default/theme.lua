local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local colors        = require("config.colors")
local vars          = require("config.variables")


local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/default"

-- FONT --
theme.font                                      = vars.font .. " 10"
theme.font_small                                = vars.font .. " 8"

-- MISC --
theme.useless_gap                               = vars.gap

-- TOOLTIPS --
theme.tooltip_bg                                = colors.bg
theme.tooltip_fg                                = colors.fg
theme.tooltip_font                              = theme.font_small
theme.tooltip_shape                             = gears.shape.rounded_rect
theme.tooltip_border_width                      = 2
theme.tooltip_border_color                      = colors.base

-- BORDER --
theme.border_width                              = 3
theme.border_normal                             = colors.base
theme.border_focus                              = colors.base
theme.border_marked                             = colors.base

-- TITLEBAR --
theme.titlebar_bg                               = colors.bg

-- TRAY ICONS --
theme.bg_systray                                = colors.bg
theme.systray_icon_spacing                      = 5

function theme.at_screen_connect(s)

    --WALLPAPER--
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- TAGNAMES
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- TOPBAR --
    local topbar = require("ui.bar.topbar")
    local bar = topbar.create(s)

end

return theme
