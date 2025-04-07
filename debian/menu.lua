-- automatically generated file. Do not edit (see /usr/share/doc/menu/html)

local awesome = awesome

Debian_menu = {}

Debian_menu["Debian_Aplicativos_Ciência_Matemática"] = {
	{"Bc", "x-terminal-emulator -e ".."/usr/bin/bc"},
	{"Dc", "x-terminal-emulator -e ".."/usr/bin/dc"},
}
Debian_menu["Debian_Aplicativos_Ciência"] = {
	{ "Matemática", Debian_menu["Debian_Aplicativos_Ciência_Matemática"] },
}
Debian_menu["Debian_Aplicativos_Rede_Navegação_Web"] = {
	{"Google Chrome","/opt/google/chrome/google-chrome","/opt/google/chrome/product_logo_32.xpm"},
	{"w3m", "x-terminal-emulator -e ".."/usr/bin/w3m /usr/share/doc/w3m/MANUAL.html"},
}
Debian_menu["Debian_Aplicativos_Rede"] = {
	{ "Navegação Web", Debian_menu["Debian_Aplicativos_Rede_Navegação_Web"] },
}
Debian_menu["Debian_Aplicativos_Shells"] = {
	{"Bash", "x-terminal-emulator -e ".."/bin/bash --login"},
	{"Dash", "x-terminal-emulator -e ".."/bin/dash -i"},
	{"Sh", "x-terminal-emulator -e ".."/bin/sh --login"},
}
Debian_menu["Debian_Aplicativos_Sistema_Administração"] = {
	{"Editres","editres"},
	{"Xfontsel","xfontsel"},
	{"Xkill","xkill"},
}
Debian_menu["Debian_Aplicativos_Sistema_Monitoramento"] = {
	{"Xev","x-terminal-emulator -e xev"},
}
Debian_menu["Debian_Aplicativos_Sistema"] = {
	{ "Administração", Debian_menu["Debian_Aplicativos_Sistema_Administração"] },
	{ "Monitoramento", Debian_menu["Debian_Aplicativos_Sistema_Monitoramento"] },
}
Debian_menu["Debian_Aplicativos"] = {
	{ "Ciência", Debian_menu["Debian_Aplicativos_Ciência"] },
	{ "Rede", Debian_menu["Debian_Aplicativos_Rede"] },
	{ "Shells", Debian_menu["Debian_Aplicativos_Shells"] },
	{ "Sistema", Debian_menu["Debian_Aplicativos_Sistema"] },
}
Debian_menu["Debian_Gerenciadores_de_Janelas"] = {
	{"awesome",function () awesome.exec("/usr/bin/awesome") end,"/usr/share/pixmaps/awesome.xpm"},
}
Debian_menu["Debian"] = {
	{ "Aplicativos", Debian_menu["Debian_Aplicativos"] },
	{ "Gerenciadores de Janelas", Debian_menu["Debian_Gerenciadores_de_Janelas"] },
}

debian = { menu = { Debian_menu = Debian_menu } }
return debian