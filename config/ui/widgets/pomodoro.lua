-- Pomodoro Timer Widget for AwesomeWM
-- Integrates with the wibar for productivity tracking

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local pomodoro = {}

-- Pomodoro settings
local WORK_TIME = 25 * 60  -- 25 minutes in seconds
local SHORT_BREAK = 5 * 60  -- 5 minutes
local LONG_BREAK = 15 * 60  -- 15 minutes
local SESSIONS_UNTIL_LONG_BREAK = 4

-- State variables
local timer = nil
local time_left = WORK_TIME
local is_running = false
local is_work_session = true
local session_count = 0
local current_phase = "work"  -- "work", "short_break", "long_break"

-- Colors
local colors = {
    work = "#ff6b6b",      -- Red for work sessions
    short_break = "#4ecdc4", -- Teal for short breaks
    long_break = "#45b7d1",  -- Blue for long breaks
    paused = "#a4b0be",      -- Gray when paused
    inactive = "#57606f"     -- Dark gray when stopped
}

-- Icons
local icons = {
    work = "󰔟",           -- Tomato icon
    short_break = "󰤄",    -- Coffee icon  
    long_break = "󰒲",     -- Bed/rest icon
    play = "󰐊",           -- Play icon
    pause = "󰏤",          -- Pause icon
    stop = "󰓛"            -- Stop icon
}

-- Create the widget
local pomodoro_widget = wibox.widget {
    {
        {
            id = "icon",
            text = icons.work,
            font = "JetBrainsMonoNL Nerd Font Medium 12",
            widget = wibox.widget.textbox
        },
        {
            id = "time",
            text = "25:00",
            font = "JetBrainsMonoNL Nerd Font Medium 10",
            widget = wibox.widget.textbox
        },
        spacing = 4,
        layout = wibox.layout.fixed.horizontal
    },
    fg = colors.inactive,
    widget = wibox.container.background
}

-- Helper functions
local function format_time(seconds)
    local minutes = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d", minutes, secs)
end

local function get_current_color()
    if not is_running then
        return time_left > 0 and colors.paused or colors.inactive
    end
    
    if current_phase == "work" then
        return colors.work
    elseif current_phase == "short_break" then
        return colors.short_break
    else
        return colors.long_break
    end
end

local function get_current_icon()
    if current_phase == "work" then
        return icons.work
    elseif current_phase == "short_break" then
        return icons.short_break
    else
        return icons.long_break
    end
end

local function update_widget()
    local icon_widget = pomodoro_widget:get_children_by_id("icon")[1]
    local time_widget = pomodoro_widget:get_children_by_id("time")[1]
    
    icon_widget.text = get_current_icon()
    time_widget.text = format_time(time_left)
    pomodoro_widget.fg = get_current_color()
end

local function show_notification(title, message, urgency)
    naughty.notify({
        title = title,
        text = message,
        urgency = urgency or "normal",
        timeout = 5,
        icon = beautiful.awesome_icon
    })
end

local function start_next_phase()
    if current_phase == "work" then
        session_count = session_count + 1
        
        if session_count % SESSIONS_UNTIL_LONG_BREAK == 0 then
            current_phase = "long_break"
            time_left = LONG_BREAK
            show_notification("🍅 Pomodoro", "Work session complete! Time for a long break (15 min)", "critical")
        else
            current_phase = "short_break"
            time_left = SHORT_BREAK
            show_notification("🍅 Pomodoro", "Work session complete! Time for a short break (5 min)", "normal")
        end
    else
        current_phase = "work"
        time_left = WORK_TIME
        show_notification("🍅 Pomodoro", "Break over! Time to focus and work (25 min)", "normal")
    end
    
    update_widget()
end

local function tick()
    if time_left > 0 then
        time_left = time_left - 1
        update_widget()
    else
        -- Phase completed
        start_next_phase()
    end
end

-- Control functions
function pomodoro.start()
    if not is_running then
        is_running = true
        timer = gears.timer {
            timeout = 1,
            call_now = false,
            autostart = true,
            callback = tick
        }
        show_notification("🍅 Pomodoro", "Timer started! Focus time.", "low")
        update_widget()
    end
end

function pomodoro.pause()
    if is_running and timer then
        is_running = false
        timer:stop()
        timer = nil
        show_notification("🍅 Pomodoro", "Timer paused.", "low")
        update_widget()
    end
end

function pomodoro.stop()
    if timer then
        timer:stop()
        timer = nil
    end
    is_running = false
    current_phase = "work"
    time_left = WORK_TIME
    session_count = 0
    show_notification("🍅 Pomodoro", "Timer reset.", "low")
    update_widget()
end

function pomodoro.toggle()
    if is_running then
        pomodoro.pause()
    else
        pomodoro.start()
    end
end

function pomodoro.skip()
    if timer then
        timer:stop()
        timer = nil
    end
    is_running = false
    start_next_phase()
    show_notification("🍅 Pomodoro", "Phase skipped!", "low")
end

function pomodoro.status()
    local status_text = string.format(
        "🍅 Pomodoro Status:\n" ..
        "Phase: %s\n" ..
        "Time left: %s\n" ..
        "Sessions completed: %d\n" ..
        "Status: %s",
        current_phase:gsub("_", " "):gsub("^%l", string.upper),
        format_time(time_left),
        session_count,
        is_running and "Running" or "Paused"
    )
    
    show_notification("🍅 Pomodoro Status", status_text, "normal")
end

-- Mouse controls
pomodoro_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then      -- Left click: toggle
        pomodoro.toggle()
    elseif button == 2 then  -- Middle click: status
        pomodoro.status()
    elseif button == 3 then  -- Right click: stop/reset
        pomodoro.stop()
    end
end)

-- Tooltip
local pomodoro_tooltip = awful.tooltip({
    objects = { pomodoro_widget },
    text = "🍅 Pomodoro Timer\n" ..
           "Left click: Start/Pause\n" ..
           "Middle click: Status\n" ..
           "Right click: Stop/Reset\n" ..
           "Keybindings:\n" ..
           "Alt+p: Toggle\n" ..
           "Alt+Shift+p: Status\n" ..
           "Alt+Ctrl+p: Skip phase"
})

-- Initialize widget
update_widget()

-- Export the widget and control functions
pomodoro.widget = pomodoro_widget
return pomodoro
