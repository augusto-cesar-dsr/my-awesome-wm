-- Dynamic Theme for AwesomeWM
-- Generated automatically from wallpaper colors
-- Theme: day
-- Generated: ter 01 jul 2025 12:08:55 -03

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

-- Colors extracted from wallpaper
theme.primary_color = "#48dbfb"
theme.secondary_color = "#feca57"
theme.accent_color = "#ff6b6b"

-- Base colors
theme.bg_normal = "#f8f9fa"
theme.bg_focus = "#e9ecef"
theme.bg_urgent = theme.accent_color
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#212529"
theme.fg_focus = "#000000"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- Borders
theme.useless_gap = dpi(4)
theme.border_width = dpi(2)
theme.border_normal = theme.bg_focus
theme.border_focus = theme.primary_color
theme.border_marked = theme.accent_color

-- Wibar
theme.wibar_bg = theme.bg_normal .. "ee"  -- Semi-transparent
theme.wibar_fg = theme.fg_normal
theme.wibar_height = dpi(26)

-- Taglist
theme.taglist_bg_focus = theme.primary_color
theme.taglist_fg_focus = "#ffffff"
theme.taglist_bg_occupied = theme.bg_focus
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_bg_empty = "transparent"
theme.taglist_fg_empty = theme.fg_normal
theme.taglist_spacing = dpi(2)
theme.taglist_font = "JetBrainsMonoNL Nerd Font Medium 11"

-- Tasklist
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_bg_normal = "transparent"
theme.tasklist_fg_normal = theme.fg_normal

-- Notifications
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_border_color = theme.primary_color
theme.notification_border_width = dpi(2)
theme.notification_shape = function(cr, width, height)
    return require("gears.shape").rounded_rect(cr, width, height, dpi(8))
end

-- Menu
theme.menu_bg_normal = theme.bg_normal
theme.menu_bg_focus = theme.primary_color
theme.menu_fg_normal = theme.fg_normal
theme.menu_fg_focus = "#ffffff"
theme.menu_border_color = theme.border_focus
theme.menu_border_width = dpi(1)
theme.menu_height = dpi(20)
theme.menu_width = dpi(150)

-- Fonts
theme.font = "JetBrainsMonoNL Nerd Font Medium 10"
theme.taglist_font = theme.taglist_font
theme.notification_font = theme.font

-- Widget colors (for dynamic theming)
theme.widget_primary = theme.primary_color
theme.widget_secondary = theme.secondary_color
theme.widget_accent = theme.accent_color
theme.widget_bg = theme.bg_focus
theme.widget_fg = theme.fg_normal

-- Awesome icon
theme.awesome_icon = themes_path.."default/awesome-icon.png"

-- Layout icons (use default for now)
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

return theme
