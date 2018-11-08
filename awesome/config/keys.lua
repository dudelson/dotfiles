local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")

local config = {}

function config.init(context)
  local modkey = context.keys.modkey
  local altkey = context.keys.altkey

  context.keys.global = gears.table.join(
    -- Movement between tags
    awful.key({ modkey,           }, "c", function () awful.tag.viewprev(awful.screen.focused()) end,
              {description = "view next tag", group = "tag"}),
    awful.key({ modkey,           }, "v", function () awful.tag.viewnext(awful.screen.focused()) end,
              {description = "view previous tag", group = "tag"}),
    awful.key({ modkey,           }, "z", awful.tag.history.restore,
              {description = "jump to last most recent tag", group = "tag"}),
    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(context.vars.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "u",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "i",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "i",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "u",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "i",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "u",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "x", function () awful.spawn('dmenu_run -b') end,
      {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "r",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- toggle systray visibility
    awful.key({ modkey },            "s",
              function()
                awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
              end,
              {description="toggle systray visibility", group="misc"}),
    awful.key({ modkey },            "d",
      function()
        context.state.detailed_widgets = not context.state.detailed_widgets
      end,
      {description="toggle detailed widgets", group="misc"}),
    -- Alt+tab
    awful.key({"Mod1",          }, "Tab",
              function () alttab.switch(1, "Alt_L", "Tab", "ISO_Left_Tab") end,
              {description = "alt-tab", group = "client"}
    ),
    awful.key({"Mod1", "Shift"  }, "Tab",
              function() alttab.switch(-1, "Alt_L", "Tab", "ISO_Left_Tab") end,
              {description = "reverse alt-tab", group = "client"}
    ),
    -- Printscreen
    awful.key({                 }, "Print",
              function()
	            awful.spawn(os.date('maim /tmp/screenshot_%Y-%m-%d_%X.png'), false)
	          end,
              {description = "take a screenshot", group = "misc"}
    ),

    -- Keybindings to focus specific tags
    -- "Mod1" is left alt
    -- jump to terminal tag
    awful.key({ modkey, "Mod1"   }, "j",
              function ()
                -- awful.tag.viewonly(tags[apps.terminal.screen][apps.terminal.tag])
                -- awful.screen.focus(apps.terminal.screen)
                awful.tag.find_by_name(awful.screen.focused(), "term"):view_only()
              end,
              {description = "jump to term tag", group = "tag"}),
    -- jump to browser tag
    awful.key({ modkey, "Mod1"   }, "k",
              function ()
                -- awful.tag.viewonly(tags[apps.browser.screen][apps.browser.tag])
                -- awful.screen.focus(apps.browser.screen)
                awful.tag.find_by_name(awful.screen.focused(), "web"):view_only()
              end,
              {description = "jump to web tag", group = "tag"}),
    -- jump to spacemacs tag
    awful.key({ modkey, "Mod1"   }, "l",
              function ()
                -- local tag = dudelson_config.application_layout.emacs[2]
                -- awful.tag.viewonly(tags[apps.emacs.screen][apps.emacs.tag])
                -- awful.screen.focus(apps.emacs.screen)
                awful.tag.find_by_name(awful.screen.focused(), "spc"):view_only()
              end,
              {description = "jump to spacemacs tag", group = "tag"}),

    -- dynamic tagging
    -- TODO
    awful.key({ modkey, "Shift" }, "a",
              function ()
                awful.prompt.run {
                  prompt = "Run: ",
                  textbox = mouse.screen.mypromptbox.widget,
                  exe_callback = function(input)
                    if not input or #input == 0 then return end
                    -- get first whitespace-delimited token of input
                    firstspace = input:find(' ')
                    if firstspace then tagname = input:sub(0, firstspace-1) else tagname = input end
                    -- create temp tag and open application in it
                    local t = awful.tag.add(tagname, { volitile = true, selected = true })
                    t:view_only()
                    awful.spawn(input, { floating = true, tag = mouse.screen.selected_tag })
                  end
                }
              end),
    awful.key({ modkey, altkey }, "n",
              function ()
                awful.prompt.run {
                  prompt = "Tag name: ",
                  textbox = mouse.screen.mypromptbox.widget,
                  exe_callback = function(input)
                    if not input or #input == 0 then return end
                    local t = awful.tag.add(input, { selected = true })
                    t:view_only()
                  end
                }
              end),
    awful.key({modkey, altkey}, "m", function() lain.util.add_tag() end),
    awful.key({modkey, altkey }, "d",
              function ()
                  local t = awful.screen.focused().selected_tag
                  if not t then return end
                  t:delete()
              end),
    awful.key({ modkey, altkey }, "r",
              function ()
                  awful.prompt.run {
                    prompt       = "New tag name: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = function(new_name)
                      if not new_name or #new_name == 0 then return end
                      local t = awful.screen.focused().selected_tag
                      if t then t.name = new_name end
                    end
                  }
    end),
    awful.key({ modkey, "Shift" }, "l",
      function()
        awful.spawn('loginctl lock-session')
      end),

    -- decimal time toggle dummy function
    awful.key({ modkey, altkey }, "c", function() end)
  )

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    context.keys.global = gears.table.join(context.keys.global,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end
root.keys(context.keys.global)
end

return config
