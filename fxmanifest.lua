fx_version "cerulean"
game "gta5"

description "kopruhgs"
author "AlphaCarry"
version "1.0.0"
lua54 "yes"

shared_scripts {
    "config.lua"
}

client_scripts {
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "@PolyZone/EntityZone.lua",
    "@PolyZone/CircleZone.lua",
    "@PolyZone/ComboZone.lua",
    "client/zones.lua",
    "client/main.lua"
}

server_script { 
		"server/main.lua",
		'@mysql-async/lib/MySQL.lua',
}
