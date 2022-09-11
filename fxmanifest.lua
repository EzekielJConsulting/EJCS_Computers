fx_version 'adamant'
game 'gta5'

author 'EzekielJ Development Studios'
description 'Immersive Complex in-game computer system'
version '0.0.1'
lua54 'yes'

shared_scripts {

}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/functions.lua',
    'server/main.lua'
}
client_scripts {
    'config.lua',
    'client/main.lua',
    'client/utils.lua'
}

ui_page "web/dist/index.html"

files {
    "web/dist/*.html",
    "web/dist/assets/*.js",
    "web/dist/assets/*.css",
    "web/dist/assets/*.png",
    "web/dist/assets/*.jpg",
    "web/dist/assets/*.gif",
    "web/dist/assets/*.webp",
    "web/dist/assets/*.svg",
    "web/dist/assets/*.jpeg",
}

dependencies {
    'es_extended',
    'qtarget',
    
}
