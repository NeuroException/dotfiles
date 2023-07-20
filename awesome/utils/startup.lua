local awful         = require("awful")
                      require("awful.autofocus")
local naughty       = require("naughty")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical, title = "Error during startup!", text = awesome.startup_errors })
end
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical, title = "Error during startup!", text = tostring(err) })
        in_error = false
    end)
end
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
run_once({ "unclutter -root" })