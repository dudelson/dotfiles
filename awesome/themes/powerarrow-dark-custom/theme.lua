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

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark-custom"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "source code pro 9"
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#EA6F81"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#1A1A1A"
theme.bg_focus                                  = "#1A1A1A"
theme.bg_alt                                    = "#313131"
theme.bg_urgent                                 = "#1A1A1A"
theme.border_width                              = 1
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#7F7F7F"
theme.border_marked                             = "#CC9393"

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


local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock and calendar
local TEXTCLOCK_DEFAULT_TIME_FORMAT = 'dt'

local textclock = {}
textclock.time_format = TEXTCLOCK_DEFAULT_TIME_FORMAT

function textclock.format(widget, stdout)
  local t = os.date('*t')
  local sep = ''
  local timestr = ''
  if textclock.time_format == "st" then
    sep = ' '
    timestr = stdout
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
  widget:set_markup(string.format(fmt_str, color, kanji, os.date('%m-%d'), sep, timestr))
end

function textclock.toggle_activate()
  if textclock.time_format == TEXTCLOCK_DEFAULT_TIME_FORMAT then
    textclock.time_format = (TEXTCLOCK_DEFAULT_TIME_FORMAT == 'dt' and 'st' or 'dt')
    -- vicious.force({ textclock.widget })
    textclock.widget:emit_signal("widget::redraw_needed")
  end
end

function textclock.toggle_deactivate()
  if textclock.time_format ~= TEXTCLOCK_DEFAULT_TIME_FORMAT then
    textclock.time_format = TEXTCLOCK_DEFAULT_TIME_FORMAT
    -- vicious.force({ textclock.widget })
    textclock.widget:emit_signal("widget::redraw_needed")
  end
end

textclock.widget = awful.widget.watch("date +'%R'", 60, textclock.format)
-- textclock.wtype = setmetatable({}, { __call = function(_, ...) return {} end })
textclock.widget.font = theme.font
-- vicious.register(textclock.widget, textclock.wtype, textclock.format, TEXTCLOCK_WIDGET_UPDATE_INTERVAL)

-- add calendar
local cal = awful.widget.calendar_popup.month({
    style_focus = { fg_color = "#ff0000" },
    style_month = { border_width = 10, },
    start_sunday = true,
})
cal:attach(textclock.widget)

-- expose to rest of config
theme.textclock = textclock


-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        local str = string.format(" %4.1f%% ", mem_now.perc)
        widget:set_markup(markup.font(theme.font, str))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        local str = string.format(" %4.1f%% ", cpu_now.usage)
        widget:set_markup(markup.font(theme.font, str))
    end
})

function cpu.show()
  cpu.hide()

  local str = string.format("%4.1f%% %4.1f%% %4.1f%% %4.1f%%",
                            cpu.core[1].usage,
                            cpu.core[2].usage,
                            cpu.core[3].usage,
                            cpu.core[4].usage)
  cpu.notification = naughty.notify({
      text = str,
  })
end

function cpu.hide()
  if cpu.notification then
    naughty.destroy(cpu.notification)
    cpu.notification = nil
  end
end

cpu.widget:connect_signal("mouse::enter", function() cpu.show() end)
cpu.widget:connect_signal("mouse::leave", function() cpu.hide() end)

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                baticon:set_image(theme.widget_ac)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)
local weather = lain.widget.weather({
    city_id = 5084868, -- Concord, NH
    notification_preset = { font = "source code pro 9", fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
    units = 'imperial',
    settings = function()
      descr = weather_now["weather"][1]["description"]:lower()
      units = math.floor(weather_now["main"]["temp"])
      widget:set_markup(markup.fontfg(theme.font, "#eca4c4", " " .. descr .. " @ " .. units .. "°F "))
    end
})

-- Package updates
-- local pkg = widgets.pkg {
--     command = context.vars.checkupdate,
--     notify = "on",
--     notification_preset = naughty.config.presets.normal,
--     settings = function()
--       local _color = theme.fg_normal
--       local _font = theme.font
--       widget:set_markup(markup.fontfg(_font, _color, available))
--     end,
-- }

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
local volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        local str = string.format(" %3d%% ", volume_now.level)
        widget:set_markup(markup.font(theme.font, str))
    end
})

-- Systray
wibox.widget.textbox('')

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_alt, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_alt)
local arrr_ld = separators.arrow_right(theme.bg_alt, "alpha")
local arrr_dl = separators.arrow_right("alpha", theme.bg_alt)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

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
        {
          layout = wibox.layout.fixed.horizontal,
          s.mytasklist, -- Middle widget
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.systray,
            spr, spr,
            arrl_ld,
            wibox.container.background(cpuicon, theme.bg_alt),
            wibox.container.background(cpu.widget, theme.bg_alt),
            arrl_dl,
            memicon,
            mem.widget,
            arrl_ld,
            wibox.container.background(volicon, theme.bg_alt),
            wibox.container.background(volume.widget, theme.bg_alt),
            arrl_dl,
            baticon,
            bat.widget,
            arrl_ld,
            wibox.container.background(weathericon, theme.bg_alt),
            wibox.container.background(weather.widget, theme.bg_alt),
            arrl_dl,
            textclock.widget,
            spr,
        },
    }
end

return theme
