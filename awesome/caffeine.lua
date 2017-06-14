local wibox = require("wibox")
local awful = require("awful")

local caffeine = {}

caffeine.widget = wibox.widget.imagebox()
caffeine.widget:set_image("/home/david/s/dot/awesome/caffeine_off.png")
caffeine.active = false

function on()
  local h = io.popen('ps -C xautolock -o pid --no-headers')
  local raw_out = h:read('*all')
  local retcode = {h:close()}
  if tonumber(retcode[3]) == 0 then
    local pid = raw_out:gsub("^%s*(.-)%s*$", "%1")
    local kill_cmd = "kill -9 " .. pid
    awful.util.spawn_with_shell("xset s off -dpms && " .. kill_cmd .. " && notify-send 'caffeine on'")
  else
    awful.util.spawn_with_shell("xset s off -dpms && notify-send 'caffeine on'")
  end

  caffeine.widget:set_image("/home/david/s/dot/awesome/caffeine_on.png")
  caffeine.active = true
end

function off()
  local h = io.popen('ps -C xautolock -o pid --no-headers')
  local retcode = {h:close()}
  if tonumber(retcode[3]) == 0 then
    awful.util.spawn_with_shell("xset s on +dpms && notify-send 'caffeine off'")
  else
    awful.util.spawn_with_shell("/usr/bin/xautolock -time 5 -locker /bin/lock -detectsleep &")
    awful.util.spawn_with_shell("xset s on +dpms && notify-send 'caffeine off'")
  end

  caffeine.widget:set_image("/home/david/s/dot/awesome/caffeine_off.png")
  caffeine.active = false
end

function toggle()
  if caffeine.active then off() else on() end
end

caffeine.widget:buttons(awful.util.table.join(
  awful.button({ }, 1, toggle)
))

return caffeine
