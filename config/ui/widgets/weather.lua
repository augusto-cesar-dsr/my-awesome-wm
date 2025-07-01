-- Weather Widget for AwesomeWM
-- Uses OpenWeatherMap API (free tier)

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local weather = {}

-- Configuration (you can change these)
local API_KEY = "demo_key"  -- Replace with your OpenWeatherMap API key
local CITY = "São Paulo"    -- Change to your city
local COUNTRY_CODE = "BR"   -- Change to your country code
local UNITS = "metric"      -- metric, imperial, or kelvin
local UPDATE_INTERVAL = 600 -- 10 minutes in seconds

-- Weather data
local weather_data = {
    temp = "--",
    description = "Loading...",
    icon = "󰖐",
    humidity = "--",
    feels_like = "--",
    last_update = "Never"
}

-- Weather icons mapping
local weather_icons = {
    ["01d"] = "󰖙",  -- clear sky day
    ["01n"] = "󰖔",  -- clear sky night
    ["02d"] = "󰖕",  -- few clouds day
    ["02n"] = "󰖕",  -- few clouds night
    ["03d"] = "󰖐",  -- scattered clouds
    ["03n"] = "󰖐",  -- scattered clouds
    ["04d"] = "󰖐",  -- broken clouds
    ["04n"] = "󰖐",  -- broken clouds
    ["09d"] = "󰖗",  -- shower rain
    ["09n"] = "󰖗",  -- shower rain
    ["10d"] = "󰖖",  -- rain day
    ["10n"] = "󰖖",  -- rain night
    ["11d"] = "󰖓",  -- thunderstorm
    ["11n"] = "󰖓",  -- thunderstorm
    ["13d"] = "󰖘",  -- snow
    ["13n"] = "󰖘",  -- snow
    ["50d"] = "󰖑",  -- mist
    ["50n"] = "󰖑",  -- mist
    default = "󰖐"
}

-- Create the widget
local weather_widget = wibox.widget {
    {
        {
            id = "icon",
            text = weather_data.icon,
            font = "JetBrainsMonoNL Nerd Font Medium 12",
            widget = wibox.widget.textbox
        },
        {
            id = "temp",
            text = weather_data.temp .. "°",
            font = "JetBrainsMonoNL Nerd Font Medium 10",
            widget = wibox.widget.textbox
        },
        spacing = 4,
        layout = wibox.layout.fixed.horizontal
    },
    fg = beautiful.fg_normal or "#ffffff",
    widget = wibox.container.background
}

-- Helper function to get color based on temperature
local function get_temp_color(temp)
    local temp_num = tonumber(temp)
    if not temp_num then return "#a4b0be" end
    
    if temp_num >= 30 then
        return "#ff6b6b"  -- Hot (red)
    elseif temp_num >= 20 then
        return "#feca57"  -- Warm (yellow)
    elseif temp_num >= 10 then
        return "#48dbfb"  -- Cool (blue)
    else
        return "#74b9ff"  -- Cold (light blue)
    end
end

-- Update widget display
local function update_widget()
    local icon_widget = weather_widget:get_children_by_id("icon")[1]
    local temp_widget = weather_widget:get_children_by_id("temp")[1]
    
    icon_widget.text = weather_data.icon
    temp_widget.text = weather_data.temp .. "°"
    weather_widget.fg = get_temp_color(weather_data.temp)
end

-- Parse weather data from API response
local function parse_weather_data(json_str)
    -- Simple JSON parsing for the fields we need
    -- This is a basic implementation - in production you'd use a proper JSON library
    
    local temp = json_str:match('"temp":([%d%.%-]+)')
    local feels_like = json_str:match('"feels_like":([%d%.%-]+)')
    local humidity = json_str:match('"humidity":(%d+)')
    local description = json_str:match('"description":"([^"]+)"')
    local icon_code = json_str:match('"icon":"([^"]+)"')
    
    if temp then
        weather_data.temp = math.floor(tonumber(temp) + 0.5) -- Round to nearest integer
        weather_data.feels_like = math.floor(tonumber(feels_like or temp) + 0.5)
        weather_data.humidity = humidity or "--"
        weather_data.description = description or "Unknown"
        weather_data.icon = weather_icons[icon_code] or weather_icons.default
        weather_data.last_update = os.date("%H:%M")
        
        update_widget()
        return true
    end
    
    return false
end

-- Fetch weather data
local function fetch_weather()
    -- Check if we have a valid API key
    if API_KEY == "demo_key" then
        -- Demo mode - show fake data
        weather_data.temp = "22"
        weather_data.feels_like = "24"
        weather_data.humidity = "65"
        weather_data.description = "Demo mode - Set API key"
        weather_data.icon = "󰖙"
        weather_data.last_update = os.date("%H:%M")
        update_widget()
        return
    end
    
    local url = string.format(
        "http://api.openweathermap.org/data/2.5/weather?q=%s,%s&appid=%s&units=%s",
        CITY:gsub(" ", "%%20"), COUNTRY_CODE, API_KEY, UNITS
    )
    
    awful.spawn.easy_async_with_shell(
        "curl -s '" .. url .. "'",
        function(stdout, stderr, reason, exit_code)
            if exit_code == 0 and stdout and stdout ~= "" then
                if parse_weather_data(stdout) then
                    -- Success
                else
                    -- Failed to parse
                    weather_data.temp = "??"
                    weather_data.description = "Parse error"
                    weather_data.icon = "󰖐"
                    update_widget()
                end
            else
                -- Network error or API error
                weather_data.temp = "??"
                weather_data.description = "Network error"
                weather_data.icon = "󰖐"
                update_widget()
            end
        end
    )
end

-- Show detailed weather info
local function show_weather_details()
    local details = string.format(
        "🌤️ Weather in %s\n\n" ..
        "Temperature: %s°C (feels like %s°C)\n" ..
        "Condition: %s\n" ..
        "Humidity: %s%%\n" ..
        "Last update: %s\n\n" ..
        "Click to refresh",
        CITY,
        weather_data.temp,
        weather_data.feels_like,
        weather_data.description,
        weather_data.humidity,
        weather_data.last_update
    )
    
    naughty.notify({
        title = "Weather Details",
        text = details,
        timeout = 8,
        icon = beautiful.awesome_icon
    })
end

-- Mouse controls
weather_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then      -- Left click: refresh
        fetch_weather()
        naughty.notify({
            title = "Weather",
            text = "Refreshing weather data...",
            timeout = 2
        })
    elseif button == 3 then  -- Right click: show details
        show_weather_details()
    end
end)

-- Tooltip
local weather_tooltip = awful.tooltip({
    objects = { weather_widget },
    text = "🌤️ Weather Widget\n" ..
           "Left click: Refresh\n" ..
           "Right click: Details\n\n" ..
           "To use real data:\n" ..
           "1. Get free API key from openweathermap.org\n" ..
           "2. Edit config/ui/widgets/weather.lua\n" ..
           "3. Set API_KEY and CITY variables"
})

-- Auto-update timer
local weather_timer = gears.timer {
    timeout = UPDATE_INTERVAL,
    call_now = true,
    autostart = true,
    callback = fetch_weather
}

-- Initialize
update_widget()

-- Export
weather.widget = weather_widget
weather.refresh = fetch_weather
weather.show_details = show_weather_details

return weather
