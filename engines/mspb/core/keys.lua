local mods = require("core.mods")
local vars = require("core.vars")
local menu = require("core.menu")

local M = {
	globalkeys = mods.gears.table.join(
		-- show help {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"s",
			mods.hotkeys_popup.show_help,
			{
				description = "show help",
				group = "awesome",
			}
		),
		-- }}}
		-- view previous {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"Left",
			mods.awful.tag.viewprev,
			{
				description = "view previous",
				group = "tag",
			}
		),
		-- }}}
		-- view next {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"Right",
			mods.awful.tag.viewnext,
			{
				description = "view next",
				group = "tag",
			}
		),
		-- }}}
		-- go back {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"Escape",
			mods.awful.tag.history.restore,
			{
				description = "go back",
				group = "tag",
			}
		),
		-- }}}
		-- focus next by index {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"j",
			function()
				mods.awful.client.focus.byidx(1)
			end,
			{
				description = "focus next by index",
				group = "client",
			}
		),
		-- }}}
		-- focus previous by index {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"k",
			function()
				mods.awful.client.focus.byidx(-1)
			end,
			{
				description = "focus previous by index",
				group = "client",
			}
		),
		-- }}}
		-- show main menu {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"w",
			function()
				vars.menu(menu)["mymainmenu"]:show()
			end,
			{
				description = "show main menu",
				group = "awesome",
			}
		),
		-- }}}
		-- swap with next client by index {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"j",
			function()
				mods.awful.client.swap.byidx(1)
			end,
			{
				description = "swap with next client by index",
				group = "client",
			}
		),
		-- }}}
		-- swap with previous client by index {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"k",
			function()
				mods.awful.client.swap.byidx(-1)
			end,
			{
				description = "swap with previous client by index",
				group = "client",
			}
		),
		-- }}}
		-- focus the next screen {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"j",
			function()
				mods.awful.screen.focus_relative(1)
			end,
			{
				description = "focus the next screen",
				group = "screen",
			}
		),
		-- }}}
		-- focus the previous screen {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"k",
			function()
				mods.awful.screen.focus_relative(-1)
			end,
			{
				description = "focus the previous screen",
				group = "screen",
			}
		),
		-- }}}
		-- jump to urgent client {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"u",
			mods.awful.client.urgent.jumpto,
			{
				description = "jump to urgent client",
				group = "client",
			}
		),
		-- }}}
		-- go back {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"Tab",
			function()
				mods.awful.client.focus.history.previous()
				if client.focus then
					client.focus:raise()
				end
			end,
			{
				description = "go back",
				group = "client",
			}
		),
		-- }}}
		-- open a terminal {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"Return",
			function()
				mods.awful.spawn(vars.terminal)
			end,
			{
				description = "open a terminal",
				group = "launcher",
			}
		),
		-- }}}
		-- new tmux session {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"t",
			function()
				mods.awful.spawn.with_shell(vars.terminal .. " -e tmux")
			end,
			{
				description = "new tmux session",
				group = "launcher",
			}
		),
		-- }}}
		-- kitty terminal {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"t",
			function()
				mods.awful.spawn("kitty", {
					floating = true,
					placement = mods.awful.placement.centered,
				})
			end,
			{
				description = "kitty terminal",
				group = "launcher",
			}
		),
		-- }}}
		-- reload awesome {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"r",
			awesome.restart,
			{
				description = "reload awesome",
				group = "awesome",
			}
		),
		-- }}}
		-- quit awesome {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"q",
			awesome.quit,
			{
				description = "quit awesome",
				group = "awesome",
			}
		),
		-- }}}
		-- increase master width factor {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"l",
			function()
				mods.awful.tag.incmwfact(0.05)
			end,
			{
				description = "increase master width factor",
				group = "layout",
			}
		),
		-- }}}
		-- decrease master width factor {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"h",
			function()
				mods.awful.tag.incmwfact(-0.05)
			end,
			{
				description = "decrease master width factor",
				group = "layout",
			}
		),
		-- }}}
		-- increase the number of master clients {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"h",
			function()
				mods.awful.tag.incnmaster(1, nil, true)
			end,
			{
				description = "increase the number of master clients",
				group = "layout",
			}
		),
		-- }}}
		-- decrease the number of master clients {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"l",
			function()
				mods.awful.tag.incnmaster(-1, nil, true)
			end,
			{
				description = "decrease the number of master clients",
				group = "layout",
			}
		),
		-- }}}
		-- increase the number of columns {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"h",
			function()
				mods.awful.tag.incncol(1, nil, true)
			end,
			{
				description = "increase the number of columns",
				group = "layout",
			}
		),
		-- }}}
		-- decrease the number of columns {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"l",
			function()
				mods.awful.tag.incncol(-1, nil, true)
			end,
			{
				description = "decrease the number of columns",
				group = "layout",
			}
		),
		-- }}}
		-- select next {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"space",
			function()
				mods.awful.layout.inc(1)
			end,
			{
				description = "select next",
				group = "layout",
			}
		),
		-- }}}
		-- select previous {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"space",
			function()
				mods.awful.layout.inc(-1)
			end,
			{
				description = "select previous",
				group = "layout",
			}
		),
		-- }}}
		-- restore minimized {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"n",
			function()
				local c = mods.awful.client.restore()
				if c then
					c:emit_signal("request::activate", "key.unminimize", { raise = true })
				end
			end,
			{
				description = "restore minimized",
				group = "client",
			}
		),
		-- }}}
		-- run prompt {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"r",
			function()
				mods.awful.screen.focused().mypromptbox:run()
			end,
			{
				description = "run prompt",
				group = "launcher",
			}
		),
		-- }}}
		-- lua execute prompt {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"x",
			function()
				mods.awful.prompt.run({
					prompt = "Run Lua code: ",
					textbox = mods.awful.screen.focused().mypromptbox.widget,
					exe_callback = mods.awful.util.eval,
					history_path = mods.awful.util.get_cache_dir() .. "/history_eval",
				})
			end,
			{
				description = "lua execute prompt",
				group = "awesome",
			}
		),
		-- }}}
		-- show the menubar {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"p",
			function()
				mods.awful.spawn("dmenu_run")
			end,
			{
				description = "show the menubar",
				group = "launcher",
			}
		),
		-- }}}
		-- browse the web {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"b",
			function()
				mods.awful.spawn("chromium")
			end,
			{
				description = "browse the web",
				group = "launcher",
			}
		)
	),
	clientkeys = mods.gears.table.join(
		-- }}}
		-- toggle fullscreen {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"f",
			function(c)
				c.fullscreen = not c.fullscreen
				c:raise()
			end,
			{
				description = "toggle fullscreen",
				group = "client",
			}
		),
		-- }}}
		-- close {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"c",
			function(c)
				c:kill()
			end,
			{
				description = "close",
				group = "client",
			}
		),
		-- }}}
		-- toggle floating {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"space",
			mods.awful.client.floating.toggle,
			{
				description = "toggle floating",
				group = "client",
			}
		),
		-- }}}
		-- move to master {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"Return",
			function(c)
				c:swap(mods.awful.client.getmaster())
			end,
			{
				description = "move to master",
				group = "client",
			}
		),
		-- }}}
		-- move to screen {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"o",
			function(c)
				c:move_to_screen()
			end,
			{
				description = "move to screen",
				group = "client",
			}
		),
		-- }}}
		-- toggle keep on top {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"t",
			function(c)
				c.ontop = not c.ontop
			end,
			{
				description = "toggle keep on top",
				group = "client",
			}
		),
		-- }}}
		-- minimize {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"n",
			function(c)
				c.minimized = true
			end,
			{
				description = "minimize",
				group = "client",
			}
		),
		-- }}}
		-- (un)maximize {{{
		mods.awful.key(
			{
				vars.modkey,
			},
			"m",
			function(c)
				c.maximized = not c.maximized
				c:raise()
			end,
			{
				description = "(un)maximize",
				group = "client",
			}
		),
		-- }}}
		-- (un)maximize vertically {{{
		mods.awful.key(
			{
				vars.modkey,
				"Control",
			},
			"m",
			function(c)
				c.maximized_vertical = not c.maximized_vertical
				c:raise()
			end,
			{
				description = "(un)maximize vertically",
				group = "client",
			}
		),
		-- }}}
		-- (un)maximize horizontally {{{
		mods.awful.key(
			{
				vars.modkey,
				"Shift",
			},
			"m",
			function(c)
				c.maximized_horizontal = not c.maximized_horizontal
				c:raise()
			end,
			{
				description = "(un)maximize horizontally",
				group = "client",
			}
		)
		-- }}}
	),
	clientbuttons = mods.gears.table.join(
		-- mouse: activate {{{
		mods.awful.button({}, 1, function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
		end),
		-- }}}
		-- mouse: select {{{
		mods.awful.button({ vars.modkey }, 1, function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			mods.awful.mouse.client.move(c)
		end),
		-- }}}
		-- mouse: resize {{{
		mods.awful.button({ vars.modkey }, 3, function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			mods.awful.mouse.client.resize(c)
		end)
		-- }}}
	),
}

return M
