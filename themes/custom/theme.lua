---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- local gfs = require("gears.filesystem")
local themes_path = os.getenv("HOME") .. "/.config/awesome/themes/"

local theme = {}

theme.font = "JetBrainsMonoNL Nerd Font Medium 8"

theme.bg_normal = "#1a1a1a"
theme.bg_focus = "#2d2416"
theme.bg_urgent = "#8b2635"
theme.bg_minimize = "#2a2a2a"
theme.bg_systray = "#1a1a1a"

theme.fg_normal = "#d4af37"
theme.fg_focus = "#ffd700"
theme.fg_urgent = "#ff6b6b"
theme.fg_minimize = "#8a8a8a"

theme.useless_gap = dpi(0)
theme.border_width = dpi(1)
theme.border_normal = "#3d3d3d"
theme.border_focus = "#d4af37"
theme.border_marked = "#8b2635"

-- There are other variable sets
-- overriding the custom one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Configurações específicas para taglist (ícones das tags)
theme.taglist_font = "JetBrainsMonoNL Nerd Font Medium 8"
theme.taglist_spacing = dpi(1)
theme.taglist_shape_border_width = dpi(1)
theme.taglist_shape_border_color = theme.border_normal

-- Configurações adicionais para melhor renderização dos ícones
theme.taglist_bg_focus = "#2d2416"
theme.taglist_fg_focus = "#ffd700"
theme.taglist_bg_occupied = "#1f1f1f"
theme.taglist_fg_occupied = "#d4af37"
theme.taglist_bg_empty = "transparent"
theme.taglist_fg_empty = "#4a4a4a"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "custom/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "custom/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "custom/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "custom/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "custom/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "custom/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "custom/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "custom/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "custom/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "custom/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "custom/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "custom/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "custom/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "custom/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "custom/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "custom/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "custom/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "custom/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "custom/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "custom/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "custom/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "custom/samurai-yellow-moon.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "custom/layouts/fairh.png"
theme.layout_fairv = themes_path .. "custom/layouts/fairv.png"
theme.layout_floating = themes_path .. "custom/layouts/floating.png"
theme.layout_magnifier = themes_path .. "custom/layouts/magnifier.png"
theme.layout_max = themes_path .. "custom/layouts/max.png"
theme.layout_fullscreen = themes_path .. "custom/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path .. "custom/layouts/tilebottom.png"
theme.layout_tileleft = themes_path .. "custom/layouts/tileleft.png"
theme.layout_tile = themes_path .. "custom/layouts/tile.png"
theme.layout_tiletop = themes_path .. "custom/layouts/tiletop.png"
theme.layout_spiral = themes_path .. "custom/layouts/spiral.png"
theme.layout_dwindle = themes_path .. "custom/layouts/dwindle.png"
theme.layout_cornernw = themes_path .. "custom/layouts/cornernw.png"
theme.layout_cornerne = themes_path .. "custom/layouts/cornerne.png"
theme.layout_cornersw = themes_path .. "custom/layouts/cornersw.png"
theme.layout_cornerse = themes_path .. "custom/layouts/cornerse.png"
theme.tasklist_disable_icon = true

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
