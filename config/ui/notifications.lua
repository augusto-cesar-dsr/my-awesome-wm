-- Notification configuration
local naughty = require("naughty")

-- Notification settings
naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = 8
naughty.config.defaults.gap = 1

-- Presets
naughty.config.presets.low.timeout = 2
naughty.config.presets.critical.timeout = 0

-- Custom notification for workspace changes
local function notify_tag_change(tag)
  local tag_names = {
    ["󰨞"] = "Editor",
    ["󰒱"] = "Chat",
    ["󰖟"] = "Browser",
    ["󰉋"] = "Files",
    ["󰝚"] = "Music",
    ["󰍹"] = "Terminal",
    ["󰊻"] = "Documents",
    ["󰟴"] = "Settings",
    ["󰐃"] = "Misc",
  }

  local tag_name = tag_names[tag.name] or tag.name
  naughty.notify({
    title = "Workspace",
    text = tag_name,
    timeout = 1,
    position = "bottom_middle",
  })
end

-- Connect to tag view signal
tag.connect_signal("property::selected", function(t)
  if t.selected then
    notify_tag_change(t)
  end
end)
