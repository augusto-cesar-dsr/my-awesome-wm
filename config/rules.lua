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

  -- Scratchpad rules
  {
    rule_any = {
      instance = {
        "scratch-terminal",
        "scratch-notes",
      }
    },
    properties = {
      floating = true,
      ontop = true,
      above = true,
      skip_taskbar = true,
      sticky = true,
      placement = awful.placement.centered,
    }
  },

  {
    rule = { instance = "scratch-terminal" },
    properties = {
      width = function(c) return c.screen.workarea.width * 0.8 end,
      height = function(c) return c.screen.workarea.height * 0.6 end,
    }
  },

  {
    rule = { instance = "scratch-notes" },
    properties = {
      width = function(c) return c.screen.workarea.width * 0.6 end,
      height = function(c) return c.screen.workarea.height * 0.7 end,
    }
  },

  {
    rule = { class = "Gnome-calculator" },
    properties = {
      floating = true,
      ontop = true,
      above = true,
      skip_taskbar = true,
      placement = awful.placement.centered,
      width = function(c) return c.screen.workarea.width * 0.3 end,
      height = function(c) return c.screen.workarea.height * 0.4 end,
    }
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

  -- Nautilus na Tag 5
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

  -- Telegram e Discord na Tag 6
  {
    rule_any = {
      class = { 
        "TelegramDesktop", 
        "telegram-desktop", 
        "Telegram",
        "Discord", 
        "discord",
        "DiscordCanary",
        "discord-canary"
      },
    },
    properties = {
      screen = 1,
      tag = "󰍹",
      callback = function(c)
        local tag = awful.tag.find_by_name(awful.screen.focused(), "󰍹")
        if tag then
          c:move_to_tag(tag)
        end
      end,
    },
  },

  -- Terminal: APENAS o primeiro vai para Tag 1, demais ficam onde abriram
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
        -- Função para contar terminais na tag 1 específicamente
        local function count_terminals_in_tag1()
          local tag1 = awful.tag.find_by_name(awful.screen.focused(), "󰨞")
          if not tag1 then
            return 0
          end

          local count = 0
          for _, client in ipairs(tag1:clients()) do
            if is_terminal(client) and client ~= c then -- Exclui o cliente atual
              count = count + 1
            end
          end
          return count
        end

        -- Se não há terminais na tag 1, este vai para lá
        -- Caso contrário, fica na tag atual (onde foi aberto)
        local terminals_in_tag1 = count_terminals_in_tag1()
        
        if terminals_in_tag1 == 0 then
          -- Primeiro terminal: obrigatoriamente na Tag 1
          local tag1 = awful.tag.find_by_name(awful.screen.focused(), "󰨞")
          if tag1 then
            c:move_to_tag(tag1)
          end
        end
        -- Demais terminais: ficam onde foram abertos (não fazemos nada)
      end,
    },
  },
}
