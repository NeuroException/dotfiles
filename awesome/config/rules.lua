local awful         = require("awful")
                      require("awful.autofocus")
local beautiful     = require("beautiful")


function init()

    awful.rules.rules = {

        { rule = { }, --      NO TITLEBAR FOR POLYBAR                 !! IMPORTANT - NO RESIZED TOR BROWSER TO PREVENT FINGERPRINTING !!
          except_any = { class = { "Polybar" }, class = { "Tor Browser" }, type = { "dialog" } },
          properties = { border_width = beautiful.border_width,
                         border_color = beautiful.brd_color,
                         focus = awful.client.focus.filter,
                         raise = true,
                         keys = clientkeys,
                         buttons = clientbuttons,
                         screen = awful.screen.preferred,
                         placement = awful.placement.no_offscreen,
                         size_hints_honor = false,
                         height = 400,
                         width = 700,
         }
        },
    
        { rule = { class = "Polybar" }, properties = { border_width = 0, focus = nil, buttons = nil, raise = false, border_color = nil, requests_no_titlebar = true, titlebars_enabled = false, skip_taskbar = true } },
    
        { rule = { name = "Picture-in-Picture" }, properties = { floating = true, requests_no_titlebar = false, titlebars_enabled = true, ontop = true, sticky = true, placement = awful.placement.no_offscreen+awful.placement.closest_corner, awful.client.focus.filter } },
    
        { rule = { type = "dialog" }, properties = { floating = true, ontop = true, placement = awful.placement.centered, awful.client.focus.filter } },
    
        { rule = { class = "Tor Browser" }, properties = { floating = true, ontop = true, placement = awful.placement.centered, awful.client.focus.filter } },


        { rule = { class = "monero-core" }, properties = { floating = true, ontop = true, placement = awful.placement.centered, awful.client.focus.filter, requests_no_titlebar = false, titlebars_enabled = true } },

    }

end

return init()