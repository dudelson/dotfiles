local awful = require('awful')

local config = {}

config.log = function(msg)
    io.stderr:write(msg .. '\n')
end

config.trim = function(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

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
  if not args and args.exec then return end
  args.spawn_callback = args.spawn_callback or function(c) end
  -- args.tag = awful.tag.find_by_name(args.tag.screen, args.tag.name)

  -- Create move callback
  local f
  f = function(c)
    if c.class == args.class then
      config.log(string.format('moving %d(%s) to tag "%s" on screen %d', c.pid, c.name, args.tag.name, args.tag.screen.index))
      c:move_to_tag(args.tag)
      client.disconnect_signal("manage", f)
      args.spawn_callback(c)
    end
  end
  client.connect_signal("manage", f)

  -- Now check if not already running
  local findme = args.proc
  if findme == nil then
    findme = args.exec
    local firstspace = findme:find(" ")
    if firstspace then
      findme = findme:sub(0, firstspace-1)
    end
  end

  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, args.exec))
end

return config
