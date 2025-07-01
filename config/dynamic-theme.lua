-- Dynamic Theme Module for AwesomeWM
-- Integrates with theme_manager script for automatic theming

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

local dynamic_theme = {}

-- Configuration
local THEME_MANAGER_SCRIPT = os.getenv("HOME") .. "/.config/awesome/bin/theme_manager"
local DYNAMIC_THEME_DIR = os.getenv("HOME") .. "/.config/awesome/themes/dynamic"
local UPDATE_INTERVAL = 1800  -- 30 minutes in seconds
local CHECK_WALLPAPER_INTERVAL = 60  -- 1 minute

-- State
local current_wallpaper = nil
local theme_timer = nil
local wallpaper_check_timer = nil
local is_enabled = true

-- Helper function to check if file exists
local function file_exists(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    end
    return false
end

-- Get current wallpaper path
local function get_current_wallpaper()
    local wallpaper_file = os.getenv("HOME") .. "/.config/awesome/.current_wallpaper"
    
    if file_exists(wallpaper_file) then
        local file = io.open(wallpaper_file, "r")
        if file then
            local wallpaper = file:read("*line")
            file:close()
            return wallpaper
        end
    end
    
    -- Fallback: try to get from .fehbg
    local fehbg_file = os.getenv("HOME") .. "/.fehbg"
    if file_exists(fehbg_file) then
        awful.spawn.easy_async_with_shell(
            "grep -o \"'[^']*'\" " .. fehbg_file .. " | head -1 | tr -d \"'\"",
            function(stdout)
                if stdout and stdout ~= "" then
                    return stdout:gsub("\n", "")
                end
            end
        )
    end
    
    return nil
end

-- Generate theme from current wallpaper
local function generate_theme()
    if not is_enabled then return end
    
    awful.spawn.easy_async_with_shell(
        THEME_MANAGER_SCRIPT .. " generate",
        function(stdout, stderr, reason, exit_code)
            if exit_code == 0 then
                -- Update Picom theme integration after theme generation
                awful.spawn.easy_async_with_shell(
                    os.getenv("HOME") .. "/.config/awesome/bin/picom_manager update-theme",
                    function()
                        naughty.notify({
                            title = "🎨 Dynamic Theme",
                            text = "Theme and compositor effects updated",
                            timeout = 3
                        })
                    end
                )
            else
                naughty.notify({
                    title = "🎨 Dynamic Theme",
                    text = "Failed to generate theme: " .. (stderr or "Unknown error"),
                    timeout = 5,
                    urgency = "critical"
                })
            end
        end
    )
end

-- Check if wallpaper has changed
local function check_wallpaper_change()
    local new_wallpaper = get_current_wallpaper()
    
    if new_wallpaper and new_wallpaper ~= current_wallpaper then
        current_wallpaper = new_wallpaper
        
        -- Delay theme generation to avoid rapid changes
        if theme_timer then
            theme_timer:stop()
        end
        
        theme_timer = gears.timer {
            timeout = 5,  -- 5 second delay
            single_shot = true,
            callback = function()
                generate_theme()
            end
        }
        theme_timer:start()
    end
end

-- Apply dynamic theme if available
local function apply_dynamic_theme()
    local current_theme_file = DYNAMIC_THEME_DIR .. "/current.lua"
    
    if file_exists(current_theme_file) then
        -- Load the dynamic theme
        local success, theme_or_error = pcall(dofile, current_theme_file)
        
        if success and theme_or_error then
            -- Apply the theme
            beautiful.init(theme_or_error)
            
            naughty.notify({
                title = "🎨 Dynamic Theme",
                text = "Dynamic theme applied successfully",
                timeout = 2
            })
            
            return true
        else
            naughty.notify({
                title = "🎨 Dynamic Theme",
                text = "Failed to load dynamic theme: " .. tostring(theme_or_error),
                timeout = 5,
                urgency = "critical"
            })
        end
    end
    
    return false
end

-- Start dynamic theming
function dynamic_theme.start()
    if not file_exists(THEME_MANAGER_SCRIPT) then
        naughty.notify({
            title = "🎨 Dynamic Theme",
            text = "Theme manager script not found",
            timeout = 5,
            urgency = "critical"
        })
        return false
    end
    
    is_enabled = true
    current_wallpaper = get_current_wallpaper()
    
    -- Generate initial theme
    generate_theme()
    
    -- Start wallpaper monitoring
    wallpaper_check_timer = gears.timer {
        timeout = CHECK_WALLPAPER_INTERVAL,
        call_now = false,
        autostart = true,
        callback = check_wallpaper_change
    }
    
    naughty.notify({
        title = "🎨 Dynamic Theme",
        text = "Dynamic theming started",
        timeout = 3
    })
    
    return true
end

-- Stop dynamic theming
function dynamic_theme.stop()
    is_enabled = false
    
    if theme_timer then
        theme_timer:stop()
        theme_timer = nil
    end
    
    if wallpaper_check_timer then
        wallpaper_check_timer:stop()
        wallpaper_check_timer = nil
    end
    
    naughty.notify({
        title = "🎨 Dynamic Theme",
        text = "Dynamic theming stopped",
        timeout = 3
    })
end

-- Toggle dynamic theming
function dynamic_theme.toggle()
    if is_enabled then
        dynamic_theme.stop()
    else
        dynamic_theme.start()
    end
end

-- Force theme regeneration
function dynamic_theme.regenerate()
    generate_theme()
end

-- Show theme info
function dynamic_theme.show_info()
    awful.spawn.easy_async_with_shell(
        THEME_MANAGER_SCRIPT .. " info",
        function(stdout, stderr, reason, exit_code)
            if exit_code == 0 then
                naughty.notify({
                    title = "🎨 Dynamic Theme Info",
                    text = stdout,
                    timeout = 8
                })
            else
                naughty.notify({
                    title = "🎨 Dynamic Theme Info",
                    text = "Failed to get theme info",
                    timeout = 5
                })
            end
        end
    )
end

-- Check if dynamic theming is enabled
function dynamic_theme.is_enabled()
    return is_enabled
end

-- Auto-start dynamic theming (called from rc.lua)
function dynamic_theme.auto_start()
    -- Wait a bit for AwesomeWM to fully load
    gears.timer {
        timeout = 5,
        single_shot = true,
        callback = function()
            dynamic_theme.start()
        end
    }:start()
end

return dynamic_theme
