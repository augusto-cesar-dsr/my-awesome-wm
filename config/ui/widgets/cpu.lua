-- CPU Widget using Vicious
local wibox = require("wibox")
local vicious = require("vicious")

local cpu_widget = {}

-- Create CPU widget
local cpu_text = wibox.widget {
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

-- Vicious CPU widget with color coding
vicious.register(cpu_text, vicious.widgets.cpu, 
  function(widget, args)
    local cpu_usage = args[1]
    
    -- Color coding
    if cpu_usage > 80 then
      return string.format('<span color="#ff6b6b">CPU: %d%%</span>', cpu_usage)
    elseif cpu_usage > 60 then
      return string.format('<span color="#feca57">CPU: %d%%</span>', cpu_usage)
    else
      return string.format('<span color="#48dbfb">CPU: %d%%</span>', cpu_usage)
    end
  end, 3) -- Update every 3 seconds

return cpu_widget
