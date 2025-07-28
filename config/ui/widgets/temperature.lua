-- Temperature Widget using Vicious
local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")

local temperature_widget = {}

-- Create Temperature widget
local temp_text = wibox.widget({
	widget = wibox.widget.textbox,
})

local temp_icon = wibox.widget({
	text = "󰔏 ",
	widget = wibox.widget.textbox,
})

temperature_widget.widget = wibox.widget({
	temp_icon,
	temp_text,
	layout = wibox.layout.fixed.horizontal,
})

-- Function to find the best thermal zone (CPU temperature)
local function find_cpu_thermal_zone()
	-- Try common CPU thermal zones in order of preference
	local zones_to_try = { "thermal_zone4", "thermal_zone3", "thermal_zone0", "thermal_zone1", "thermal_zone2", "thermal_zone5" }

	for _, zone in ipairs(zones_to_try) do
		local temp_file = "/sys/class/thermal/" .. zone .. "/temp"
		local type_file = "/sys/class/thermal/" .. zone .. "/type"

		-- Check if files exist and are readable
		local temp_handle = io.open(temp_file, "r")
		local type_handle = io.open(type_file, "r")

		if temp_handle and type_handle then
			local temp_str = temp_handle:read("*line")
			local type_str = type_handle:read("*line")
			temp_handle:close()
			type_handle:close()

			local temp = tonumber(temp_str)
			if temp and temp > 20000 and temp < 120000 then -- Reasonable CPU temp range (20-120°C in millidegrees)
				-- Prefer zones that look like CPU sensors
				if type_str and (type_str:match("pkg_temp") or type_str:match("coretemp") or type_str:match("B0D4")) then
					return zone
				end
			end
		end
	end

	return "thermal_zone4" -- fallback to x86_pkg_temp
end

-- Get the best thermal zone
local thermal_zone = find_cpu_thermal_zone()

-- Vicious Temperature widget with color coding
vicious.register(temp_text, vicious.widgets.thermal, function(widget, args)
	local temp = args[1]

	if temp and temp > 0 then
		-- Color coding based on temperature
		if temp > 75 then
			return string.format('<span color="#ff6b6b">%d°C</span>', temp)
		elseif temp > 60 then
			return string.format('<span color="#feca57">%d°C</span>', temp)
		else
			return string.format('<span color="#48dbfb">%d°C</span>', temp)
		end
	else
		return '<span color="#a4b0be">--°C</span>'
	end
end, 10, thermal_zone) -- Update every 10 seconds

return temperature_widget
