-- Dynamic Theme Indicator Widget for AwesomeWM
-- Shows current theme status and provides quick controls

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local theme_indicator = {}

-- Get dynamic theme module
local dynamic_theme = require("config.dynamic-theme")

-- Create the widget
local theme_widget = wibox.widget {
    {
        {
            id = "icon",
            text = "🎨",
            font = "JetBrainsMonoNL Nerd Font Medium 11",
            widget = wibox.widget.textbox
        },
        {
            id = "status",
            text = "",
            font = "JetBrainsMonoNL Nerd Font Medium 8",
            widget = wibox.widget.textbox
        },
        spacing = 2,
        layout = wibox.layout.fixed.horizontal
    },
    fg = beautiful.fg_normal or "#ffffff",
    widget = wibox.container.background
}

-- Update widget display
local function update_widget()
    local icon_widget = theme_widget:get_children_by_id("icon")[1]
    local status_widget = theme_widget:get_children_by_id("status")[1]
    
    if dynamic_theme.is_enabled() then
        icon_widget.text = "🎨"
        status_widget.text = "ON"
        theme_widget.fg = "#48dbfb"  -- Active color
    else
        icon_widget.text = "🎨"
        status_widget.text = "OFF"
        theme_widget.fg = "#a4b0be"  -- Inactive color
    end
end

-- Mouse controls
theme_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then      -- Left click: toggle
        dynamic_theme.toggle()
        update_widget()
    elseif button == 2 then  -- Middle click: regenerate
        dynamic_theme.regenerate()
    elseif button == 3 then  -- Right click: show info
        dynamic_theme.show_info()
    end
end)

-- Tooltip
local theme_tooltip = awful.tooltip({
    objects = { theme_widget },
    text = "🎨 Dynamic Theme\n" ..
           "Left click: Toggle on/off\n" ..
           "Middle click: Regenerate theme\n" ..
           "Right click: Show info\n\n" ..
           "Keybindings:\n" ..
           "Alt+t: Toggle\n" ..
           "Alt+Shift+t: Regenerate\n" ..
           "Alt+Ctrl+t: Show info"
})

-- Update widget periodically
gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = update_widget
}

-- Export
theme_indicator.widget = theme_widget
return theme_indicator
