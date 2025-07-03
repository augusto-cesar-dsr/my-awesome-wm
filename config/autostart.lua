-- Autostart applications
local awful = require("awful")

-- Simple run once function
local function run_once(cmd, process_name)
  local findme = process_name or cmd:match("^[^%s]+")
  awful.spawn.with_shell(string.format("pgrep -u $USER -f %s > /dev/null || (%s)", findme, cmd))
end

-- System applications
awful.spawn.with_shell("sleep 1 && " .. os.getenv("HOME") .. "/.config/awesome/bin/set_default_wallpaper")
awful.spawn.with_shell("sleep 2 && " .. os.getenv("HOME") .. "/.config/awesome/bin/picom_manager start")
run_once(os.getenv("HOME") .. "/.config/awesome/bin/keep_picom_alive", "keep_picom_alive")

-- System tray applets (with delay for tray readiness)
awful.spawn.easy_async_with_shell("sleep 5", function()
  run_once("nm-applet", "nm-applet")
  awful.spawn.easy_async_with_shell("sleep 1", function()
    run_once("blueman-applet", "blueman-applet")
    awful.spawn.easy_async_with_shell("sleep 1", function()
      run_once("pasystray", "pasystray")
    end)
  end)
end)

-- Main applications (delayed start)
awful.spawn.easy_async_with_shell("sleep 3", function()
  awful.spawn.with_shell("pgrep -f nvim > /dev/null || " .. terminal .. " -e nvim")
end)

awful.spawn.easy_async_with_shell("sleep 6", function()
  awful.spawn.with_shell("pgrep -f slack > /dev/null || slack")
end)

awful.spawn.easy_async_with_shell("sleep 10", function()
  awful.spawn.with_shell("pgrep -f 'google-chrome.*--type=browser' > /dev/null || google-chrome-stable --profile-directory='Profile 1'")
end)
