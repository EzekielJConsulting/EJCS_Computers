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

ui_page 'web/build/index.html'
 
files {
    'web/build/index.html',
    'web/build/**/*'
}

dependencies {
    'es_extended',
    'qtarget',
    
}
