local awful = require("cores.libs").awful

local function criar_layout()
  local layout = awful.layout.suit.tile
  layout.name = "Meu Layout"
  return layout
end

return {
  criar_layout = criar_layout
}
