-- Autostart applications
local awful = require("awful")

-- Simple run once function with better error handling
local function run_once(cmd, process_name, delay)
  local findme = process_name or cmd:match("^[^%s]+")
  local delay_cmd = delay and ("sleep " .. delay .. " && ") or ""
  
  awful.spawn.with_shell(string.format(
    "%spgrep -u $USER -f %s > /dev/null || (%s 2>/dev/null &)", 
    delay_cmd, findme, cmd
  ))
end

-- Wait for system to be ready
local function wait_for_system_ready(callback, max_attempts)
  max_attempts = max_attempts or 10
  local attempts = 0
  
  local function check_ready()
    attempts = attempts + 1
    awful.spawn.easy_async_with_shell("pgrep -f awesome && echo 'ready'", function(stdout)
      if stdout:match("ready") then
        callback()
      elseif attempts < max_attempts then
        awful.spawn.easy_async_with_shell("sleep 1", check_ready)
      end
    end)
  end
  
  check_ready()
end

-- System applications (immediate)
awful.spawn.with_shell("sleep 1 && " .. os.getenv("HOME") .. "/.config/awesome/bin/set_default_wallpaper")
awful.spawn.with_shell("sleep 2 && " .. os.getenv("HOME") .. "/.config/awesome/bin/picom_manager start")
run_once(os.getenv("HOME") .. "/.config/awesome/bin/keep_picom_alive", "keep_picom_alive")

-- System tray applets (wait for system to be ready)
wait_for_system_ready(function()
  -- Wait additional time for tray to be fully ready
  awful.spawn.easy_async_with_shell("sleep 5", function()
    run_once("nm-applet", "nm-applet")
    run_once("blueman-applet", "blueman-applet", 2)
    run_once("pasystray", "pasystray", 4)
    run_once("solaar", "solaar", 6)
  end)
end)

-- Main applications (delayed start)
awful.spawn.easy_async_with_shell("sleep 3", function()
  awful.spawn.with_shell("pgrep -f nvim > /dev/null || " .. terminal .. " -e nvim 2>/dev/null &")
end)

awful.spawn.easy_async_with_shell("sleep 6", function()
  awful.spawn.with_shell("pgrep -f slack > /dev/null || slack 2>/dev/null &")
end)

awful.spawn.easy_async_with_shell("sleep 10", function()
  awful.spawn.with_shell("pgrep -f 'google-chrome.*--type=browser' > /dev/null || google-chrome-stable --profile-directory='Profile 1' 2>/dev/null &")
end)
