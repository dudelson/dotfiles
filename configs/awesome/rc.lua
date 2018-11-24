--[[

     Awesome WM configuration template
     github.com/lcpz

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
                      require("awful.remote")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local config        = require("config")
-- }}}

config.util.log("-=-=- RESTART " .. os.date("%a %b %d %X") .. " -=-=-")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

local context = {}

context.keys = {}
context.keys.modkey       = "Mod4"
context.keys.altkey       = "Mod1"

context.designated_apps = {
  -- required fields for each app:
  --     - class: the app's x11 class (find this using xprop)
  --
  -- if you want to autospawn the app at startup, the "exec" field is required
  -- and the "spawn_callback" field is optional
  --
  -- NOTE the "tag" field is set automatically
  ['terminal'] = {
    exec = 'kitty',
    class = 'kitty',
  },
  ['browser'] = {
    exec = 'firefox',
    class = 'Firefox',
    spawn_callback = function(c) c.maximized = true end,
  },
  ['editor'] = {
    exec = 'emacs',
    class = 'Emacs',
    spawn_callback = function(c) c.maximized = true end,
  },
  ['irc_client'] = {
    exec = 'WEECHAT_PASSPHRASE=$(pass by-name/weechat) kitty --class="weechat" weechat',
    class = 'weechat',
    spawn_callback = function(c) c.maximized = true end,
  },
}

context.vars = {}
context.vars.theme        = "powerarrow-dark-custom"
context.vars.terminal     = "kitty"
context.vars.browser      = "firefox"
context.vars.editor       = "emacs"
context.vars.scrlocker    = "i3lock -n -i ~/.config/awesome/themes/powerarrow-dark-custom/wall.png"
context.vars.check_pkg_update = "checkupdates | sed 's/->/→/' | column -t"
-- either "st" for normal 24-hour time or "dt" for decimal time
context.vars.default_time_format = "st"
-- the OpenWeatherMap ID of your city
context.vars.city_id      = 4955219 -- Westford, MA

context.state = {}
context.state.detailed_widgets = false
context.state.screen_finished = false

-- declare screen configuration
context.screen_config = {
  ['undocked'] = { -- this is the config name; it has to match the autorandr profile name
    screens = {
      ['eDP-1'] = {
        tags = {
          {
            name = 'term',
            layout = awful.layout.suit.tile,
            selected = true,
            designated_for = context.designated_apps['terminal'],
          },
          {
            name = 'web',
            layout = awful.layout.suit.max,
            designated_for = context.designated_apps['browser'],
          },
          {
            name = 'spc',
            layout = awful.layout.suit.tile,
            designated_for = context.designated_apps['editor'],
          },
          {
            name = 'irc',
            layout = awful.layout.suit.tile,
            designated_for = context.designated_apps['irc_client'],
          },
        }
      },
    },
  },

  ['docked'] = { -- this is the config name; it has to match the autorandr profile name
    screens = {
      ['eDP-1'] = {
        tags = {
          {
            name = 'term',
            layout = awful.layout.suit.tile,
            selected = true,
            designated_for = context.designated_apps['terminal'],
          },
          {
            name = 'irc',
            layout = awful.layout.suit.tile,
            designated_for = context.designated_apps['irc_client'],
          },
        }
      },
      ['DP-2-1'] = {
        tags = {
          {
            name = 'web',
            layout = awful.layout.suit.max,
            selected = true,
            designated_for = context.designated_apps['browser'],
          },
          {
            name = 'spc',
            layout = awful.layout.suit.tile,
            designated_for = context.designated_apps['editor'],
          },
          {
            name = 'misc',
            layout = awful.layout.suit.tile,
          },
        }
      },
    },
  },

  ['home_tv'] = { -- this is the config name; it has to match the autorandr profile name
    screens = {
      ['eDP-1'] = {
        tags = {
          {
            name = 'term',
            layout = awful.layout.suit.tile,
            selected = true,
            designated_for = context.designated_apps['terminal'],
          },
          {
            name = 'irc',
            layout = awful.layout.suit.tile,
            designated_for = context.designated_apps['irc_client'],
          },
        }
      },
      ['HDMI-2'] = {
        tags = {
          {
            name = 'web',
            layout = awful.layout.suit.max,
            selected = true,
            designated_for = context.designated_apps['browser'],
          },
          {
            name = 'spc',
            layout = awful.layout.suit.tile,
            designated_for = context.designated_apps['editor'],
          },
          {
            name = 'misc',
            layout = awful.layout.suit.tile,
          },
        }
      },
    },
  },
}
context.screen_config['undocked'].default_tag = context.screen_config['undocked'].screens['eDP-1'].tags[1]
context.screen_config['docked'].default_tag = context.screen_config['docked'].screens['DP-2-1'].tags[3]
context.screen_config['home_tv'].default_tag = context.screen_config['home_tv'].screens['HDMI-2'].tags[3]
context.screen_config.default = context.screen_config['undocked']

awful.util.terminal = context.vars.terminal
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
    awful.layout.suit.floating,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = 250}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2
-- }}}

-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", context.vars.terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", context.vars.terminal, context.vars.editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
local mypowermenu = {
  { "suspend", "systemctl suspend"},
  { "hibernate", "systemctl hibernate"},
  { "reboot", "systemctl reboot"},
  { "poweroff", "systemctl poweroff"},
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        { "Power", mypowermenu, beautiful.awesome_icon },
        { "Open terminal", context.vars.terminal },
        -- other triads can be put here
    },
    after = {}
})
-- }}}

--- {{{ Initialize theme (has to be done before screen)
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), context.vars.theme))
--- }}}

-- {{{ Init other stuff
config.widgets.init(context)
config.keys.init(context)
config.mouse.init(context)
config.screen.init(context)
config.client.init(context) -- client must go before rules
config.rules.init(context)
config.signals.init(context)
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", config.screen.wallpaper)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    local wallpaper = config.screen.wallpaper(s)
    gears.wallpaper.maximized(wallpaper, actual_screen, true)
    beautiful.create_wibar(s, context)
end)

screen.connect_signal("added", function() config.screen.switch(context) end)
screen.connect_signal("removed", function() config.screen.switch(context) end)
-- }}}


-- this makes it so that notifications sent by notify-send respect my theme's
-- notification preferences
naughty.dbus.config.mapping = {
    {{urgency = "\1"}, naughty.config.presets.normal},
    {{urgency = "\2"}, naughty.config.presets.critical},
}


-- {{{ Autostart applications
config.util.run_once({
   "xbindkeys",
   'setxkbmap -option "ctrl:swapcaps"',
   -- "compton",
   "ibus-daemon -drx",   -- japanese input
   -- TODO: start gnome keyring
   "nm-applet",          -- network manager
   "udiskie",            -- for automounting usbs
   "xflux -z 03304",     -- takes the blues out of the monitor after sunset
   "xss-lock -- " .. context.vars.scrlocker,
   "Desktop-Bridge",     -- protonmail bridge
   "nextcloud",
   "start_jack", "cadence",  -- for JACK audio
})

-- to spawn something other than a designated app, just pass in a table with
-- the "exec", "class", and "tag" fields set. The "spawn_callback" field is optional
config.util.spawn_once(context.designated_apps['terminal'])
-- config.util.spawn_once(context.designated_apps['irc_client'])
config.util.spawn_once(context.designated_apps['editor'])
config.util.spawn_once(context.designated_apps['browser'])
-- }}}
