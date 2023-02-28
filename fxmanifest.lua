fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

ui_page 'index.html'

files {
  'index.html',
  'js/script.js',
  'css/style.css'
}

client_script 'client.lua'

export 'taskBar'
export 'closeGuiFail'