local Config = require('config')

local Json = require('json')
local Fs = require('fs')

local config_path = Config.config_path
local default_config_path = Config.default_config_path

local file_error = Config._file_error

local Exists = Fs.existsSync(config_path)
local Text

if not Exists then
    local Backup, Err = Fs.readFileSync(default_config_path)
    assert(not Err, file_error:format('read', Err))

    local Success, Err = Fs.writeFileSync(config_path, Backup)
    assert(Success, file_error:format('write', Err))

    Text = Backup
end

if not Text then
    Text, Err = Fs.readFileSync(config_path)

    assert(Text, file_error:format('read', Err))
end

local Data = Json.decode(Text)
local Module = {}

function Module.write()
    print('(writing changes to audio config)')

    local NewText = Json.encode(Data)

    local Success, Err = Fs.writeFileSync(config_path, NewText)
    assert(Success, file_error:format('write', Err))

    print('(wrote changes to audio config)')
end

Module.data = Data

return setmetatable(Module, {__index = Data})