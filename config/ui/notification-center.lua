-- Notification Center for AwesomeWM
-- Simple and compatible notification history

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local notification_center = {}

-- Configuration
local MAX_NOTIFICATIONS = 15
local NOTIFICATION_WIDTH = 350
local NOTIFICATION_HEIGHT = 500

-- Notification history
local notification_history = {}
local notification_popup = nil
local is_visible = false

-- Add notification to history
local function add_to_history(notification)
    if not notification then return end
    
    local notification_data = {
        title = notification.title or "Notification",
        text = notification.text or notification.message or "",
        timestamp = os.time(),
        urgency = notification.urgency or "normal"
    }
    
    table.insert(notification_history, notification_data)
    
    -- Keep only recent notifications
    if #notification_history > MAX_NOTIFICATIONS then
        table.remove(notification_history, 1)
    end
end

-- Create notification item widget
local function create_notification_item(notification_data)
    local time_text = os.date("%H:%M", notification_data.timestamp)
    
    return wibox.widget {
        {
            {
                {
                    text = notification_data.title,
                    font = "JetBrainsMonoNL Nerd Font Bold 10",
                    widget = wibox.widget.textbox
                },
                {
                    text = time_text,
                    font = "JetBrainsMonoNL Nerd Font 8",
                    fg = "#a4b0be",
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.align.horizontal
            },
            {
                text = notification_data.text,
                font = "JetBrainsMonoNL Nerd Font 9",
                widget = wibox.widget.textbox,
                forced_height = 30
            },
            spacing = 3,
            layout = wibox.layout.fixed.vertical
        },
        margins = 6,
        widget = wibox.container.margin,
        bg = beautiful.bg_focus or "#2d2416ee",
        shape = gears.shape.rounded_rect,
        shape_border_width = 1,
        shape_border_color = beautiful.border_focus or "#535d6c"
    }
end

-- Create the notification center popup
local function create_notification_popup()
    -- Header
    local header = wibox.widget {
        {
            text = "󰂚 Notifications (" .. #notification_history .. ")",
            font = "JetBrainsMonoNL Nerd Font Bold 11",
            align = "center",
            widget = wibox.widget.textbox
        },
        margins = 10,
        widget = wibox.container.margin,
        bg = beautiful.bg_normal or "#1a1a1aee"
    }
    
    -- Notification list
    local notification_list = wibox.widget {
        spacing = 5,
        layout = wibox.layout.fixed.vertical
    }
    
    -- Populate notification list
    if #notification_history == 0 then
        notification_list:add(wibox.widget {
            {
                text = "No notifications yet",
                font = "JetBrainsMonoNL Nerd Font 10",
                align = "center",
                fg = "#a4b0be",
                widget = wibox.widget.textbox
            },
            margins = 30,
            widget = wibox.container.margin
        })
    else
        -- Show last 8 notifications
        local start_idx = math.max(1, #notification_history - 7)
        for i = #notification_history, start_idx, -1 do
            notification_list:add(create_notification_item(notification_history[i]))
        end
    end
    
    -- Clear button
    local clear_button = wibox.widget {
        {
            text = "󰃢 Clear All",
            font = "JetBrainsMonoNL Nerd Font 9",
            align = "center",
            widget = wibox.widget.textbox
        },
        margins = 6,
        widget = wibox.container.margin,
        bg = "#ff6b6b",
        shape = gears.shape.rounded_rect,
        buttons = gears.table.join(
            awful.button({}, 1, function()
                notification_history = {}
                notification_center.hide()
                naughty.notify({
                    title = "Notification Center",
                    text = "All notifications cleared",
                    timeout = 2
                })
            end)
        )
    }
    
    -- Main container
    local main_container = wibox.widget {
        header,
        {
            notification_list,
            margins = 8,
            widget = wibox.container.margin
        },
        clear_button,
        layout = wibox.layout.align.vertical
    }
    
    -- Create popup
    notification_popup = awful.popup {
        widget = main_container,
        placement = awful.placement.top_right,
        width = NOTIFICATION_WIDTH,
        height = NOTIFICATION_HEIGHT,
        bg = beautiful.bg_normal or "#1a1a1aee",
        fg = beautiful.fg_normal or "#ffffff",
        border_width = 2,
        border_color = beautiful.border_focus or "#535d6c",
        shape = gears.shape.rounded_rect,
        visible = false,
        ontop = true
    }
    
    -- Position popup
    awful.placement.top_right(notification_popup, {
        margins = { top = 30, right = 10 }
    })
end

-- Show notification center
function notification_center.show()
    -- Recreate popup to refresh content
    if notification_popup then
        notification_popup.visible = false
        notification_popup = nil
    end
    
    create_notification_popup()
    notification_popup.visible = true
    is_visible = true
end

-- Hide notification center
function notification_center.hide()
    if notification_popup then
        notification_popup.visible = false
        is_visible = false
    end
end

-- Toggle notification center
function notification_center.toggle()
    if is_visible then
        notification_center.hide()
    else
        notification_center.show()
    end
end

-- Clear all notifications
function notification_center.clear_all()
    notification_history = {}
    if is_visible then
        notification_center.hide()
    end
    naughty.notify({
        title = "Notification Center",
        text = "All notifications cleared",
        timeout = 2
    })
end

-- Get notification count
function notification_center.get_count()
    return #notification_history
end

-- Hook into naughty to capture notifications (compatible method)
local original_notify = naughty.notify
naughty.notify = function(args)
    -- Add to our history first
    if args then
        add_to_history(args)
    end
    -- Then call the original notify function
    return original_notify(args)
end

-- Create notification center indicator widget
local notification_indicator = wibox.widget {
    {
        {
            id = "icon",
            text = "󰂚",
            font = "JetBrainsMonoNL Nerd Font Medium 11",
            widget = wibox.widget.textbox
        },
        {
            id = "count",
            text = "",
            font = "JetBrainsMonoNL Nerd Font Medium 8",
            fg = "#ff6b6b",
            widget = wibox.widget.textbox
        },
        spacing = 2,
        layout = wibox.layout.fixed.horizontal
    },
    fg = beautiful.fg_normal or "#ffffff",
    widget = wibox.container.background,
    buttons = gears.table.join(
        awful.button({}, 1, function()
            notification_center.toggle()
        end)
    )
}

-- Update indicator
local function update_indicator()
    local count = notification_center.get_count()
    local count_widget = notification_indicator:get_children_by_id("count")[1]
    
    if count > 0 then
        count_widget.text = tostring(count)
    else
        count_widget.text = ""
    end
end

-- Update indicator periodically
gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = update_indicator
}

-- Tooltip
local notification_tooltip = awful.tooltip({
    objects = { notification_indicator },
    text = "Notification Center\nClick to toggle\n\nKeybindings:\nAlt+n: Toggle\nAlt+Shift+n: Clear all"
})

-- Export
notification_center.widget = notification_indicator
return notification_center
