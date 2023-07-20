local awful     = require("awful")
local gears     = require("gears")
local wibox     = require("wibox")
local naughty   = require("naughty")
local colors    = require("config.colors")
local vars      = require("config.variables")
local my_table  = awful.util.table or gears.table
local tiles     = require("ui.controlcenter.tile")

local tile = tiles.create("  Do not Disturb", function()
    vars.dnd = false
end, function()
    vars.dnd = true
end)

return tile