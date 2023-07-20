local awful = require("awful")

function init()

    -- LAYOUT --
    awful.util.tagnames = {"1", "2", "3", "4", "5"}
    awful.layout.suit.tile.left.mirror = true
    awful.layout.layouts = {
        awful.layout.suit.tile,
        awful.layout.suit.floating,
    }

end

return init()