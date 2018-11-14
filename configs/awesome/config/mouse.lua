local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")

local config = {}

function config.init(context)
  root.buttons(gears.table.join(
                 awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
                 awful.button({ }, 4, awful.tag.viewnext),
                 awful.button({ }, 5, awful.tag.viewprev)
  ))
end

return config
