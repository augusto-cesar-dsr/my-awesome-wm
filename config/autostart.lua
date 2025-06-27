-- Autostart applications
local awful = require("awful")

local function run_once(cmd)
  local findme = cmd
  local firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

-- Aplicações que iniciam automaticamente
local autostart_apps = {
  -- Editor na Tag 1
  {
    cmd = terminal .. " -e nvim",
    tag = "󰨞",
    delay = 2,
  },

  -- Slack na Tag 2
  {
    cmd = "slack",
    tag = "󰒱",
    delay = 4,
  },

  -- Chrome na Tag 3 (sessão de trabalho)
  {
    cmd = "google-chrome-stable --profile-directory='Profile 1'",
    tag = "󰖟",
    delay = 6,
  },
}

-- Função para iniciar apps com delay
local function delayed_spawn(app)
  awful.spawn.easy_async_with_shell("sleep " .. app.delay, function()
    -- Muda para a tag específica
    local screen = awful.screen.focused()
    local tag = nil

    -- Procura pela tag com o nome específico
    for _, t in ipairs(screen.tags) do
      if t.name == app.tag then
        tag = t
        break
      end
    end

    if tag then
      tag:view_only()
    end

    -- Inicia a aplicação
    awful.spawn.with_shell(app.cmd)
  end)
end

-- Inicia as aplicações
for _, app in ipairs(autostart_apps) do
  delayed_spawn(app)
end

-- Outras aplicações de sistema (sem delay)
run_once("nm-applet")      -- Network manager
run_once("blueman-applet") -- Bluetooth
run_once("pasystray")      -- Audio control
