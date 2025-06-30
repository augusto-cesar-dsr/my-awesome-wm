-- Memory Widget using Vicious
local wibox = require("wibox")
local vicious = require("vicious")

local memory_widget = {}

-- Create Memory widget
local memory_text = wibox.widget {
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

-- Vicious Memory widget with color coding
vicious.register(memory_text, vicious.widgets.mem, 
  function(widget, args)
    local memory_usage = args[1] -- Percentage used
    
    -- Color coding
    if memory_usage > 80 then
      return string.format('<span color="#ff6b6b">RAM: %d%%</span>', memory_usage)
    elseif memory_usage > 60 then
      return string.format('<span color="#feca57">RAM: %d%%</span>', memory_usage)
    else
      return string.format('<span color="#48dbfb">RAM: %d%%</span>', memory_usage)
    end
  end, 5) -- Update every 5 seconds

return memory_widget
