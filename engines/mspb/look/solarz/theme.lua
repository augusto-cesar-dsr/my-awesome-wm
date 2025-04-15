--[[
  An Awesome WM theme based on the zenburn theme
  By Marcelo Barboza
--]]

local vars = require("core.vars")
local themes_path = vars.theme_path("solarz")
local dpi = require("beautiful.xresources").apply_dpi

local color = {
	base3 = "#002b36",
	base2 = "#073642",
	base1 = "#586e75",
	base0 = "#657b83",
	base00 = "#839496",
	base01 = "#93a1a1",
	base02 = "#eee8d5",
	base03 = "#fdf6e3",
	yellow = "#b58900",
	orange = "#cb4b16",
	red = "#dc322f",
	magenta = "#d33682",
	violet = "#6c71c4",
	blue = "#268bd2",
	cyan = "#2aa198",
	green = "#859900",
}

-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. "wall.png"
-- }}}

-- {{{ Styles
theme.font = "Terminess Nerd Font Mono 9"

-- {{{ Colors
theme.fg_normal = color.base01
theme.fg_focus = color.base03
theme.fg_urgent = color.base3
theme.bg_normal = color.base3
theme.bg_focus = color.base1
theme.bg_urgent = color.red
theme.bg_systray = color.base3
-- }}}

-- {{{ Borders
theme.useless_gap = dpi(6)
theme.border_width = dpi(2)
theme.border_normal = color.base2
theme.border_focus = color.green
theme.border_marked = color.red
-- }}}

-- {{{ Menu
theme.menu_height = dpi(20)
theme.menu_width = dpi(120)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel = themes_path .. "taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "taglist/squarez.png"
-- }}}

-- {{{ Misc
theme.awesome_icon = themes_path .. "icon.png"
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile = themes_path .. "layouts/tile.png"
theme.layout_max = themes_path .. "layouts/max.png"
-- }}}
-- }}}

theme.tasklist_disable_icon = true

return theme

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
