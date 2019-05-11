local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local lain = require('lain')

local config = {}

function config.init(context)
  context.widgets = {}
  local widgets = context.widgets

  local markup = lain.util.markup

  -- Textclock and calendar
  local textclock = {}
  textclock.time_format = context.vars.default_time_format

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

  function context.textclock_toggle_activate()
    if textclock.time_format == TEXTCLOCK_DEFAULT_TIME_FORMAT then
      textclock.time_format = (TEXTCLOCK_DEFAULT_TIME_FORMAT == 'dt' and 'st' or 'dt')
      -- vicious.force({ textclock.widget })
      textclock.widget:emit_signal("widget::redraw_needed")
    end
  end

  function context.textclock_toggle_deactivate()
    if textclock.time_format ~= TEXTCLOCK_DEFAULT_TIME_FORMAT then
      textclock.time_format = TEXTCLOCK_DEFAULT_TIME_FORMAT
      -- vicious.force({ textclock.widget })
      textclock.widget:emit_signal("widget::redraw_needed")
    end
  end

  textclock.widget = awful.widget.watch("date +'%R'", 60, textclock.format)
  textclock.widget.font = beautiful.font

  -- add calendar
  local cal = awful.widget.calendar_popup.month({
      style_focus = { fg_color = "#ff0000" },
      style_month = { border_width = 10, },
      start_sunday = true,
  })
  cal:attach(textclock.widget)

  widgets.textclock = textclock.widget


  -- MEM
  local mem = lain.widget.mem({
      settings = function()
          local str = string.format(" %4.1f%% ", mem_now.perc)
          if context.state.detailed_widgets then
            used = mem_now.used / 1024
            total = mem_now.total / 1024
            free = mem_now.free / 1024
            details = string.format("(%.2fG/%.2fG, %.2fG free) ", used, total, free)
            str = str .. details
          end

          widget:set_markup(markup.font(beautiful.font, str))
      end
  })
  widgets.mem = mem.widget

  -- CPU
  local cpu = lain.widget.cpu({
      settings = function()
        local str = string.format(" %4.1f%% ", cpu_now.usage)
        if context.state.detailed_widgets then
          t = {}
          for i,v in ipairs(cpu_now) do
            t[i] = string.format('%4.1f%%', cpu_now[i].usage)
          end
          details = string.format('(%s) ', table.concat(t, ' '))
          str = str .. details
        end
        widget:set_markup(markup.font(beautiful.font, str))
      end
  })
  widgets.cpu = cpu.widget

  -- Battery
  local baticon = wibox.widget.imagebox(beautiful.widget_battery)
  local bat = lain.widget.bat({
      settings = function()
          if bat_now.status and bat_now.status ~= "N/A" then
              if bat_now.ac_status == 1 then
                  baticon:set_image(beautiful.widget_ac)
              elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                  baticon:set_image(beautiful.widget_battery_empty)
              elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                  baticon:set_image(beautiful.widget_battery_low)
              else
                  baticon:set_image(beautiful.widget_battery)
              end
              widget:set_markup(markup.font(beautiful.font, " " .. bat_now.perc .. "% "))
          else
              widget:set_markup(markup.font(beautiful.font, " AC "))
              baticon:set_image(beautiful.widget_ac)
          end
      end
  })
  widgets.bat = bat.widget
  context.baticon = baticon

  -- Weather
  local weather = lain.widget.weather({
      city_id = context.vars.city_id,
      notification_preset = { font = "source code pro 9", fg = beautiful.fg_normal },
      weather_na_markup = markup.fontfg(beautiful.font, "#eca4c4", "N/A "),
      units = 'imperial',
      settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(beautiful.font, "#eca4c4", " " .. descr .. " @ " .. units .. "°F "))
      end
  })
  widgets.weather = weather.widget

  -- Package updates
  -- local pkg = widgets.pkg {
  --     command = context.vars.checkupdate,
  --     notify = "on",
  --     notification_preset = naughty.config.presets.normal,
  --     settings = function()
  --       local _color = beautiful.fg_normal
  --       local _font = beautiful.font
  --       widget:set_markup(markup.fontfg(_font, _color, available))
  --     end,
  -- }

  -- ALSA volume
  local volicon = wibox.widget.imagebox(beautiful.widget_vol)
  local volume = lain.widget.alsa({
      settings = function()
          if volume_now.status == "off" then
              volicon:set_image(beautiful.widget_vol_mute)
          elseif tonumber(volume_now.level) == 0 then
              volicon:set_image(beautiful.widget_vol_no)
          elseif tonumber(volume_now.level) <= 50 then
              volicon:set_image(beautiful.widget_vol_low)
          else
              volicon:set_image(beautiful.widget_vol)
          end

          local str = string.format(" %3d%% ", volume_now.level)
          widget:set_markup(markup.font(beautiful.font, str))
      end
  })
  widgets.volume = volume.widget
  context.volicon = volicon

  volume.widget:buttons(awful.util.table.join(
                       awful.button({}, 1, function() -- left click
                           awful.spawn(string.format("%s -e alsamixer", terminal))
                       end),
                       awful.button({}, 2, function() -- middle click
                           os.execute(string.format("%s set %s 100%%", volume.cmd, volume.channel))
                           volume.update()
                       end),
                       awful.button({}, 3, function() -- right click
                           os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
                           volume.update()
                       end),
                       awful.button({}, 4, function() -- scroll up
                           os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
                           volume.update()
                       end),
                       awful.button({}, 5, function() -- scroll down
                           os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
                           volume.update()
                       end)
  ))
end

return config
