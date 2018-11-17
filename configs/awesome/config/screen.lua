local screen, client = screen, client

local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local naughty = require('naughty')
local util = require('config/util')

local config = {}

function config.init(context)
    config.switch(context)
end

function config.wallpaper(s)
  return beautiful.wallpaper
end

function config.switch(context)
  local function go(conf)
    local designated_clients_to_tags = {}
    local oldtags = {}
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
      oldtags[actual_screen.index] = actual_screen.tags
      for _,config_tag in ipairs(config_screen.tags) do
        config_tag.screen = actual_screen
        local actual_tag = awful.tag.add(config_tag.name, config_tag)

        if config_tag.designated_for then
          -- used below
          designated_clients_to_tags[config_tag.designated_for['class']] = actual_tag
          -- used by autospawning and designated tag keybindings
          config_tag.designated_for['tag'] = actual_tag
        end

        if conf.default_tag.name == config_tag.name then
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
        c:move_to_tag(designated_tag)
      else
        c:move_to_tag(conf.default_tag)
      end
    end

    -- remove old tags
    for _,taglist in ipairs(oldtags) do
      for _,tag in ipairs(taglist) do
        tag:delete()
      end
    end
  end

  awful.spawn.easy_async_with_shell('autorandr --current',
    function(stdout, stderr, reason, retcode)
      local profile_name = util.trim(stdout)
      local conf = context.screen_config[profile_name]
      go(conf)
    end)
end

return config
