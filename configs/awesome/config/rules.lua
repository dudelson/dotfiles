local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")

local config = {}

function config.init(context)
  awful.rules.rules = {
      -- All clients will match this rule.
      { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = awful.client.focus.filter,
                       raise = true,
                       keys = context.clientkeys,
                       buttons = context.clientbuttons } },
      { rule_any = { class = {"MPlayer", "pinentry", "Gimp", "feh", "inkscape"} },
        properties = { floating = true }
      },
      -- this rule fixes a problem with urxvt and emacs where the desktop
      -- was visible along the bottom and right edges of the screen
      { rule_any = { class = { "Emacs", "URxvt" } },
        properties = { size_hints_honor = false }
      },
  }
end

return config
