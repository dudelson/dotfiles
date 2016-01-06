local wibox = require("wibox")
local awful = require("awful")

sysmonitor_widget = wibox.widget.textbox()
sysmonitor_widget:set_align("right")

function update_activeram(widget)
    local used, avail, total
	for line in io.lines('/proc/meminfo') do
	    for key, value in string.gmatch(line, "([%w-_()]+):%s+(%d+).+") do
		if key == "Active" then used = tonumber(value)
		elseif key == "MemFree" then avail = tonumber(value)
		elseif key == "MemTotal" then total = tonumber(value) end
	    end
	end
     widget:set_markup(string.format("Mem: %d%% (%.2fG/%.2fG, %.2fG free) | ", 
			math.floor(used/total*100), used/1024/1024, total/1024/1024,
			avail/1024/1024))
end

update_activeram(sysmonitor_widget)

sysmonitor_timer = timer({ timeout = 1 })
sysmonitor_timer:connect_signal("timeout", function () update_activeram(sysmonitor_widget) end)
sysmonitor_timer:start()
