-- Picom Control Widget for AwesomeWM
-- Provides quick controls for compositor effects

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

local picom_control = {}

-- Configuration
local PICOM_MANAGER_SCRIPT = os.getenv("HOME") .. "/.config/awesome/bin/picom_manager"

-- State tracking
local picom_status = {
    running = false,
    initialized = false
}

-- Create the widget
local picom_widget = wibox.widget {
    {
        {
            id = "icon",
            text = "🎭",
            font = "JetBrainsMonoNL Nerd Font Medium 11",
            widget = wibox.widget.textbox
        },
        {
            id = "status",
            text = "...",
            font = "JetBrainsMonoNL Nerd Font Medium 8",
            widget = wibox.widget.textbox
        },
        spacing = 2,
        layout = wibox.layout.fixed.horizontal
    },
    fg = beautiful.fg_normal or "#ffffff",
    widget = wibox.container.background
}

-- Safe widget update function
local function update_widget()
    -- Protect against widget not being ready
    local success, err = pcall(function()
        local icon_widget = picom_widget:get_children_by_id("icon")[1]
        local status_widget = picom_widget:get_children_by_id("status")[1]
        
        if not icon_widget or not status_widget then
            return -- Widget components not ready yet
        end
        
        if picom_status.running then
            icon_widget.text = "🎭"
            status_widget.text = "ON"
            picom_widget.fg = "#48dbfb"  -- Active color
        else
            icon_widget.text = "🎭"
            status_widget.text = "OFF"
            picom_widget.fg = "#a4b0be"  -- Inactive color
        end
    end)
    
    if not success then
        -- Log error but don't crash
        if err then
            print("Picom widget update error: " .. tostring(err))
        end
    end
end

-- Check if picom is running
local function check_picom_status()
    awful.spawn.easy_async_with_shell("pgrep -x picom > /dev/null 2>&1; echo $?", function(stdout, stderr, reason, exit_code)
        local picom_exit_code = tonumber(stdout:match("%d+")) or 1
        picom_status.running = (picom_exit_code == 0)
        picom_status.initialized = true
        update_widget()
    end)
end

-- Toggle picom
local function toggle_picom()
    if not picom_status.initialized then
        naughty.notify({
            title = "🎭 Picom",
            text = "Picom status not ready yet, please wait...",
            timeout = 3
        })
        return
    end
    
    awful.spawn.easy_async_with_shell(PICOM_MANAGER_SCRIPT .. " toggle", function(stdout, stderr, reason, exit_code)
        if exit_code == 0 then
            -- Wait a moment then check status
            gears.timer {
                timeout = 1,
                single_shot = true,
                callback = check_picom_status
            }:start()
            
            naughty.notify({
                title = "🎭 Picom",
                text = "Compositor toggled",
                timeout = 2
            })
        else
            naughty.notify({
                title = "🎭 Picom Error",
                text = "Failed to toggle Picom",
                timeout = 5,
                urgency = "critical"
            })
        end
    end)
end

-- Show picom status
local function show_status()
    awful.spawn.easy_async_with_shell(PICOM_MANAGER_SCRIPT .. " status", function(stdout, stderr, reason, exit_code)
        if exit_code == 0 then
            naughty.notify({
                title = "🎭 Picom Status",
                text = stdout,
                timeout = 8
            })
        else
            naughty.notify({
                title = "🎭 Picom",
                text = "Status: " .. (picom_status.running and "Running" or "Stopped"),
                timeout = 5
            })
        end
    end)
end

-- Toggle performance mode
local function toggle_performance_mode()
    awful.spawn.easy_async_with_shell(PICOM_MANAGER_SCRIPT .. " performance", function(stdout, stderr, reason, exit_code)
        naughty.notify({
            title = "🎭 Picom",
            text = "Performance mode toggled",
            timeout = 3
        })
    end)
end

-- Create simple context menu
local function create_context_menu()
    local menu_items = {
        { "Toggle Picom", function() toggle_picom() end },
        { "Performance Mode", function() toggle_performance_mode() end },
        { "Show Status", function() show_status() end },
    }
    
    return awful.menu({ items = menu_items })
end

-- Mouse controls
picom_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then      -- Left click: toggle picom
        toggle_picom()
    elseif button == 2 then  -- Middle click: performance mode
        toggle_performance_mode()
    elseif button == 3 then  -- Right click: context menu
        local menu = create_context_menu()
        menu:show()
    end
end)

-- Tooltip
local picom_tooltip = awful.tooltip({
    objects = { picom_widget },
    text = "🎭 Picom Compositor\n" ..
           "Left click: Toggle on/off\n" ..
           "Middle click: Performance mode\n" ..
           "Right click: Menu\n\n" ..
           "Keybindings:\n" ..
           "Alt+c: Toggle\n" ..
           "Alt+Shift+c: Performance\n" ..
           "Alt+Ctrl+c: Status"
})

-- Initialize widget safely
local function initialize_widget()
    -- Initial check
    check_picom_status()
    
    -- Periodic updates
    gears.timer {
        timeout = 15,  -- Check every 15 seconds
        call_now = false,
        autostart = true,
        callback = check_picom_status
    }
end

-- Start initialization after a delay
gears.timer {
    timeout = 3,
    single_shot = true,
    callback = initialize_widget
}:start()

-- Export functions
picom_control.widget = picom_widget
picom_control.toggle = toggle_picom
picom_control.show_status = show_status
picom_control.toggle_performance = toggle_performance_mode

return picom_control
