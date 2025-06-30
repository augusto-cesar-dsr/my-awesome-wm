-- Battery Widget using Vicious
local wibox = require("wibox")
local vicious = require("vicious")

local battery_widget = {}

-- Create Battery widget
local battery_text = wibox.widget {
  widget = wibox.widget.textbox
}

local battery_icon = wibox.widget {
  text = "󰁹 ",
  widget = wibox.widget.textbox
}

battery_widget.widget = wibox.widget {
  battery_icon,
  battery_text,
  layout = wibox.layout.fixed.horizontal,
}

-- Vicious Battery widget with color coding and icons
vicious.register(battery_text, vicious.widgets.bat, 
  function(widget, args)
    local state = args[1]  -- charging state
    local charge = args[2] -- charge percentage
    
    if charge then
      -- Update icon based on charge level and state
      if state == "+" then -- charging
        battery_icon.text = "󰂄 "
      elseif charge > 80 then
        battery_icon.text = "󰁹 "
      elseif charge > 60 then
        battery_icon.text = "󰂀 "
      elseif charge > 40 then
        battery_icon.text = "󰁾 "
      elseif charge > 20 then
        battery_icon.text = "󰁼 "
      else
        battery_icon.text = "󰁺 "
      end
      
      -- Color coding based on charge level
      if charge < 15 and state ~= "+" then
        return string.format('<span color="#ff6b6b">%d%%</span>', charge)
      elseif charge < 30 and state ~= "+" then
        return string.format('<span color="#feca57">%d%%</span>', charge)
      else
        return string.format('<span color="#48dbfb">%d%%</span>', charge)
      end
    else
      -- No battery detected
      battery_widget.widget.visible = false
      return ""
    end
  end, 30, "BAT0") -- Update every 30 seconds, battery 0

return battery_widget
