-- Widgets collection
local widgets = {}

-- Import individual widgets
widgets.cpu = require("config.ui.widgets.cpu")
widgets.memory = require("config.ui.widgets.memory")
widgets.network = require("config.ui.widgets.network")
widgets.volume = require("config.ui.widgets.volume")

return widgets
