fx_version 'cerulean'
game 'gta5'

author 'Virgil big thug straight out da opps block type shit'
description 'Put the phone down, THIS IS FOR MY SAFETY'
version '1.0.0'
lua54 'yes'

shared_script {
    'config.lua',
    '@ox_lib/init.lua'
}

client_script {
    'client/*.lua'
}

server_script {
    'server/main.lua'
}

dependencies {
    'ox_lib'
}
