-- Global key bindings
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Import scratchpads
local scratchpads = require("config.scratchpads")

-- Garantir que modkey está definido
modkey = modkey or "Mod4"

-- Caminho dinâmico para os scripts
local scripts_path = awesome_config_path .. "/bin/"

-- Global keys
local globalkeys = gears.table.join(
-- Awesome controls
  awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

  -- Tag navigation
  awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

  -- Client focus
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "client" }),

  -- Screen focus
  awful.key({ modkey, "Control" }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),

  -- Client management
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = "go back", group = "client" }),

  -- Menu
  awful.key({ modkey }, "w", function()
    local menu = require("config.ui.menu")
    if menu.mainmenu then
      menu.mainmenu:show()
    end
  end, { description = "show main menu", group = "awesome" }),

  -- Applications (mantendo os shortcuts originais)
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "b", function()
    awful.spawn(browser)
  end, { description = "open browser", group = "launcher" }),
  awful.key({ modkey }, "e", function()
    awful.spawn(file_manager)
  end, { description = "open file manager", group = "launcher" }),

  -- Rofi launcher
  awful.key({ modkey }, "d", function()
    awful.spawn("rofi -show drun")
  end, { description = "run rofi application launcher", group = "launcher" }),

  -- My Management shortcuts
  -- Audio controls
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
  end, { description = "increase sound", group = "my managements" }),
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
  end, { description = "decrease sound", group = "my managements" }),
  awful.key({}, "XF86AudioMute", function()
    awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
  end, { description = "mute sound", group = "my managements" }),

  -- Brightness controls
  awful.key({}, "XF86MonBrightnessUp", function()
    awful.spawn("bash " .. scripts_path .. "brightness_control up")
  end, { description = "increase brightness", group = "my managements" }),
  awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn("bash " .. scripts_path .. "brightness_control down")
  end, { description = "decrease brightness", group = "my managements" }),

  -- Display options
  awful.key({ "Control" }, "1", function()
    awful.spawn("bash " .. scripts_path .. "rofi_change_display")
  end, { description = "display options", group = "my managements" }),

  -- Power options
  awful.key({ modkey, "Control" }, "l", function()
    awful.spawn("bash " .. scripts_path .. "logout")
  end, { description = "power options", group = "my managements" }),

  -- Audio manager (mudando de Super+b para Super+Shift+a para evitar conflito)
  awful.key({ modkey, "Shift" }, "a", function()
    awful.spawn("bash " .. scripts_path .. "audio_manager")
  end, { description = "audio manager", group = "my managements" }),

  -- Backup configuration
  awful.key({ modkey, "Shift" }, "b", function()
    awful.spawn("bash " .. scripts_path .. "backup_config")
  end, { description = "backup awesome config", group = "my managements" }),

  -- Resource monitor status
  awful.key({ modkey, "Shift" }, "r", function()
    awful.spawn(terminal .. " -e bash " .. scripts_path .. "resource_monitor status")
  end, { description = "show resource monitor status", group = "my managements" }),

  -- Scratchpads
  awful.key({}, "F12", function()
    scratchpads.terminal:toggle()
  end, { description = "toggle terminal scratchpad", group = "scratchpads" }),

  awful.key({ modkey }, "F12", function()
    scratchpads.calculator:toggle()
  end, { description = "toggle calculator scratchpad", group = "scratchpads" }),

  awful.key({ modkey, "Shift" }, "F12", function()
    scratchpads.notes:toggle()
  end, { description = "toggle notes scratchpad (nvim)", group = "scratchpads" }),

  -- Layout controls
  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),

  -- Client restore
  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),

  -- Prompts
  awful.key({ modkey }, "r", function()
    awful.screen.focused().mypromptbox:run()
  end, { description = "run prompt", group = "launcher" }),
  awful.key({ modkey }, "x", function()
    awful.prompt.run({
      prompt = "Run Lua code: ",
      textbox = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. "/history_eval",
    })
  end, { description = "lua execute prompt", group = "awesome" }),

  -- Menubar
  awful.key({ modkey }, "p", function()
    local menubar = require("menubar")
    menubar.show()
  end, { description = "show the menubar", group = "launcher" })
)

-- Bind all key numbers to tags
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display
    awful.key({ modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

-- Set global keys
root.keys(globalkeys)
