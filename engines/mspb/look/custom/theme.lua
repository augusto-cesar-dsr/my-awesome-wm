--[[
  An Awesome WM theme based on the zenburn theme
  By Marcelo Barboza
--]]

local vars = require("core.vars")
local themes_path = vars.theme_path("custom")
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. "wall.png"
-- }}}

-- {{{ Styles
theme.font = "Terminess Nerd Font Mono 9"

-- {{{ Colors
theme.fg_normal = "#DCDCCC"
theme.fg_focus = "#F0DFAF"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#3F3F3F"
theme.bg_focus = "#1E2320"
theme.bg_urgent = "#3F3F3F"
theme.bg_systray = "#3F3F3F"
-- }}}

-- {{{ Borders
theme.useless_gap = dpi(6)
theme.border_width = dpi(2)
theme.border_normal = "#3F3F3F"
theme.border_focus = "#6F6F6F"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
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
