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

context.vars = {}
context.vars.theme        = "powerarrow-dark-custom"
context.vars.terminal     = "kitty"
context.vars.browser      = "firefox"
context.vars.editor       = "emacs"
context.vars.scrlocker    = "i3lock -n -i ~/.config/awesome/themes/powerarrow-dark-custom/wall.png"
context.vars.check_pkg_update = "checkupdates | sed 's/->/→/' | column -t"
-- either "st" for normal 24-hour time or "dt" for decimal time
context.vars.default_time_format = "st"

context.state = {}
context.state.detailed_widgets = false


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
config.client.init(context) -- client must go before rules
config.rules.init(context)
config.signals.init(context)
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
                        -- Wallpaper
                        if beautiful.wallpaper then
                          local wallpaper = beautiful.wallpaper
                          -- If wallpaper is a function, call it with the screen
                          if type(wallpaper) == "function" then
                            wallpaper = wallpaper(s)
                          end
                          gears.wallpaper.maximized(wallpaper, s, true)
                        end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s, context) end)
-- }}}


-- this makes it so that notifications sent by notify-send respect my theme's
-- notification preferences
naughty.dbus.config.mapping = {
    {{urgency = "\1"}, naughty.config.presets.normal},
    {{urgency = "\2"}, naughty.config.presets.critical},
}


-- {{{ Autostart applications
config.util.run_once({
   "nm-applet",          -- network manager
   "udiskie",            -- for automounting usbs
--    "xflux -z 03304",     -- takes the blues out of the monitor after sunset
   "xss-lock -- " .. context.vars.scrlocker,
   context.vars.terminal,
   context.vars.browser,
   context.vars.editor,
})

config.util.spawn_once {
  command = context.vars.terminal,
  tag = awful.screen.focused().tags[1],
  callback = function(c)
    c.maximized = true
  end,
}
config.util.spawn_once {
  command = context.vars.terminal .. ' weechat',
  tag = awful.screen.focused().tags[4],
  callback = function(c)
    c.maximized = true
  end,
}
config.util.spawn_once {
  command = context.vars.editor,
  tag = awful.screen.focused().tags[3],
  callback = function(c)
    c.maximized = true
  end,
}
config.util.spawn_once {
  command = context.vars.browser,
  tag = awful.screen.focused().tags[2],
  callback = function(c)
    c.maximized = true
  end,
}
-- }}}
