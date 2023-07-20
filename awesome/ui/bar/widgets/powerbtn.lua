local awful         = require("awful")
local wibox         = require("wibox")
local my_table      = awful.util.table or gears.table
local colors        = require("config.colors")
local powermenu     = require("ui.popups.powermenu")
local vars 	    = require("config.variables")

-- MENU-BUTTON --
local menu_btn = wibox.widget {
    widget = wibox.widget.textbox,
    text = "",
    halign = "center",
    valign = "center",
    font = vars.font .. " 10",
}
menu_btn:buttons(my_table.join(awful.button({ }, 1, function ()
    powermenu.visible = true
end)))

return menu_btn
