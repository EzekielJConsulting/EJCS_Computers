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
    'client/main.lua',
    'client/utils.lua'
}

ui_page 'ui/build/index.html'
 
 files {
    files {
        'ui/build/index.html',
        'ui/build/**/*'
      }
 }

dependencies {
    'es_extended',
    'qtarget',
    
}
