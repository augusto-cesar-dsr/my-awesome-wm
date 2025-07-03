-- Widgets collection
local widgets = {}

-- Import individual widgets
widgets.cpu = require("config.ui.widgets.cpu")
widgets.memory = require("config.ui.widgets.memory")
widgets.network = require("config.ui.widgets.network")
widgets.volume = require("config.ui.widgets.volume")
widgets.temperature = require("config.ui.widgets.temperature")
widgets.battery = require("config.ui.widgets.battery")
widgets.pomodoro = require("config.ui.widgets.pomodoro")
widgets.weather = require("config.ui.widgets.weather")
widgets.picom_control = require("config.ui.widgets.picom-control")

return widgets
