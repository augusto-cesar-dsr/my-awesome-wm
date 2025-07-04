-- Debug autostart
local awful = require("awful")

-- Log function
local function log_debug(msg)
  awful.spawn.with_shell("echo '[AUTOSTART DEBUG] " .. msg .. "' >> /tmp/awesome_autostart.log")
end

log_debug("=== AUTOSTART DEBUG INICIADO ===")
log_debug("Terminal: " .. (terminal or "UNDEFINED"))
log_debug("Awesome config path: " .. (awesome_config_path or "UNDEFINED"))

-- Test simple spawn
log_debug("Testando spawn simples...")
awful.spawn.with_shell("echo 'Test spawn' >> /tmp/awesome_autostart.log")

-- Test with delay
awful.spawn.easy_async_with_shell("sleep 2", function()
  log_debug("Delay de 2s funcionou")
end)

log_debug("=== FIM DEBUG ===")
