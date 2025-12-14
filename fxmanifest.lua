fx_version 'cerulean'
game 'gta5'

author 'Rubber Duck Scripts (RDS)'
description 'RDS Custom Weapon Crafting'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}
