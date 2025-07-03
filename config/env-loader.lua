-- Environment Variables Loader for AwesomeWM
-- Loads variables from .env file

local gears = require("gears")

local env_loader = {}

-- Function to load .env file
function env_loader.load_env(file_path)
    local env_vars = {}
    local env_file_path = file_path or (gears.filesystem.get_configuration_dir() .. ".env")
    
    -- Check if .env file exists
    local file = io.open(env_file_path, "r")
    if not file then
        print("Warning: .env file not found at " .. env_file_path)
        return env_vars
    end
    
    -- Read and parse .env file
    for line in file:lines() do
        -- Skip empty lines and comments
        if not (line:match("^%s*$") or line:match("^%s*#")) then
            -- Parse KEY=VALUE format
            local key, value = line:match("^%s*([%w_]+)%s*=%s*(.*)%s*$")
            if key and value then
                -- Remove quotes if present
                value = value:gsub("^[\"']", ""):gsub("[\"']$", "")
                env_vars[key] = value
            end
        end
    end
    
    file:close()
    return env_vars
end

-- Function to get environment variable with fallback
function env_loader.get_env(key, default_value, env_vars)
    env_vars = env_vars or {}
    
    -- Try to get from loaded env_vars first
    if env_vars[key] then
        return env_vars[key]
    end
    
    -- Try to get from system environment
    local sys_value = os.getenv(key)
    if sys_value then
        return sys_value
    end
    
    -- Return default value
    return default_value
end

return env_loader
