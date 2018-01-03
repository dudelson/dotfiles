-- note that we have restarted awesome in the log file
print("-=-=- RESTART " .. os.date("%a %b %d %X") .. " -=-=-")

-- Standard awesome library
local gears     = require("gears")
local awful     = require("awful")
                  require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")

local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")
-- custom widgets
local vicious = require("vicious")
local caffeine = require("caffeine")
-- alt+tab functionality
local alttab = require("alttab")
-- yaml library for parsing my config
local yaml = require("yaml")

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
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
  local instance = nil

  return function ()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end
-- }}}

-- {{{ Variable definitions
local theme_path = string.format("%s/s/dot/awesome/custom_theme/theme.lua", os.getenv("HOME"))
beautiful.init(theme_path)

local modkey     = "Mod4"
local altkey     = "Mod1"
local terminal   = "urxvt"
local editor     = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
local browser    = "firefox"

-- Table of layouts to cover with awful.layout.inc, order matters.
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
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    awful.layout.suit.floating,
}

local taglist_buttons = gears.table.join(
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

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
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
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))
-- }}}

-- read custom configuration yaml
local dudelson_config = yaml.loadpath("/home/david/.config/dotfiles.yml")
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Widgets

-- widget vars
-- try not to make things multiples of 60 or of each other, otherwise everything's
-- running at the same time, causing CPU usage to spike periodically
local BATTERY_WIDGET_UPDATE_INTERVAL = 61
local CPU_WIDGET_UPDATE_INTERVAL = 2
local MEM_WIDGET_UPDATE_INTERVAL = 9
local PKG_WIDGET_UPDATE_INTERVAL = 2 * 60 * 60 + 5 -- check about once every 2 hours
local TEXTCLOCK_WIDGET_UPDATE_INTERVAL = 3

local SYSMONITOR_PAUSED = false

-- Custom textclock

-- either 'st' for standard time or 'dt' for decimal time
local TEXTCLOCK_DEFAULT_TIME_FORMAT = 'dt'

local textclock = {}
textclock.time_format = TEXTCLOCK_DEFAULT_TIME_FORMAT

function textclock.format(widget, args)
  local t = os.date('*t')
  local sep = ''
  local timestr = ''
  if textclock.time_format == "st" then
    sep = ' '
    timestr = os.date('%R')
  else
    -- get the number of seconds since midnight
    local secs = t.hour * 60 * 60 + t.min * 60 + t.sec
    -- convert to decimal minutes (not seconds)
    local dmins = math.floor(secs / 86.4)
    sep = '.'
    timestr = string.format('%03d', dmins)
  end
  local japn_days_of_week = {
    {'日', "#cccccc"}, {'月', "#f73434"}, {'火', "orange"}, {'水', "#0a92c0"},
    {'木', "#6fde57"}, {'金', "#fcce00"}, {'土', "#853c32"}
  }
  local kanji, color = japn_days_of_week[t.wday][1], japn_days_of_week[t.wday][2]
  local fmt_str = ' <span color="%s">%s</span> %s%s<span color="#ffffff">%s</span> '
  return string.format(fmt_str, color, kanji, os.date('%m-%d'), sep, timestr)
end

function textclock.toggle_activate()
  if textclock.time_format == TEXTCLOCK_DEFAULT_TIME_FORMAT then
    textclock.time_format = (TEXTCLOCK_DEFAULT_TIME_FORMAT == 'dt' and 'st' or 'dt')
    vicious.force({ textclock.widget })
  end
end

function textclock.toggle_deactivate()
  if textclock.time_format ~= TEXTCLOCK_DEFAULT_TIME_FORMAT then
    textclock.time_format = TEXTCLOCK_DEFAULT_TIME_FORMAT
    vicious.force({ textclock.widget })
  end
end

textclock.widget = wibox.widget.textbox()
textclock.wtype = setmetatable({}, { __call = function(_, ...) return {} end })
textclock.widget.font = beautiful.font
vicious.register(textclock.widget, textclock.wtype, textclock.format, TEXTCLOCK_WIDGET_UPDATE_INTERVAL)

-- add calendar
local cal = awful.widget.calendar_popup.month({
  style_focus = { fg_color = "#ff0000" },
  style_month = { border_width = 10, },
  start_sunday = true,
})
cal:attach(textclock.widget)


-- CPU
local function cpuf(widget, args)
  local freezestr = (SYSMONITOR_PAUSED and '[<span color="cyan">s</span>] ' or '')
  return string.format(" | %sCPU: %4.1f%% (%4.1f%% %4.1f%% %4.1f%% %4.1f%%) | ",
                       freezestr, args[1], args[2], args[3], args[4], args[5])
end
local cpu_widget = wibox.widget.textbox()
cpu_widget.font = beautiful.font
vicious.register(cpu_widget, vicious.widgets.cpu, cpuf, CPU_WIDGET_UPDATE_INTERVAL)

-- Mem
local function memf(widget, args)
  local in_use_pct, in_use_mb, total_mb, free_mb = args[1], args[2], args[3], args[4]
  return string.format("Mem: %d%% (%.2fG/%.2fG, %.2fG free) | ",
                       in_use_pct,
                       in_use_mb/1024,
                       total_mb/1024,
                       free_mb/1024)
end

local mem_widget = wibox.widget.textbox()
mem_widget.font = beautiful.font
vicious.register(mem_widget, vicious.widgets.mem, memf, MEM_WIDGET_UPDATE_INTERVAL)

-- Battery
local function batf(widget, args)
  local state, charge_lvl_pct = args[1], args[2]

  local status_string = ''
  -- CAUTION: below is *not* a hyphen. It is the unicode mathimatical minus
  -- operator, U+2212.
  if state ~= '−' then status_string = ' [<span color="#eaf51d">⚡</span>]' end

  local pct_string = charge_lvl_pct .. '%'
  if charge_lvl_pct <= 10 then
    pct_string = string.format('<span color="#ff0000">%s%%</span>', charge_lvl_pct)
  end

  return string.format('Battery: %s%s | ', pct_string, status_string)
end

-- expose this function so that we can update the battery widget immediately
-- when the AC is plugged/unplugged by writing a udev rule
local function update_battery_widget()
  vicious.force({ battery_widget })
end

local battery_widget = wibox.widget.textbox()
battery_widget.font = beautiful.font
vicious.register(battery_widget,
                 vicious.widgets.bat,
                 batf,
                 BATTERY_WIDGET_UPDATE_INTERVAL,
                 "BAT0")

-- Pending package updates
local function pkgf(widget, args)
  local format = "%d"
  if args[1] >= 50  then format = '<span color="#ff8c00">%d</span>' end
  if args[1] >= 100 then format = '<span color="#ff0000">%d</span>' end

  if args[1] == 0 then return '' else return string.format(format, args[1]) .. ' | ' end
end

local pkg_widget = wibox.widget.textbox()
pkg_widget.font = beautiful.font
vicious.register(pkg_widget, vicious.widgets.pkg, pkgf, PKG_WIDGET_UPDATE_INTERVAL, "Arch")
-- }}}

-- {{{ Screen 
local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function (s)
    set_wallpaper(s)

    -- Tags
    awful.tag.add("term", {
                    layout = awful.layout.suit.tile,
                    screen = s,
                    selected = true
    })
    awful.tag.add("web", {
                    layout = awful.layout.suit.max,
                    screen = s
    })
    awful.tag.add("spc", {
                    layout = awful.layout.suit.tile,
                    screen = s
    })

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    -- TODO: make color of brackets match color of text
    -- TODO: brackets should always be visible even if text is too big to fit
    local function uf(w, buttons, label, data, objects)
      w:reset()
      -- w.max_widget_size = 100
      for i,o in ipairs(objects) do
        local cache = data[o]
        if cache then
          tb = cache.tb
        else
          tb = wibox.widget.textbox()
          tb.ellipsize = 'middle'
          tb:buttons(awful.widget.common.create_buttons(buttons, o))

          data[o] = { tb = tb }
        end

        local text, bg, bg_image, icon = label(o, tb)
        tb:set_markup_silently('[' .. text .. ']')
        w:add(tb)
      end
    end
    s.mytasklist = awful.widget.tasklist(s,
                                         awful.widget.tasklist.filter.currenttags,
                                         awful.util.tasklist_buttons,
                                         {},
                                         uf)
    -- Separator widget
    local sep = wibox.widget.textbox()
    sep.text = "| "

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, bg = beautiful.bg_normal, fg = beautiful.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            sep,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            cpu_widget,
            mem_widget,
            battery_widget,
            pkg_widget,
            caffeine.widget,
            wibox.widget.systray(),
            textclock.widget,
            s.mylayoutbox,
        },
    }
 end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings

-------------------- keybindings that depend on configuration ------------------
-- Movement between windows
local movement_keys = {}
if #dudelson_config.monitors > 1 then
  -- with multiple monitors
  movement_keys = awful.util.table.join(
    awful.key({ modkey,           }, "j",
      function ()
        awful.client.focus.global_bydirection("left");
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey,           }, "k",
      function ()
        awful.client.focus.global_bydirection("right");
        if client.focus then client.focus:raise() end
    end)
  )
else
  -- with just one monitor
  movement_keys = awful.util.table.join(
    awful.key({ modkey }, "j", function () awful.client.focus.bydirection("down")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "k", function () awful.client.focus.bydirection("up")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "h", function () awful.client.focus.bydirection("left")
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "l", function () awful.client.focus.bydirection("right")
        if client.focus then client.focus:raise() end
    end)
  )
end

----------------- keybindings that don't depend on configuration ---------------
globalkeys = gears.table.join(
    -- Movement between tags
    awful.key({ modkey,           }, "c", function () awful.tag.viewprev(awful.screen.focused()) end,
              {description = "view next tag", group = "tag"}),
    awful.key({ modkey,           }, "v", function () awful.tag.viewnext(awful.screen.focused()) end,
              {description = "view previous tag", group = "tag"}),
    awful.key({ modkey,           }, "z", awful.tag.history.restore,
              {description = "jump to last most recent tag", group = "tag"}),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "b", function () awful.spawn("firefox") end,
              {description = "open firefox", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "u",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "i",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "i",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "u",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "i",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "u",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "x",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "r",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- pause sysmonitor stats updates
    awful.key({ modkey },            "s",
              function()
                local register = vicious.activate
                local unregister = function(w) vicious.unregister(w, true) end
                local f = (SYSMONITOR_PAUSED and register or unregister)
                SYSMONITOR_PAUSED = not SYSMONITOR_PAUSED
                f(cpu_widget)
                f(mem_widget)
                f(pkg_widget)
                vicious.force({ cpu_widget })
              end,
              {description="toggle pause sysmonitor", group="misc"}),
    -- Alt+tab
    awful.key({"Mod1",          }, "Tab",
              function () alttab.switch(1, "Alt_L", "Tab", "ISO_Left_Tab") end,
              {description = "alt-tab", group = "client"}
    ),
    awful.key({"Mod1", "Shift"  }, "Tab",
              function() alttab.switch(-1, "Alt_L", "Tab", "ISO_Left_Tab") end,
              {description = "reverse alt-tab", group = "client"}
    ),
    -- Printscreen
    awful.key({                 }, "Print",
              function()
	            awful.spawn(os.date('maim /tmp/screenshot_%Y-%m-%d_%X.png'), false)
	          end,
              {description = "take a screenshot", group = "misc"}
    ),

    -- Keybindings to focus specific tags
    -- "Mod1" is left alt
    -- jump to terminal tag
    awful.key({ modkey, "Mod1"   }, "j",
              function ()
                -- awful.tag.viewonly(tags[apps.terminal.screen][apps.terminal.tag])
                -- awful.screen.focus(apps.terminal.screen)
                awful.tag.find_by_name(awful.screen.focused(), "term"):view_only()
              end,
              {description = "jump to term tag", group = "tag"}),
    -- jump to browser tag
    awful.key({ modkey, "Mod1"   }, "k",
              function ()
                -- awful.tag.viewonly(tags[apps.browser.screen][apps.browser.tag])
                -- awful.screen.focus(apps.browser.screen)
                awful.tag.find_by_name(awful.screen.focused(), "web"):view_only()
              end,
              {description = "jump to web tag", group = "tag"}),
    -- jump to spacemacs tag
    awful.key({ modkey, "Mod1"   }, "l",
              function ()
                -- local tag = dudelson_config.application_layout.emacs[2]
                -- awful.tag.viewonly(tags[apps.emacs.screen][apps.emacs.tag])
                -- awful.screen.focus(apps.emacs.screen)
                awful.tag.find_by_name(awful.screen.focused(), "spc"):view_only()
              end,
              {description = "jump to spacemacs tag", group = "tag"}),

    -- dynamic tagging
    awful.key({ modkey, "Shift" }, "a",
              function ()
                awful.prompt.run {
                  prompt = "Run: ",
                  textbox = mouse.screen.mypromptbox.widget,
                  exe_callback = function(input)
                    if not input or #input == 0 then return end
                    -- get first whitespace-delimited token of input
                    firstspace = input:find(' ')
                    if firstspace then tagname = input:sub(0, firstspace-1) else tagname = input end
                    -- create temp tag and open application in it
                    local t = awful.tag.add(tagname, { volitile = true, selected = true })
                    t:view_only()
                    awful.spawn(input, { floating = true, tag = mouse.screen.selected_tag })
                  end
                }
              end),
    awful.key({ modkey, altkey }, "n",
              function ()
                awful.prompt.run {
                  prompt = "Tag name: ",
                  textbox = mouse.screen.mypromptbox.widget,
                  exe_callback = function(input)
                    if not input or #input == 0 then return end
                    local t = awful.tag.add(input, { selected = true })
                    t:view_only()
                  end
                }
              end),
    awful.key({modkey, altkey }, "d",
              function ()
                  local t = awful.screen.focused().selected_tag
                  if not t then return end
                  t:delete()
              end),
    awful.key({ modkey, altkey }, "r",
              function () 
                  awful.prompt.run {
                    prompt       = "New tag name: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = function(new_name)
                      if not new_name or #new_name == 0 then return end
                      local t = awful.screen.focused().selected_tag
                      if t then t.name = new_name end
                    end
                  }
              end)
)

-- Add the configuration-dependent keybingings to the global keybinding table
globalkeys = awful.util.table.join(globalkeys, movement_keys)

-- only add keybinding for lock screen if lock screen is enabled
if dudelson_config.autostart.lock_screen then
  globalkeys = awful.util.table.join(globalkeys, awful.key(
    { modkey, "Shift" }, "l",
    function()
      awful.util.spawn('i3lock-fancy')
    end
  ))
end

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, ",",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- show non-standard timebox time as long as Mod1 + Mod4 + c is /held down/
globalkeys = awful.util.table.join(globalkeys,
                                   awful.key({"Mod1", "Mod4"   }, "c", function() end))
key.connect_signal('press', function(k)
                     if k.key == 'c'
                       and #k.modifiers == 2
                       and k.modifiers[1] == "Mod1"
                       and k.modifiers[2] == "Mod4" then
                       textclock.toggle_activate()
                     end
end)
key.connect_signal('release', function(k)
                     if k.key == 'c'
                       and #k.modifiers == 2
                       and k.modifiers[1] == "Mod1"
                       and k.modifiers[2] == "Mod4" then
                       textclock.toggle_deactivate()
                     end
end)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule_any = { class = {"MPlayer", "pinentry", "Gimp", "feh", "inkscape"} },
      properties = { floating = true }
    },
    { rule = { class = "Firefox" },
      -- properties = { tag = tags[apps.browser.screen][apps.browser.tag] } },
      properties = { tag = "web" }
    },
    { rule = { class = "Emacs" },
      -- properties = { tag = tags[apps.emacs.screen][apps.emacs.tag] } },
      properties = { tag = "spc" }
    },
    -- this rule fixes a problem with urxvt and emacs where the desktop
    -- was visible along the bottom and right edges of the screen
    { rule_any = { class = { "Emacs", "URxvt" } },
      properties = { size_hints_honor = false }
    },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- auto-jump to urgent windows
client.connect_signal("property::urgent", function(c) awful.client.urgent.jumpto() end)
-- }}}



-- autostart applications

-- this function ensures that two instances of each icon do not appear in the
-- event that awesome wm is restarted
function run_once(cmd)
  -- really clumsy way of getting 0th whitespace-delimited token from cmd
  firstspace = cmd:find(" ")
  if firstspace then findme = cmd:sub(0, firstspace-1) else findme = cmd end
  awful.spawn.with_shell("pgrep -u $USER \"" .. findme .. "\" > /dev/null || (" .. cmd .. ")")
end

-- networkmanager
if dudelson_config.autostart.network_manager then run_once("nm-applet") end
-- volumeicon
if dudelson_config.autostart.volumeicon then run_once("volumeicon") end
-- automounting of usbs
if dudelson_config.autostart.udiskie then run_once("udiskie") end
-- so my screen doesn't kill my eyes at night
if dudelson_config.autostart.flux then run_once("xflux -z 14850") end
-- this user instance of anacron is responsible for running daily backups
if dudelson_config.autostart.backups then
  run_once("anacron -t /home/david/.anacron/etc/anacrontab -S /home/david/.anacron/spool &> /home/david/.anacron/anacron.log")
end
-- lock the screen automatically after 5 minutes
if dudelson_config.autostart.lock_screen then
  run_once("/usr/bin/xautolock -time 5 -locker i3lock-fancy -detectsleep")
end
-- autostart user-facing applications
-- start them in the order of least process-intensive to most process-intensive
run_once("urxvt")
run_once("emacs")
run_once("firefox")
