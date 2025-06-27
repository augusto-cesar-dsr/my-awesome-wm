-- Global variables and settings
local awful = require("awful")

-- Caminhos dinâmicos baseados no usuário atual
awesome_config_path = os.getenv("HOME") .. "/.config/awesome"

-- Applications
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
browser = "google-chrome-stable --profile-directory='Profile 1'" -- Sessão de trabalho
file_manager = "nautilus"

-- Modkey (Super/Windows key)
modkey = "Mod4"

-- Layouts
awful.layout.layouts = {
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.max,
  awful.layout.suit.tile,
  awful.layout.suit.floating,
}

-- Tags personalizadas com ícones
tag_config = {
  { name = "󰨞", apps = { "nvim", "code" } }, -- Tag 1: Editor (ícone de código)
  { name = "󰒱", apps = { "slack" } }, -- Tag 2: Slack (ícone de chat)
  { name = "󰖟", apps = { "google-chrome" } }, -- Tag 3: Browser (ícone de navegador)
  { name = "󰉋", apps = {} }, -- Tag 4: Arquivos (ícone de pasta)
  { name = "󰝚", apps = {} }, -- Tag 5: Música (ícone de música)
  { name = "󰍹", apps = {} }, -- Tag 6: Terminal (ícone de terminal)
  { name = "󰊻", apps = {} }, -- Tag 7: Documentos (ícone de documento)
  { name = "󰟴", apps = {} }, -- Tag 8: Configurações (ícone de engrenagem)
  { name = "󰐃", apps = {} }, -- Tag 9: Diversos (ícone de grid)
}

-- Screen setup
awful.screen.connect_for_each_screen(function(s)
  -- Teste: criar tags simples primeiro para verificar se aparecem
  local tag_names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

  -- Create tags
  awful.tag(tag_names, s, awful.layout.layouts[1])

  -- Depois aplicar os ícones
  for i, tag in ipairs(s.tags) do
    local icons = {
      "󰨞", -- Tag 1: Editor
      "󰒱", -- Tag 2: Chat
      "󰖟", -- Tag 3: Browser
      "󰍹", -- Tag 4: Terminal (era 6)
      "󰉋", -- Tag 5: Arquivos (era 4)
      "󰝚", -- Tag 6: Música (era 5)
      "󰊻", -- Tag 7: Documentos
      "󰟴", -- Tag 8: Configurações
      "󰐃", -- Tag 9: Diversos
    }
    if icons[i] then
      tag.name = icons[i]
    end
  end
end)
