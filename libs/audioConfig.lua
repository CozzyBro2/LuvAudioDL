local Json = require('json')
local Fs = require('fs')

local Text, Err = Fs.readFileSync('audio_config.json')
assert(Text, string.format([[Can't read audio config file, error: %s]], Err))

local Data = Json.decode(Text)
local Module = {}

function Module.write()
    print('(writing changes to audio config)')

    local NewText = Json.encode(Data)

    Fs.writeFileSync('audio_config.json', NewText)

    print('(wrote changes to audio config)')
end

Module.data = Data

return setmetatable(Module, {__index = Data})