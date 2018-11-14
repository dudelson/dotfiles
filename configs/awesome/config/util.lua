local awful = require('awful')

local config = {}

config.run_once = function(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    local findme = cmd
    local firstspace = cmd:find(" ")
    if firstspace then
      findme = cmd:sub(0, firstspace-1)
    end
    awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
  end
end

config.spawn_once = function(args)
  if not args and args.command then return end
  args.callback = args.callback or function() end
  args.tag = args.tag or awful.screen.focused().tags[1]

  -- Create move callback
  local f
  f = function(c)
    if c.class == args.class then
      c:move_to_tag(args.tag)
      client.disconnect_signal("manage", f)
      args.callback(c)
    end
  end
  client.connect_signal("manage", f)

  -- Now check if not already running
  local findme = args.proc
  if findme == nil then
    findme = args.command
    local firstspace = findme:find(" ")
    if firstspace then
      findme = findme:sub(0, firstspace-1)
    end
  end

  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, args.command))
end

return config
