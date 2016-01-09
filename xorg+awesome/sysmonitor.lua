local wibox = require("wibox")
local awful = require("awful")

sysmonitor_widget = wibox.widget.textbox()
sysmonitor_widget:set_align("right")
sysmonitor_widget:set_font("source code pro 9")

function update_battery() 
    fh = assert(io.popen("acpi", "r"))
    charge_level = ""
    charging = ""
    for a, b in string.gmatch(fh:read("*l"), ".+: (.+), (.+%%).*") do
	charging = a
	charge_level = b
    end
    fh:close()

    charge_level_fmt = '%s'
    if charge_level:len() == 2 then
	charge_level_fmt = '<span color="#ff0000">%s</span>'
    end

    if charging ~= 'Discharging' then
	charging_status = ' [<span color="#eaf51d">⚡</span>]'
    else
	charging_status = ''
    end
    
    return string.format("Battery: " .. charge_level_fmt .. "%s | ", charge_level, charging_status)
end

function update_activeram()
    local used, avail, total
	for line in io.lines('/proc/meminfo') do
	    for key, value in string.gmatch(line, "([%w-_()]+):%s+(%d+).+") do
		if key == "Active" then used = tonumber(value)
		elseif key == "MemFree" then avail = tonumber(value)
		elseif key == "MemTotal" then total = tonumber(value) end
	    end
	end
    return string.format("Mem: %d%% (%.2fG/%.2fG, %.2fG free) | ",
			math.floor(used/total*100), used/1024/1024, total/1024/1024,
			avail/1024/1024)
    
end

local n_cpu_cores
for line in io.lines('/proc/cpuinfo') do
    for colname, value in string.gmatch(line, "(.+): (.+)") do
	-- trim whitespace from colname
	colname = colname:gsub("^%s*(.-)%s*$", "%1")
	if colname == "cpu cores" then n_cpu_cores = tonumber(value) end
    end
end

local cpu_state = {cpu={prevNonIdleTotal=0, prevTotal=0}}
for i=0, n_cpu_cores-1, 1 do
    cpu_state[string.format("cpu%d", i)] = {prevNonIdleTotal=0, prevTotal=0}
end

function update_activecpu()
    local prevTotal, prevIdleTotal, prevNonIdleTotal, total, idleTotal, nonIdleTotal

    for line in io.lines('/proc/stat') do
	for colname in string.gmatch(line, "([%w_]+).+") do
	    if colname:match("cpu%d*") ~= nil then
		for user, nice, sys, idle, iowait, irq, softirq, steal, guest,
		    guest_nice in string.gmatch(line,
		    "[%w_]+%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)") do
			-- keep the idle total as a separate calculation
			-- we might want to use it for something else someday
			idleTotal    = idle + iowait 
			nonIdleTotal = user + nice + sys + irq + softirq + steal
			cpu_state[colname].nonIdleTotal = nonIdleTotal
			cpu_state[colname].total = idleTotal + nonIdleTotal
		end
	    end
	end
    end

    cpu_usage = (cpu_state.cpu.nonIdleTotal - cpu_state.cpu.prevNonIdleTotal) /
                (cpu_state.cpu.total - cpu_state.cpu.prevTotal) * 100
    if n_cpu_cores == 1 then ret = string.format("CPU: %4.1f%% | ", cpu_usage)
    else 
	ret = string.format("CPU: %4.1f%% (", cpu_usage)
	for i=0, n_cpu_cores-2, 1 do
	    curCPU = string.format("cpu%d", i)
	    cpu_usage = (cpu_state[curCPU].nonIdleTotal - cpu_state[curCPU].prevNonIdleTotal) /
			(cpu_state[curCPU].total - cpu_state[curCPU].prevTotal) * 100
	    ret = ret .. string.format("%4.1f%% ", cpu_usage)
	end
	curCPU = string.format("cpu%d", n_cpu_cores-1)
	cpu_usage = (cpu_state[curCPU].nonIdleTotal - cpu_state[curCPU].prevNonIdleTotal) /
		    (cpu_state[curCPU].total - cpu_state[curCPU].prevTotal) * 100
	ret = ret .. string.format("%4.1f%%) | ", cpu_usage)
    end
    
    for k, v in pairs(cpu_state) do
	cpu_state[k].prevIdleTotal = v.idleTotal
	cpu_state[k].prevNonIdleTotal = v.nonIdleTotal
	cpu_state[k].prevTotal = v.total
    end

    return ret
end

function update_sysmonitor(widget)
    ram_str = update_activeram()
    cpu_str = update_activecpu()
    batt_str = update_battery()
    widget:set_markup(cpu_str .. ram_str .. batt_str)
end

update_sysmonitor(sysmonitor_widget)

sysmonitor_timer = timer({ timeout = 1 })
sysmonitor_timer:connect_signal("timeout", function () update_sysmonitor(sysmonitor_widget) end)
sysmonitor_timer:start()
