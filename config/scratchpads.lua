-- Scratchpads configuration using modern scratch library
local scratch = require("lib.scratch")

local scratchpads = {}

-- Terminal scratchpad
scratchpads.terminal = {
  toggle = function()
    scratch.toggle(terminal .. " -name scratch-terminal", {instance = "scratch-terminal"})
  end
}

-- Calculator scratchpad
scratchpads.calculator = {
  toggle = function()
    scratch.toggle("gnome-calculator", {class = "Gnome-calculator"})
  end
}

-- Notes scratchpad (using nvim)
scratchpads.notes = {
  toggle = function()
    scratch.toggle(terminal .. " -name scratch-notes -e nvim /tmp/awesome_notes.md", {instance = "scratch-notes"})
  end
}

return scratchpads
