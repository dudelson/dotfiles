local screen, client = screen, client

local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local naughty = require('naughty')

local config = {}

function config.init(context)
    function config.autorandr_switch(profile_name)
        io.stderr:write('got profile from autorandr: ' .. profile_name)
        config.switch(context.screen_config[profile_name], context)
    end

    awful.spawn.easy_async(
      '/usr/bin/autorandr -c --default undocked',
      function(stdout, stderr, reason, exit_code)
        io.stderr:write('OUTPUT: ' .. stdout .. '\n')
        io.stderr:write('STDERR: ' .. stderr .. '\n')
        io.stderr:write('REASON: ' .. reason .. '\n')
        io.stderr:write('RETCODE: ' .. exit_code .. '\n')

        -- if the config is already loaded, autorandr will not execute the
        -- post hook, so we have to invoke it manually
        if string.match(stderr, 'Config already loaded') then
            awful.spawn.with_shell('~/.config/autorandr/postswitch')
        end
    end)
end

function config.wallpaper(s)
  return beautiful.wallpaper
end

-- function for switching between configurations
-- this is invoked by autorandr via awesome-client
function config.switch(conf, context)
  local designated_clients_to_tags = {}
  for actual_screen in screen do
    -- convoluted way of getting the name of the output associated with this screen
    -- NOTE there may be more than one output
    local output_name = nil
    for k,_ in pairs(actual_screen.outputs) do
      output_name = k
    end
    -- NOTE while it may seem possible that we could try to load
    -- the config for a screen that isn't defined, in practice this shouldn't
    -- be possible, because autorandr will only load a profile if all the screens
    -- match the pre-defined config (otherwise it will fall back to the default
    -- profile).
    local config_screen = conf.screens[output_name]

    -- add tags
    for _,config_tag in ipairs(config_screen.tags) do
      config_tag.screen = actual_screen
      local actual_tag = awful.tag.add(config_tag.name, config_tag)

      if config_tag.designated_for then
        -- used below
        designated_clients_to_tags[config_tag.designated_for['class']] = actual_tag
        -- used by autospawning and designated tag keybindings
        config_tag.designated_for['tag'] = actual_tag
      end

      if conf.default_tag == config_tag then
        conf.default_tag = actual_tag
      end
    end

    -- for convenience
    config_screen.screen = actual_screen
  end

  -- now that tags have been setup, we can move each window to its specified
  -- screen and tag
  for _, c in ipairs(client.get()) do
    local designated_tag = designated_clients_to_tags[c.class]
    if designated_tag then
      c:move_to_tag(designed_tag)
    else
      c:move_to_tag(conf.default_tag)
    end
  end

  context.autostart()
end

return config
