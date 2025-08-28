-- Volume Widget
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local volume_widget = {}

-- Create Volume widget
local volume_text = wibox.widget {
  text = "VOL: 0%",
  widget = wibox.widget.textbox
}

local volume_icon = wibox.widget {
  text = "󰕾 ",
  widget = wibox.widget.textbox
}

volume_widget.widget = wibox.widget {
  volume_icon,
  volume_text,
  layout = wibox.layout.fixed.horizontal,
}

-- Update function
local function update_volume()
  awful.spawn.easy_async_with_shell(
    "pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+%' | head -1 | tr -d '%'",
    function(volume_stdout)
      awful.spawn.easy_async_with_shell(
        "pactl get-sink-mute @DEFAULT_SINK@",
        function(mute_stdout)
          local volume = tonumber(volume_stdout) or 0
          local is_muted = mute_stdout:match("yes") ~= nil
          
          if is_muted then
            volume_icon.text = "󰖁 "
            volume_text.markup = '<span color="#ff6b6b">MUTE</span>'
          else
            -- Update icon based on volume level
            if volume == 0 then
              volume_icon.text = "󰖁 "
            elseif volume < 30 then
              volume_icon.text = "󰕿 "
            elseif volume < 70 then
              volume_icon.text = "󰖀 "
            else
              volume_icon.text = "󰕾 "
            end
            
            -- Color coding
            if volume > 150 then
              volume_text.markup = string.format('<span color="#ff6b6b">%d%%</span>', volume)
            elseif volume > 100 then
              volume_text.markup = string.format('<span color="#ffa500">%d%%</span>', volume)
            elseif volume > 80 then
              volume_text.markup = string.format('<span color="#fcca57">%d%%</span>', volume)
            else
              volume_text.markup = string.format('<span color="#48dbfb">%d%%</span>', volume)
            end
          end
        end
      )
    end
  )
end

-- Update timer
local volume_timer = gears.timer {
  timeout = 2,
  call_now = true,
  autostart = true,
  callback = update_volume
}

-- Mouse controls
volume_widget.widget:buttons(gears.table.join(
  awful.button({}, 1, function() -- Left click: toggle mute
    awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    gears.timer.start_new(0.1, function()
      update_volume()
      return false
    end)
  end),
  awful.button({}, 4, function() -- Scroll up: volume up
    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
    gears.timer.start_new(0.1, function()
      update_volume()
      return false
    end)
  end),
  awful.button({}, 5, function() -- Scroll down: volume down
    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
    gears.timer.start_new(0.1, function()
      update_volume()
      return false
    end)
  end)
))

return volume_widget
