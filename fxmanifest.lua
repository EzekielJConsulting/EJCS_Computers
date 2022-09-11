fx_version 'adamant'
game 'gta5'

author 'EzekielJ Development Studios'
description 'Immersive Complex in-game computer system'
version '0.0.1'
lua54 'yes'

shared_scripts {
    'config.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/functions.lua',
    'server/main.lua'
}
client_scripts {
    'client/main.lua',
    'client/utils.lua'
}

ui_page "web/build/index.html"

files {
    "web/build/**/*",
    "web/build/**/**/*",
    "web/build/**/**/**/*",
    "web/build/img/settings/Bluetooth & devices.webp"

}

dependencies {
    'es_extended',
    'qtarget',
    
}
