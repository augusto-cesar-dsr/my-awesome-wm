local libs = require("cores.libs")
local layouts = require("layouts")
local themes = require("themes.currents")

local layout = layouts.criar_layout()

libs.awful.layout.set(layout)
libs.beautiful.init(themes.custom)
