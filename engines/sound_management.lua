local libs = require("engines.cores.libs")

local function increase_volume()
    local volume = libs.pulseaudio.get_volume() + 3
    libs.pulseaudio.set_volume(volume)
end

local function decrease_volume()
    local volume = libs.pulseaudio.get_volume() - 3
    libs.pulseaudio.set_volume(volume)
end

local function mute_volume()
    libs.pulseaudio.mute()
end

return {
  increase_volume = increase_volume(),
  decrease_volume = decrease_volume(),
  mute_volume = mute_volume(),
}
