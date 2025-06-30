-- Scratchpads configuration
local awful = require("awful")
local gears = require("gears")

local scratchpads = {}

-- Scratchpad state tracking
local scratchpad_clients = {}

-- Helper function to find client by class
local function find_client_by_class(class_patterns)
  for _, c in ipairs(client.get()) do
    if c.class then
      for _, pattern in ipairs(class_patterns) do
        if c.class:lower():match(pattern:lower()) then
          return c
        end
      end
    end
  end
  return nil
end

-- Generic scratchpad toggle function
local function toggle_scratchpad(cmd, class_patterns, geometry_func)
  local c = find_client_by_class(class_patterns)
  
  if c then
    -- Client exists, toggle visibility
    if c.hidden or c.minimized or not c.visible then
      -- Show client
      c.hidden = false
      c.minimized = false
      c:emit_signal("request::activate", "scratchpad", {raise = true})
      c:raise()
    else
      -- Hide client
      c.hidden = true
    end
  else
    -- Client doesn't exist, spawn it
    awful.spawn(cmd, {
      floating = true,
      ontop = true,
      above = true,
      skip_taskbar = true,
      callback = function(new_c)
        -- Apply geometry when client appears
        if geometry_func then
          local geom = geometry_func(new_c)
          new_c:geometry(geom)
        end
        new_c.floating = true
        new_c.ontop = true
        new_c.above = true
        new_c.skip_taskbar = true
        new_c:emit_signal("request::activate", "scratchpad", {raise = true})
      end
    })
  end
end

-- Terminal scratchpad
scratchpads.terminal = {
  toggle = function()
    toggle_scratchpad(
      terminal,
      {"terminal", "gnome%-terminal", "alacritty", "kitty", "xterm"},
      function(c)
        local screen_geometry = c.screen.workarea
        return {
          x = screen_geometry.x + screen_geometry.width * 0.1,
          y = screen_geometry.y,
          width = screen_geometry.width * 0.8,
          height = screen_geometry.height * 0.6
        }
      end
    )
  end
}

-- Calculator scratchpad
scratchpads.calculator = {
  toggle = function()
    toggle_scratchpad(
      "gnome-calculator",
      {"calculator", "gnome%-calculator"},
      function(c)
        local screen_geometry = c.screen.workarea
        return {
          x = screen_geometry.x + screen_geometry.width * 0.35,
          y = screen_geometry.y + screen_geometry.height * 0.3,
          width = screen_geometry.width * 0.3,
          height = screen_geometry.height * 0.4
        }
      end
    )
  end
}

-- Notes scratchpad (using nvim)
scratchpads.notes = {
  toggle = function()
    toggle_scratchpad(
      terminal .. " -e nvim /tmp/awesome_notes.md",
      {"terminal", "gnome%-terminal", "alacritty", "kitty", "xterm"},
      function(c)
        local screen_geometry = c.screen.workarea
        return {
          x = screen_geometry.x + screen_geometry.width * 0.2,
          y = screen_geometry.y + screen_geometry.height * 0.15,
          width = screen_geometry.width * 0.6,
          height = screen_geometry.height * 0.7
        }
      end
    )
  end
}

return scratchpads
