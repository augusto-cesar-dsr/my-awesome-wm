-- Temperature Widget using Vicious
local wibox = require("wibox")
local vicious = require("vicious")

local temperature_widget = {}

-- Create Temperature widget
local temp_text = wibox.widget {
  widget = wibox.widget.textbox
}

local temp_icon = wibox.widget {
  text = "󰔏 ",
  widget = wibox.widget.textbox
}

temperature_widget.widget = wibox.widget {
  temp_icon,
  temp_text,
  layout = wibox.layout.fixed.horizontal,
}

-- Vicious Temperature widget with color coding
vicious.register(temp_text, vicious.widgets.thermal, 
  function(widget, args)
    local temp = args[1]
    
    if temp and temp > 0 then
      -- Color coding based on temperature
      if temp > 75 then
        return string.format('<span color="#ff6b6b">%d°C</span>', temp)
      elseif temp > 60 then
        return string.format('<span color="#feca57">%d°C</span>', temp)
      else
        return string.format('<span color="#48dbfb">%d°C</span>', temp)
      end
    else
      return '<span color="#a4b0be">--°C</span>'
    end
  end, 10, "thermal_zone0") -- Update every 10 seconds, thermal zone 0

return temperature_widget
