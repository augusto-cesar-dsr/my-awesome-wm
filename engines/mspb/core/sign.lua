local mods = require("core.mods")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then mods.awful.client.setslave(c) end
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		mods.awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = mods.gears.table.join(
		mods.awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			mods.awful.mouse.client.move(c)
		end),
		mods.awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			mods.awful.mouse.client.resize(c)
		end)
	)

	mods.awful.titlebar(c):setup({
		{ -- Left
			mods.awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = mods.wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = mods.awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = mods.wibox.layout.flex.horizontal,
		},
		{ -- Right
			mods.awful.titlebar.widget.floatingbutton(c),
			mods.awful.titlebar.widget.maximizedbutton(c),
			mods.awful.titlebar.widget.stickybutton(c),
			mods.awful.titlebar.widget.ontopbutton(c),
			mods.awful.titlebar.widget.closebutton(c),
			layout = mods.wibox.layout.fixed.horizontal(),
		},
		layout = mods.wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = mods.beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
	c.border_color = mods.beautiful.border_normal
end)
