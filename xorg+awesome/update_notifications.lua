local awful = require("awful")
local wibox = require("wibox")

-------------------------- CONFIGURATION -------------------------- 
local WATCHED_PACKAGE_AVAILABLE_COLOR = "16d4de"
local TWENTY_PLUS_UPDATES_COLOR = "ff0000"
local TEN_PLUS_UPDATES_COLOR = "ff7300"

local WATCHED_PACKAGES_FILE = "/home/david/.watched_packages"

-- interval at which we check for new updates (in seconds)
local CHECK_INTERVAL = 600

------------------------------------------------------------------- 
local update_notifications = {}

update_notifications.widget = wibox.widget.textbox()
update_notifications.widget:set_align("right")
update_notifications.widget:set_font("source code pro 9")

function checkupdates()
    updates = io.popen('checkupdates')
    watched_packages = io.open(WATCHED_PACKAGES_FILE)

    nUpdates = 0
    wp_found = false
    for line in updates:lines() do
	if not wp_found then
	    for wp in watched_packages:lines() do
		if not (string.find(wp, "^%s*#.+$") or string.find(wp, "^%s*$")) then 
		    if wp == line then 
			wp_found = true
			break
		    end
		end
	    end
	    watched_packages:seek("set")
	end
	nUpdates = nUpdates+1
    end

    if wp_found then
	fmt = '<span color="#' .. WATCHED_PACKAGE_AVAILABLE_COLOR .. '">' .. nUpdates .. '</span> | '
    elseif nUpdates >= 20 then
	fmt = '<span color="#' .. TWENTY_PLUS_UPDATES_COLOR .. '">' .. nUpdates .. '</span> | '
    elseif nUpdates >= 10 then
	fmt = '<span color="#' .. TEN_PLUS_UPDATES_COLOR .. '">' .. nUpdates .. '</span> | '
    elseif nUpdates == 0 then
	fmt = ''
    else
	fmt = nUpdates .. ' | '
    end

    date = os.date("%a %b %d %H:%M:%S")
    awesome_log = io.open(os.getenv("AWESOME_LOG_FILE"), 'a')
    awesome_log:write('[' .. date .. '] update_notifications: the widget markup code is "' .. fmt .. '"\n')
    awesome_log:flush()
    awesome_log:close()

    update_notifications.widget:set_markup(fmt)
end

-- don't wait for one interval to check for updates when we log in
checkupdates()

update_notifications.timer = timer({ timeout = CHECK_INTERVAL }) -- run once every 10 minutes
update_notifications.timer:connect_signal("timeout", checkupdates)
update_notifications.timer:start()

return update_notifications
