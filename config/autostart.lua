-- Autostart applications
local awful = require("awful")

-- Função melhorada para verificar se processo já está rodando
local function run_once(cmd, process_name)
  local findme = process_name or cmd
  local firstspace = findme:find(" ")
  if firstspace then
    findme = findme:sub(1, firstspace - 1)
  end
  awful.spawn.with_shell(string.format("pgrep -u $USER -f %s > /dev/null || (%s)", findme, cmd))
end

-- Função para verificar se aplicação já tem janela aberta
local function app_has_window(class_names)
  for _, c in ipairs(client.get()) do
    if c.class then
      for _, class_name in ipairs(class_names) do
        if c.class:lower():match(class_name:lower()) then
          return true
        end
      end
    end
  end
  return false
end

-- Função específica para verificar Chrome rodando
local function chrome_is_running()
  -- Verifica tanto por janela quanto por processo
  local has_window = app_has_window({"google-chrome", "Google-chrome", "chromium", "Chromium"})
  if has_window then return true end
  
  -- Verifica processo chrome
  local handle = io.popen("pgrep -u $USER -f 'chrome|google-chrome' 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return result and result:match("%d+")
end

-- Aplicações que iniciam automaticamente
local autostart_apps = {
  -- Terminal com Nvim na Tag 1 (apenas se não houver terminal na tag 1)
  {
    cmd = terminal .. " -e nvim",
    tag = "󰨞",
    delay = 2,
    check_classes = {"gnome-terminal", "Gnome-terminal", "alacritty", "kitty", "xterm"},
    check_tag_only = "󰨞", -- Verifica apenas na tag específica
  },

  -- Slack na Tag 2 (apenas se não estiver rodando)
  {
    cmd = "slack",
    tag = "󰒱",
    delay = 4,
    check_classes = {"slack"},
    process_name = "slack",
  },

  -- Chrome na Tag 3 (apenas se não estiver rodando)
  {
    cmd = "google-chrome-stable --profile-directory='Profile 1'",
    tag = "󰖟",
    delay = 6,
    check_classes = {"google-chrome", "Google-chrome", "chromium", "Chromium"},
    process_name = "chrome", -- Processo mais genérico para detecção
  },
}

-- Função para verificar se app já existe na tag específica
local function app_exists_in_tag(class_names, tag_name)
  local tag = awful.tag.find_by_name(awful.screen.focused(), tag_name)
  if not tag then return false end
  
  for _, c in ipairs(tag:clients()) do
    if c.class then
      for _, class_name in ipairs(class_names) do
        if c.class:lower():match(class_name:lower()) then
          return true
        end
      end
    end
  end
  return false
end

-- Função para iniciar apps com delay e verificações
local function delayed_spawn(app)
  awful.spawn.easy_async_with_shell("sleep " .. app.delay, function()
    -- Verificar se deve iniciar a aplicação
    local should_start = false
    
    if app.check_tag_only then
      -- Verifica apenas na tag específica (para terminal)
      should_start = not app_exists_in_tag(app.check_classes, app.check_tag_only)
    elseif app.tag == "󰖟" then
      -- Verificação especial para Chrome
      should_start = not chrome_is_running()
    else
      -- Verifica globalmente (para slack)
      should_start = not app_has_window(app.check_classes)
    end
    
    if should_start then
      -- Muda para a tag específica
      local screen = awful.screen.focused()
      local tag = awful.tag.find_by_name(screen, app.tag)

      if tag then
        tag:view_only()
      end

      -- Inicia a aplicação
      awful.spawn.with_shell(app.cmd)
    end
  end)
end

-- Inicia as aplicações
for _, app in ipairs(autostart_apps) do
  delayed_spawn(app)
end

-- Outras aplicações de sistema (sem delay) - apenas se não estiverem rodando
run_once("nm-applet")      -- Network manager
run_once("blueman-applet") -- Bluetooth  
run_once("pasystray")      -- Audio control
