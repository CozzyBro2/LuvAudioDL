local Json = require('json')
local Fs = require('fs')

local config_name = 'audio_config.json'
local default_config_name = 'defaults/default_audio_config.json'

local cant_read = [[Can't read %s file, error: %s]]

local Exists = Fs.existsSync(config_name)
local Text

if not Exists then
    local Backup, Err = Fs.readFileSync(default_config_name)
    assert(not Err, cant_read:format(default_config_name, Err))

    Fs.writeFileSync(config_name, Backup)
    Config = Backup
end

if not Text then
    Text, Err = Fs.readFileSync(config_name)

    assert(Text, cant_read:format(config_name, Err))
end

local Data = Json.decode(Text)
local Module = {}

function Module.write()
    print('(writing changes to audio config)')

    local NewText = Json.encode(Data)

    Fs.writeFileSync(config_name, NewText)

    print('(wrote changes to audio config)')
end

Module.data = Data

return setmetatable(Module, {__index = Data})