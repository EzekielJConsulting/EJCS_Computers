fx_version 'adamant'
game 'gta5'

author 'EzekielJ Development Studios'
description 'Immersive Complex in-game computer system'
version '0.0.1'

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
    'client/main.lua'
}

ui_page {
    "ui/html/dist/index.html"
 }
 
 files {
    "ui/html/dist/index.html",
    "ui/html/dist/js/*.*",
    "ui/html/dist/css/*.*"
 }
 


dependencies {
    'es_extended',
    'qtarget',
    
}
