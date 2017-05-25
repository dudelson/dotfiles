
--[[
                                     
     Multicolor Awesome WM theme 2.0 
     github.com/copycat-killer       

     modified considerably by github.com/dudelson
                                     
--]]


local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- homegrown widgets
local vicious  = require("vicious")
local cal      = require("cal")
local caffeine = require("caffeine")

local os    = { getenv = os.getenv, setlocale = os.setlocale }

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/dotfiles/awesome/custom_theme"
theme.wallpaper                                 = theme.confdir .. "/wallpaper.jpg"
theme.font                                      = "source code pro 9"
theme.menu_bg_normal                            = "#000000"
theme.menu_bg_focus                             = "#000000"
theme.bg_normal                                 = "#000000"
theme.bg_focus                                  = "#000000"
theme.bg_urgent                                 = "#000000"
theme.fg_normal                                 = "#aaaaaa"
theme.fg_focus                                  = "#ff8c00"
theme.fg_urgent                                 = "#af1d18"
theme.fg_minimize                               = "#ffffff"
theme.border_width                              = 1
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#606060"
theme.border_marked                             = "#3ca4d8"
theme.menu_border_width                         = 0
theme.menu_width                                = 130
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = "#ff8c00"
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
theme.tasklist_fg_focus                         = "#d33682"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 0
theme.tooltip_bg                                = "#535d6c"
theme.tooltip_fg                                = "#0000ff" -- Apparently this doesn't work... ?

-- widget vars
local BATTERY_WIDGET_UPDATE_INTERVAL = 61
local CPU_WIDGET_UPDATE_INTERVAL = 2
local MEM_WIDGET_UPDATE_INTERVAL = 10
local PKG_WIDGET_UPDATE_INTERVAL = 86401 -- check once a day

-- {{{ Widgets
-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock()
mytextclock.font = theme.font
-- add calendar to textclock
cal.register(mytextclock)

-- CPU
local cpu_widget = wibox.widget.textbox()
cpu_widget.font = theme.font
vicious.register(cpu_widget,
                 vicious.widgets.cpu,
                 function(widget, args)
                   return string.format("CPU: %4.1f%% (%4.1f%% %4.1f%% %4.1f%% %4.1f%%) | ",
                                        args[1], args[2], args[3], args[4], args[5])
                 end,
                 CPU_WIDGET_UPDATE_INTERVAL)

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
mem_widget.font = theme.font
vicious.register(mem_widget, vicious.widgets.mem, memf, MEM_WIDGET_UPDATE_INTERVAL)

-- Battery
local function batf(widget, args)
  local state, charge_lvl_pct = args[1], args[2]

  local status_string = ''
  if state ~= '-' then status_string = '[<span color="#eaf51d">⚡</span>]' end

  local pct_string = charge_lvl_pct
  if charge_lvl_pct <= 10 then
    pct_string = string.format('<span color="#ff0000">%s</span>', charge_lvl_pct)
  end

  return string.format('Battery: %s%% %s | ', pct_string, status_string)
end

local battery_widget = wibox.widget.textbox()
battery_widget.font = theme.font
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
pkg_widget.font = theme.font
vicious.register(pkg_widget, vicious.widgets.pkg, pkgf, PKG_WIDGET_UPDATE_INTERVAL, "Arch")
-- }}}

function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

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
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
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
            mytextclock,
            s.mylayoutbox,
        },
    }
end

return theme
