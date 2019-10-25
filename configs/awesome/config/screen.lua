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
    util.log('IN SWITCH.GO')
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

    util.log('one')
    -- now that tags have been setup, we can move each window to its specified
    -- screen and tag
    for _, c in ipairs(client.get()) do
      local designated_tag = designated_clients_to_tags[c.class]
      if designated_tag then
        util.log(string.format('moving %d (%s) to %s', c.pid, c.name, designated_tag.name))
        tt = designated_tag
        for _,s in ipairs({ 'name', 'selected', 'activated', 'index', 'screen' }) do
            util.log(string.format('\t%s: %s', s, tt[s]))
        end
        
        c:move_to_tag(designated_tag)
      else
        util.log(string.format('moving %d (%s) to %s (default)', c.pid, c.name, conf.default_tag.name))
        c:move_to_tag(conf.default_tag.name)
      end
    end

    util.log('two')

    -- remove old tags
    for _,taglist in ipairs(oldtags) do
      for _,tag in ipairs(taglist) do
        tag:delete()
      end
    end
  end

  awful.spawn.easy_async_with_shell('autorandr --current',
    function(stdout, stderr, reason, retcode)
      util.log('autorandr stdout: ' .. util.trim(stdout))
      util.log('autorandr stderr: ' .. util.trim(stdout))
      util.log('autorandr exit code: ' .. retcode)
      local profile_name = util.trim(stdout)
      local conf = context.screen_config[profile_name]

      -- Since screen.switch is called every time a monitor is connected or
      -- disconnected, this function will be called multiple times in the
      -- course of a single docking/undocking, which is redundant. However,
      -- autorandr will not detect the new profile until the last such call,
      -- when the final monitor change takes effect and the monitor config
      -- completely matches the profile. All calls before the last one will
      -- result in autorandr returning an empty profile name and (curiously)
      -- a retcode of 0. Since we only want to reconfigure the awesome
      -- wm screens once we have a complete profile, we test here whether we
      -- actually have a profile match, thus preventing redundant (and useless)
      -- calls to go().
      if conf ~= nil then
          go(conf)
      end
    end)
end

return config
