-- Network Widget without Vicious dependency
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local network_widget = {}

-- Create Network widget
local network_text = wibox.widget {
  widget = wibox.widget.textbox,
  markup = '<span color="#a4b0be">↓0K ↑0K</span>'
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

-- Network interfaces to monitor (based on your system)
local interfaces = {"enp1s0", "wlp0s20f3"}

-- Variables to store previous values for calculating speed
local prev_rx = {}
local prev_tx = {}
local prev_time = os.time()

-- Function to read network stats
local function get_network_stats()
  local stats = {}
  
  for _, interface in ipairs(interfaces) do
    local rx_file = io.open("/sys/class/net/" .. interface .. "/statistics/rx_bytes", "r")
    local tx_file = io.open("/sys/class/net/" .. interface .. "/statistics/tx_bytes", "r")
    
    if rx_file and tx_file then
      local rx_bytes = tonumber(rx_file:read("*all")) or 0
      local tx_bytes = tonumber(tx_file:read("*all")) or 0
      rx_file:close()
      tx_file:close()
      
      stats[interface] = {rx = rx_bytes, tx = tx_bytes}
    end
  end
  
  return stats
end

-- Function to format bytes to human readable
local function format_speed(bytes_per_sec)
  if bytes_per_sec > 1024 * 1024 then
    return string.format("%.1fM", bytes_per_sec / (1024 * 1024))
  elseif bytes_per_sec > 1024 then
    return string.format("%.1fK", bytes_per_sec / 1024)
  else
    return string.format("%dB", bytes_per_sec)
  end
end

-- Function to update network widget
local function update_network()
  local current_stats = get_network_stats()
  local current_time = os.time()
  local time_diff = current_time - prev_time
  
  if time_diff <= 0 then
    return
  end
  
  local total_down_speed = 0
  local total_up_speed = 0
  
  for interface, stats in pairs(current_stats) do
    if prev_rx[interface] and prev_tx[interface] then
      local rx_diff = stats.rx - prev_rx[interface]
      local tx_diff = stats.tx - prev_tx[interface]
      
      local down_speed = rx_diff / time_diff
      local up_speed = tx_diff / time_diff
      
      total_down_speed = total_down_speed + down_speed
      total_up_speed = total_up_speed + up_speed
    end
    
    prev_rx[interface] = stats.rx
    prev_tx[interface] = stats.tx
  end
  
  prev_time = current_time
  
  -- Format speeds
  local down_str = format_speed(total_down_speed)
  local up_str = format_speed(total_up_speed)
  
  -- Color coding based on activity
  local total_speed = total_down_speed + total_up_speed
  local color
  if total_speed > 1024 * 1024 then -- > 1MB/s
    color = "#48dbfb"
  elseif total_speed > 100 * 1024 then -- > 100KB/s
    color = "#feca57"
  else
    color = "#a4b0be"
  end
  
  network_text.markup = string.format('<span color="%s">↓%s ↑%s</span>', color, down_str, up_str)
end

-- Initialize previous values
local initial_stats = get_network_stats()
for interface, stats in pairs(initial_stats) do
  prev_rx[interface] = stats.rx
  prev_tx[interface] = stats.tx
end

-- Create timer to update network stats every 3 seconds
local network_timer = gears.timer {
  timeout = 3,
  call_now = true,
  autostart = true,
  callback = update_network
}

return network_widget
