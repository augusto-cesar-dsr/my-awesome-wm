-- Autostart applications
local awful = require("awful")
local naughty = require("naughty")

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
  -- Primeiro verifica se há janela do Chrome
  local has_window = app_has_window({"google-chrome", "Google-chrome", "chromium", "Chromium"})
  if has_window then 
    return true 
  end
  
  -- Verifica processo chrome principal (não crash handlers ou background processes)
  local handle = io.popen("pgrep -u $USER -f 'google-chrome.*--type=browser' 2>/dev/null | head -1")
  local result = handle:read("*a")
  handle:close()
  
  return result and result:match("%d+") ~= nil
end

-- Aplicações que iniciam automaticamente
local autostart_apps = {
  -- Terminal com Nvim na Tag 1 (apenas se não houver terminal na tag 1)
  {
    cmd = terminal .. " -e nvim",
    tag = "󰨞",
    delay = 3,
    check_classes = {"gnome-terminal", "Gnome-terminal", "alacritty", "kitty", "xterm"},
    check_tag_only = "󰨞", -- Verifica apenas na tag específica
  },

  -- Slack na Tag 2 (apenas se não estiver rodando)
  {
    cmd = "slack",
    tag = "󰒱",
    delay = 6,
    check_classes = {"slack"},
    process_name = "slack",
  },

  -- Chrome na Tag 3 (apenas se não estiver rodando)
  {
    cmd = "google-chrome-stable --profile-directory='Profile 1'",
    tag = "󰖟",
    delay = 10,
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
    -- Debug: Log da tentativa
    naughty.notify({
      title = "🚀 Autostart",
      text = "Checking " .. (app.process_name or "app") .. " after " .. app.delay .. "s delay",
      timeout = 3
    })
    
    -- Verificar se deve iniciar a aplicação
    local should_start = false
    
    if app.check_tag_only then
      -- Verifica apenas na tag específica (para terminal)
      should_start = not app_exists_in_tag(app.check_classes, app.check_tag_only)
      if should_start then
        naughty.notify({
          title = "🖥️ Terminal",
          text = "Starting terminal with nvim in tag " .. app.check_tag_only,
          timeout = 3
        })
      end
    elseif app.tag == "󰖟" then
      -- Verificação especial para Chrome
      should_start = not chrome_is_running()
      if should_start then
        naughty.notify({
          title = "🌐 Chrome",
          text = "Starting Chrome browser",
          timeout = 3
        })
      end
    else
      -- Verifica globalmente (para slack)
      should_start = not app_has_window(app.check_classes)
      if should_start then
        naughty.notify({
          title = "💬 Slack",
          text = "Starting Slack application",
          timeout = 3
        })
      end
    end
    
    if should_start then
      -- Muda para a tag específica
      local screen = awful.screen.focused()
      local tag = awful.tag.find_by_name(screen, app.tag)

      if tag then
        tag:view_only()
        -- Aguardar um pouco para a tag mudar
        awful.spawn.easy_async_with_shell("sleep 0.5", function()
          -- Inicia a aplicação
          awful.spawn.with_shell(app.cmd)
        end)
      else
        -- Se não encontrar a tag, inicia mesmo assim
        awful.spawn.with_shell(app.cmd)
      end
    else
      naughty.notify({
        title = "ℹ️ Autostart",
        text = (app.process_name or "App") .. " already running, skipping",
        timeout = 2
      })
    end
  end)
end

-- Inicia as aplicações
for _, app in ipairs(autostart_apps) do
  delayed_spawn(app)
end

-- Outras aplicações de sistema - removidas daqui pois serão iniciadas com delay
-- run_once("nm-applet", "nm-applet")      -- Network manager
-- run_once("blueman-applet", "blueman-applet") -- Bluetooth  
-- run_once("pasystray", "pasystray")      -- Audio control

-- Set default wallpaper (Samurai Yellow Moon)
awful.spawn.with_shell("sleep 1 && " .. os.getenv("HOME") .. "/.config/awesome/bin/set_default_wallpaper")

-- Start Picom compositor with theme integration (always keep it running)
awful.spawn.with_shell("sleep 2 && " .. os.getenv("HOME") .. "/.config/awesome/bin/picom_manager start")

-- Keep Picom always alive with simple monitoring script
run_once(os.getenv("HOME") .. "/.config/awesome/bin/keep_picom_alive", "keep_picom_alive")

-- Aguardar mais tempo antes de iniciar os applets para garantir que o systray esteja pronto
awful.spawn.easy_async_with_shell("sleep 5", function()
  naughty.notify({
    title = "🔧 System Tray",
    text = "Starting system applets...",
    timeout = 3
  })
  
  -- Network Manager Applet
  run_once("nm-applet", "nm-applet")
  
  -- Aguardar um pouco entre cada applet
  awful.spawn.easy_async_with_shell("sleep 1", function()
    -- Bluetooth Manager Applet  
    run_once("blueman-applet", "blueman-applet")
    
    awful.spawn.easy_async_with_shell("sleep 1", function()
      -- Audio System Tray
      run_once("pasystray", "pasystray")
      
      -- Notificação final
      awful.spawn.easy_async_with_shell("sleep 2", function()
        naughty.notify({
          title = "✅ System Ready",
          text = "All system applets started",
          timeout = 3
        })
      end)
    end)
  end)
end)
