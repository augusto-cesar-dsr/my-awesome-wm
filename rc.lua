-- AwesomeWM Configuration
-- Modular and organized setup

pcall(require, "luarocks.loader")

-- Core awesome libraries
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Error handling
require("config.error-handling")

-- Variables and layouts (carregado ANTES do tema)
require("config.variables")

-- Theme (agora pode usar as variáveis globais)
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/custom/theme.lua")

-- Dynamic Theme (initialize after base theme)
local dynamic_theme = require("config.dynamic-theme")

-- UI Components
require("config.ui.menu")
require("config.ui.wibar")
require("config.ui.notifications")

-- Key bindings
require("config.keys.global")
require("config.keys.client")

-- Scratchpads
require("config.scratchpads")

-- Rules
require("config.rules")

-- Signals
require("config.signals")

-- Autostart applications
require("config.autostart")

-- Start dynamic theming (after everything is loaded)
dynamic_theme.auto_start()
