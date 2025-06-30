-- Network Widget using Vicious
local wibox = require("wibox")
local vicious = require("vicious")

local network_widget = {}

-- Create Network widget
local network_text = wibox.widget {
  widget = wibox.widget.textbox
}

local network_icon = wibox.widget {
  text = "󰖩 ",
  widget = wibox.widget.textbox
}

network_widget.widget = wibox.widget {
  network_icon,
  network_text,
  layout = wibox.layout.fixed.horizontal,
}

-- Vicious Network widget with color coding
vicious.register(network_text, vicious.widgets.net, 
  function(widget, args)
    -- args["{wlan0 down_kb}"] and args["{wlan0 up_kb}"] for wireless
    -- args["{eth0 down_kb}"] and args["{eth0 up_kb}"] for ethernet
    -- We'll try to detect the active interface
    local down_kb = args["{wlan0 down_kb}"] or args["{eth0 down_kb}"] or args["{enp0s3 down_kb}"] or 0
    local up_kb = args["{wlan0 up_kb}"] or args["{eth0 up_kb}"] or args["{enp0s3 up_kb}"] or 0
    
    -- Format speeds
    local down_str = down_kb > 1024 and string.format("%.1fM", down_kb/1024) or string.format("%dK", down_kb)
    local up_str = up_kb > 1024 and string.format("%.1fM", up_kb/1024) or string.format("%dK", up_kb)
    
    -- Color coding based on activity
    local total_speed = down_kb + up_kb
    if total_speed > 1024 then -- > 1MB/s
      return string.format('<span color="#48dbfb">↓%s ↑%s</span>', down_str, up_str)
    elseif total_speed > 100 then -- > 100KB/s
      return string.format('<span color="#feca57">↓%s ↑%s</span>', down_str, up_str)
    else
      return string.format('<span color="#a4b0be">↓%s ↑%s</span>', down_str, up_str)
    end
  end, 3) -- Update every 3 seconds

return network_widget
