fx_version 'adamant'
game 'gta5'

author 'EzekielJ Development Studios'
description 'Immersive Complex in-game computer system'
version '0.0.1'

shared_scripts {

}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua'
}
client_scripts {
    'config.lua',
}
files {
    'ui/*',
}


dependencies {
    'es_extended',
    'qtarget',
    
}
