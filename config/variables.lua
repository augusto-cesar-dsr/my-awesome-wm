-- Global variables and settings
local awful = require("awful")

-- Dynamic paths
awesome_config_path = os.getenv("HOME") .. "/.config/awesome"

-- Applications
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
browser = "google-chrome-stable --profile-directory='Profile 1'"
file_manager = "nautilus"

-- Modkey (Super/Windows key)
modkey = "Mod4"

-- Layouts
awful.layout.layouts = {
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.max,
  awful.layout.suit.tile,
  awful.layout.suit.floating,
}

-- Screen setup with tags
awful.screen.connect_for_each_screen(function(s)
  local tag_icons = {
    "󰨞", -- Editor
    "󰒱", -- Chat  
    "󰖟", -- Browser
    "󰉋", -- Files
    "󰝚", -- Music
    "󰍹", -- Terminal
    "󰊻", -- Documents
    "󰟴", -- Settings
    "󰐃", -- Misc
  }
  
  -- Create tags with icons
  awful.tag(tag_icons, s, awful.layout.layouts[1])
end)
