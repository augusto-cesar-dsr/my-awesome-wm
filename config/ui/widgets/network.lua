-- Network Widget
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local network_widget = {}

-- Create Network widget
local network_text = wibox.widget {
  text = "NET: --",
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

-- Variables to store previous values
local prev_rx = 0
local prev_tx = 0

-- Update function
local function update_network()
  awful.spawn.easy_async_with_shell(
    "cat /proc/net/dev | grep -E '(eth|wlan|enp|wlp)' | head -1 | awk '{print $2, $10}'",
    function(stdout)
      if stdout and stdout ~= "" then
        local rx, tx = stdout:match("(%d+)%s+(%d+)")
        rx, tx = tonumber(rx) or 0, tonumber(tx) or 0
        
        if prev_rx > 0 and prev_tx > 0 then
          -- Calculate speed (bytes per second, converted to KB/s)
          local rx_speed = math.floor((rx - prev_rx) / 1024 / 3) -- 3 second interval
          local tx_speed = math.floor((tx - prev_tx) / 1024 / 3)
          
          -- Format speeds
          local rx_str = rx_speed > 1024 and string.format("%.1fM", rx_speed/1024) or string.format("%dK", rx_speed)
          local tx_str = tx_speed > 1024 and string.format("%.1fM", tx_speed/1024) or string.format("%dK", tx_speed)
          
          -- Color coding based on activity
          local total_speed = rx_speed + tx_speed
          if total_speed > 1024 then -- > 1MB/s
            network_text.markup = string.format('<span color="#48dbfb">↓%s ↑%s</span>', rx_str, tx_str)
          elseif total_speed > 100 then -- > 100KB/s
            network_text.markup = string.format('<span color="#feca57">↓%s ↑%s</span>', rx_str, tx_str)
          else
            network_text.markup = string.format('<span color="#a4b0be">↓%s ↑%s</span>', rx_str, tx_str)
          end
        else
          network_text.markup = '<span color="#a4b0be">NET: --</span>'
        end
        
        prev_rx, prev_tx = rx, tx
      else
        network_text.markup = '<span color="#ff6b6b">NET: OFF</span>'
      end
    end
  )
end

-- Update timer
local network_timer = gears.timer {
  timeout = 3,
  call_now = true,
  autostart = true,
  callback = update_network
}

return network_widget
