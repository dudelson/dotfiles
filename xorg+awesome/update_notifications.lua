---- update_notifications.lua: provides a awesome wm widget which periodically 
----                           checks for arch linux package updates
---- 
---- runs `checkupdates` every <CHECK_INTERVAL> seconds and displays the number
---- of available package updates in the widget. If more than 10 updates are
---- available, the number is colored <TEN_PLUS_UPDATES_COLOR>, and if more than
---- 20 updates are available, the number is colored <TWENTY_PLUS_UPDATES_COLOR>.
---- By default these colors are orange and red, respectively. Additionally,
---- when checking for updates, this script will read the <WATCHED_PACKAGES_FILE>.
---- If any package listed in the <WATCHED_PACKAGES_FILE> is available to be
---- updated, the output of the widget will be <WATCHED_PACKAGE_AVAILABLE_COLOR>.
----
---- Mousing over the widget will display a list of all the packages available
---- to be updated, exactly as if you had run `checkupdates`. By default,
---- watched packages in this list are colored <WATCHED_PACKAGE_AVAILABLE_COLOR>.

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

local tooltip
local tooltip_markup = '<span color="#ff00ff">Hi!</span>'


local function checkupdates()
    tooltip_markup = ''

    updates = io.popen('checkupdates')
    watched_packages = io.open(WATCHED_PACKAGES_FILE)

    nUpdates = 0
    wp_found = false
    for line in updates:lines() do
	is_wp = false
	for wp in watched_packages:lines() do
	    if not (string.find(wp, "^%s*#.+$") or string.find(wp, "^%s*$")) then 
		if wp == line then 
		    -- set this package to be a different color in the tooltip
		    is_wp = true
		    tooltip_markup = tooltip_markup .. ' <span color="#' .. WATCHED_PACKAGE_AVAILABLE_COLOR .. '">' .. wp .. '</span> \n'
		    wp_found = true
		    break
		end
	    end
	end
	if not is_wp then
	    tooltip_markup = tooltip_markup .. ' ' .. line .. ' \n'
	end
	watched_packages:seek("set")
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

    tooltip_markup = tooltip_markup:sub(0, tooltip_markup:len()-1)
    update_notifications.widget:set_markup(fmt)
end


function update_notifications.init()
    tooltip = awful.tooltip({})

    function tooltip:update()
	-- change font desc to "monospace" if the vertical spacing is bothering you
	tooltip:set_markup('<span font_desc="source code pro 9">' .. tooltip_markup .. '</span>') 
    end

    -- don't wait for one interval to check for updates when we log in
    checkupdates()

    -- add tooltip after checkupdates() has constructed the correct tooltip markup
    --tooltip_markup = '<span color="#ff00ff">one line</span>\n<span color="#ffff00">twolines</span>'
    tooltip.update()
    tooltip:add_to_object(update_notifications.widget)
    update_notifications.widget:connect_signal("mouse::enter", tooltip.update)

    -- add timer
    update_notifications.timer = timer({ timeout = CHECK_INTERVAL }) -- run once every 10 minutes
    update_notifications.timer:connect_signal("timeout", checkupdates)
    update_notifications.timer:start()
end


return update_notifications
