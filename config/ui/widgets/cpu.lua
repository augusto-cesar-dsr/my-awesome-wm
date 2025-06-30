-- CPU Widget
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local cpu_widget = {}

-- Create CPU widget
local cpu_text = wibox.widget {
  text = "CPU: 0%",
  widget = wibox.widget.textbox
}

local cpu_icon = wibox.widget {
  text = "󰻠 ",
  widget = wibox.widget.textbox
}

cpu_widget.widget = wibox.widget {
  cpu_icon,
  cpu_text,
  layout = wibox.layout.fixed.horizontal,
}

-- Update function
local function update_cpu()
  awful.spawn.easy_async_with_shell(
    "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'",
    function(stdout)
      local cpu_usage = math.floor(tonumber(stdout) or 0)
      
      -- Color coding
      if cpu_usage > 80 then
        cpu_text.markup = string.format('<span color="#ff6b6b">CPU: %d%%</span>', cpu_usage)
      elseif cpu_usage > 60 then
        cpu_text.markup = string.format('<span color="#feca57">CPU: %d%%</span>', cpu_usage)
      else
        cpu_text.markup = string.format('<span color="#48dbfb">CPU: %d%%</span>', cpu_usage)
      end
    end
  )
end

-- Update timer
local cpu_timer = gears.timer {
  timeout = 3,
  call_now = true,
  autostart = true,
  callback = update_cpu
}

return cpu_widget
