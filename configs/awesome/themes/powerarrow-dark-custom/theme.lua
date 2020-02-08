--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local naughty = require("naughty")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("widgets")
local caffeine = require("caffeine")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark-custom"
theme.wallpaper                                 = theme.dir .. "/wall.png" -- this is just a default
theme.font                                      = "source code pro 9"
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#EA6F81"
theme.fg_urgent                                 = "#DC322F"
theme.bg_normal                                 = "#1A1A1A"
theme.bg_focus                                  = theme.bg_normal
theme.bg_alt                                    = "#313131"
theme.bg_urgent                                 = theme.bg_normal
theme.border_width                              = 1
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#7F7F7F"
theme.border_marked                             = theme.fg_urgent

theme.menu_height                               = 16
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"

theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"

theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"

theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"

theme.tasklist_bg_focus                         = theme.bg_alt
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true

theme.useless_gap                               = 0

theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

theme.systray_icon_spacing                      = 2

theme.notification_fg                           = theme.fg_normal
theme.notification_bg                           = theme.bg_normal
theme.notification_border_color                 = theme.border_normal
theme.notification_border_width                 = theme.border_width
theme.notification_icon_size                    = 80
theme.notification_max_width                    = 600
theme.notification_max_height                   = 400
theme.notification_margin                       = 5

naughty.config.padding                          = 10
naughty.config.spacing                          = 10
naughty.config.defaults.timeout                 = 5
naughty.config.defaults.margin                  = theme.notification_margin
naughty.config.defaults.border_width            = theme.notification_border_width
naughty.config.defaults.position                = "top_middle"
naughty.config.defaults.title                   = "Awesome Notification"
naughty.config.defaults.icon                    = "/usr/share/awesome/icons/awesome64.png"


naughty.config.presets.normal                   = {
                                                      fg           = theme.notification_fg,
                                                      bg           = theme.notification_bg,
                                                  }
naughty.config.presets.low                      = naughty.config.presets.normal
naughty.config.presets.critical                 = {
                                                      fg           = "#dc322f",
                                                      bg           = theme.notification_bg,
                                                      timeout      = 0,
                                                  }

local separators = lain.util.separators

-- Widget icons
local memicon = wibox.widget.imagebox(theme.widget_mem)
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local weathericon = wibox.widget.imagebox(theme.widget_weather)

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_alt, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_alt)
local arrr_ld = separators.arrow_right(theme.bg_alt, "alpha")
local arrr_dl = separators.arrow_right("alpha", theme.bg_alt)

function theme.create_wibar(s, context)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(
      s,
      awful.widget.tasklist.filter.currenttags,
      awful.util.tasklist_buttons,
      {
        bg_normal = theme.bg_alt,
        shape = function(cr, width, height)
          gears.shape.powerline(cr, width, height)
        end,
        shape_border_width = 2,
        shape_border_color = theme.bg_alt,
        align = "center",
      }
    )

    -- Create hideable systray
    s.systray = wibox.widget.systray()
    s.systray.visible = false

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18,
                              bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.background(s.mylayoutbox, theme.bg_alt),
            arrr_ld,
            spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        { -- Middle widget
          layout = wibox.layout.fixed.horizontal,
          s.mytasklist,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.systray,
            caffeine.widget,
            spr, spr,
            -- widgets.pkg,
            arrl_ld,
            wibox.container.background(cpuicon, theme.bg_alt),
            wibox.container.background(context.widgets.cpu, theme.bg_alt),
            arrl_dl,
            memicon,
            context.widgets.mem,
            arrl_ld,
            wibox.container.background(context.volicon, theme.bg_alt),
            wibox.container.background(context.widgets.volume, theme.bg_alt),
            arrl_dl,
            context.baticon,
            context.widgets.bat,
            arrl_ld,
            wibox.container.background(weathericon, theme.bg_alt),
            wibox.container.background(context.widgets.weather, theme.bg_alt),
            arrl_dl,
            context.widgets.textclock,
            spr,
        },
    }
end

return theme
