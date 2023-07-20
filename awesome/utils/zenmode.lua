local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local naughty   = require("naughty")
local beautiful = require("beautiful")
local colors    = require("config.colors")
local vars      = require("config.variables")
local my_table  = awful.util.table or gears.table

local zm = {}

local function hide_all_titlebars()
    for _, c in ipairs(client.get()) do
        awful.titlebar.hide(c)
    end
end

local function show_all_titlebars()
    for _, c in ipairs(client.get()) do
        awful.titlebar.show(c)
    end
end

function picom_kill()
    awful.spawn.with_shell("pkill -f -9 picom")
end

function picom_zen()
    picom_kill()
    local timer = gears.timer {
        timeout = 1,
        single_shot = true,
        autostart = false,
        callback = function() awful.spawn.with_shell("picom --experimental-backends --corner-radius 0 --round-borders 0 --no-fading-openclose") end,
    }
    timer:start()
end

function picom_fancy()
    picom_kill()
    local timer = gears.timer {
        timeout = 1,
        single_shot = true,
        autostart = false,
        callback = function() awful.spawn.with_shell("picom --experimental-backends --corner-radius 15 --round-borders 1") end,
    }
    timer:start()
end

function zm.enable()
    vars.zen = true
    hide_all_titlebars()
    picom_zen()
    beautiful.useless_gap = 0
end

function zm.disable()
    vars.zen = false
    show_all_titlebars()
    picom_fancy()
    beautiful.useless_gap = vars.gap
end


return zm