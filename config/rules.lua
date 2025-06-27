-- Window rules
local awful = require("awful")
local beautiful = require("beautiful")

-- Função auxiliar para detectar se um cliente é um terminal
local function is_terminal(client)
  if not client or not client.class then
    return false
  end

  local terminal_classes = {
    "Gnome%-terminal",
    "gnome%-terminal",
    "Alacritty",
    "alacritty",
    "Kitty",
    "kitty",
    "X%-terminal%-emulator",
    "Xterm",
    "xterm",
    "URxvt",
    "urxvt",
    "Terminator",
    "terminator",
  }

  for _, pattern in ipairs(terminal_classes) do
    if client.class:match(pattern) then
      return true
    end
  end
  return false
end

-- Rules to apply to new clients
awful.rules.rules = {
  -- All clients will match this rule
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = require("config.keys.client"),
      buttons = require("config.keys.client-buttons"),
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- Floating clients
  {
    rule_any = {
      instance = {
        "DTA",
        "copyq",
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },
      name = {
        "Event Tester",
      },
      role = {
        "AlarmWindow",
        "ConfigManager",
        "pop-up",
      },
    },
    properties = { floating = true },
  },

  -- Editor na Tag 1
  {
    rule_any = {
      class = { "Code", "code", "VSCode" },
      name = { "nvim", "vim" },
    },
    properties = {
      screen = 1,
      tag = "󰨞",
      maximized = false,
      callback = function(c)
        local tag = awful.tag.find_by_name(awful.screen.focused(), "󰨞")
        if tag then
          c:move_to_tag(tag)
        end
      end,
    },
  },

  -- Slack na Tag 2
  {
    rule_any = {
      class = { "Slack", "slack" },
    },
    properties = {
      screen = 1,
      tag = "󰒱",
      callback = function(c)
        local tag = awful.tag.find_by_name(awful.screen.focused(), "󰒱")
        if tag then
          c:move_to_tag(tag)
        end
      end,
    },
  },

  -- Chrome na Tag 3
  {
    rule_any = {
      class = { "Google-chrome", "google-chrome", "Chromium", "chromium" },
    },
    properties = {
      screen = 1,
      tag = "󰖟",
      callback = function(c)
        local tag = awful.tag.find_by_name(awful.screen.focused(), "󰖟")
        if tag then
          c:move_to_tag(tag)
        end
      end,
    },
  },

  -- Nautilus na Tag 4
  {
    rule_any = {
      class = { "Nautilus", "nautilus", "Thunar", "thunar" },
    },
    properties = {
      screen = 1,
      tag = "󰉋",
      callback = function(c)
        local tag = awful.tag.find_by_name(awful.screen.focused(), "󰉋")
        if tag then
          c:move_to_tag(tag)
        end
      end,
    },
  },

  -- Terminal com lógica inteligente de posicionamento
  {
    rule_any = {
      class = {
        "Gnome-terminal",
        "gnome-terminal",
        "Alacritty",
        "alacritty",
        "Kitty",
        "kitty",
        "X-terminal-emulator",
        "Xterm",
        "xterm",
        "URxvt",
        "urxvt",
        "Terminator",
        "terminator",
      },
    },
    properties = {
      screen = 1,
      callback = function(c)
        -- Função para contar terminais em uma tag específica
        local function count_terminals_in_tag(tag_name)
          local tag = awful.tag.find_by_name(awful.screen.focused(), tag_name)
          if not tag then
            return 0
          end

          local count = 0
          for _, client in ipairs(tag:clients()) do
            if is_terminal(client) then
              count = count + 1
            end
          end
          return count
        end

        -- Contar terminais na tag 1 (Editor)
        local terminals_in_tag1 = count_terminals_in_tag("󰨞")

        -- Decidir onde colocar o terminal
        local target_tag_name
        if terminals_in_tag1 >= 1 then
          -- Se já há 1 ou mais terminais na tag 1, colocar na tag 6
          target_tag_name = "󰍹" -- Tag 6: Terminal
        else
          -- Se não há terminais na tag 1, colocar na tag 1
          target_tag_name = "󰨞" -- Tag 1: Editor
        end

        -- Mover o cliente para a tag escolhida
        local target_tag = awful.tag.find_by_name(awful.screen.focused(), target_tag_name)
        if target_tag then
          c:move_to_tag(target_tag)
        end
      end,
    },
  },
}
