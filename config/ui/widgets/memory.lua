-- Memory Widget
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local memory_widget = {}

-- Create Memory widget
local memory_text = wibox.widget {
  text = "RAM: 0%",
  widget = wibox.widget.textbox
}

local memory_icon = wibox.widget {
  text = "󰍛 ",
  widget = wibox.widget.textbox
}

memory_widget.widget = wibox.widget {
  memory_icon,
  memory_text,
  layout = wibox.layout.fixed.horizontal,
}

-- Update function
local function update_memory()
  awful.spawn.easy_async_with_shell(
    "free | grep Mem | awk '{printf \"%.0f\", $3/$2 * 100.0}'",
    function(stdout)
      local memory_usage = tonumber(stdout) or 0
      
      -- Color coding
      if memory_usage > 80 then
        memory_text.markup = string.format('<span color="#ff6b6b">RAM: %d%%</span>', memory_usage)
      elseif memory_usage > 60 then
        memory_text.markup = string.format('<span color="#feca57">RAM: %d%%</span>', memory_usage)
      else
        memory_text.markup = string.format('<span color="#48dbfb">RAM: %d%%</span>', memory_usage)
      end
    end
  )
end

-- Update timer
local memory_timer = gears.timer {
  timeout = 5,
  call_now = true,
  autostart = true,
  callback = update_memory
}

return memory_widget
