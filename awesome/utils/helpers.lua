local awful         = require("awful")

local functions = {}

-- GET OUTPUT OF COMMAND --
function functions.get_command_output(command)
    local file = io.popen(command)
    local output = file:read("*all")
    file:close()
    return string.gsub(output, "\n", "")
end

-- TOGGLE FLOATING FOR CLIENT --
function functions.toggleFloating(c)
    if awful.layout.getname(s) == "tile" then
        c.floating = not c.floating
        if c.floating then
            c.ontop = true
            c.placement = awful.placement.centered(c)
            c.height = 500
            c.width = 800
        else
            c.ontop = false
        end
    end
end

return functions
