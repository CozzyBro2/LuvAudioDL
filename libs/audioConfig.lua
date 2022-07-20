local Config = require('config')

local Json = require('json')
local Fs = require('fs')

local config_path = Config.config_path
local default_config_path = Config.default_config_path

local file_error = Config._file_error

local Exists = Fs.existsSync(config_path)
local Text

local function safeRead(Path)
    local Result, Err = Fs.readFileSync(Path)
    assert(not Err, file_error:format('read', Err))

    return Result
end

local function safeWrite(Path, ToWrite)
    local Success, Err = Fs.writeFileSync(Path, ToWrite)

    assert(Success, file_error:format('write', Err))
end

if not Exists then
    local Backup = safeRead(default_config_path)

    safeWrite(config_path, Backup)
    Text = Backup
end

if not Text then
    Text = safeRead(config_path)
end

local Data = Json.decode(Text)
local Module = {}

function Module.write()
    print('(writing changes to audio config)')

    local NewText = Json.encode(Data)
    safeWrite(config_path, NewText)

    print('(wrote changes to audio config)')
end

Module.data = Data

return setmetatable(Module, {__index = Data})