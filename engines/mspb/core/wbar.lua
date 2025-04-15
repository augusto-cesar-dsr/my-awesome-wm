local mods = require("core.mods")
local vars = require("core.vars")
local menu = require("core.menu")

-- Create a mods.wibox for each screen and add it
local taglist_buttons = mods.gears.table.join(
	mods.awful.button({}, 1, function(t)
		t:view_only()
	end),
	mods.awful.button({ vars.modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	mods.awful.button({}, 3, mods.awful.tag.viewtoggle),
	mods.awful.button({ vars.modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	mods.awful.button({}, 4, function(t)
		mods.awful.tag.viewnext(t.screen)
	end),
	mods.awful.button({}, 5, function(t)
		mods.awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = mods.gears.table.join(
	mods.awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	mods.awful.button({}, 3, function()
		mods.awful.menu.client_list({ theme = { width = 250 } })
	end),
	mods.awful.button({}, 4, function()
		mods.awful.client.focus.byidx(1)
	end),
	mods.awful.button({}, 5, function()
		mods.awful.client.focus.byidx(-1)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if mods.beautiful.wallpaper then
		local wallpaper = mods.beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		mods.gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

mods.awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	mods.awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, mods.awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = mods.awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = mods.awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(mods.gears.table.join(
		mods.awful.button({}, 1, function()
			mods.awful.layout.inc(1)
		end),
		mods.awful.button({}, 3, function()
			mods.awful.layout.inc(-1)
		end),
		mods.awful.button({}, 4, function()
			mods.awful.layout.inc(1)
		end),
		mods.awful.button({}, 5, function()
			mods.awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = mods.awful.widget.taglist({
		screen = s,
		filter = mods.awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = mods.awful.widget.tasklist({
		screen = s,
		filter = mods.awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the mods.wibox
	s.mywibox = mods.awful.wibar({ position = "top", screen = s })

	-- Add widgets to the mods.wibox
	s.mywibox:setup({
		layout = mods.wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = mods.wibox.layout.fixed.horizontal,
			vars.menu(menu)["mylauncher"],
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = mods.wibox.layout.fixed.horizontal,
			mods.awful.widget.keyboardlayout(),
			mods.wibox.widget.textclock(),
			s.mylayoutbox,
		},
	})
end)
