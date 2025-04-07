local libs = require("cores.libs")

local function check_battery()
  local battery = libs.upower.get_battery()

  if battery then
    local level = battery:get_property("percentage")
    if level < 20 then
      -- Executar ação quando o nível de bateria for baixo
      libs.naughty.notify({ title = "Bateria baixa", text = "O nível de bateria está abaixo de 20%" })
    end
  end
end


return {
  check_battery = check_battery()
}
