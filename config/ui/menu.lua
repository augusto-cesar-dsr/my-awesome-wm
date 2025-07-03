-- Menu configuration
local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox = require("wibox")

-- Create a launcher widget and a main menu
local myawesomemenu = {
  {
    "hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "manual",      terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart",     awesome.restart },
  {
    "quit",
    function()
      awesome.quit()
    end,
  },
}

local mymainmenu = awful.menu({
  items = {
    { "awesome",      myawesomemenu, beautiful.awesome_icon },
    {
      "applications",
      function()
        awful.spawn("rofi -show drun")
      end,
    },
    { "terminal",     terminal },
    { "browser",      browser },
    { "file manager", file_manager },
  },
})

-- Create skull launcher as textbox widget
local skull_textbox = wibox.widget {
  markup = '<span font="16">💀</span>',
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
}

-- Make it clickable
skull_textbox:buttons(awful.button({}, 1, function() 
  mymainmenu:toggle() 
end))

local mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu,
})

-- Export
return {
  menu = mymainmenu,
  launcher = mylauncher,
  skull_launcher = skull_textbox,
}
