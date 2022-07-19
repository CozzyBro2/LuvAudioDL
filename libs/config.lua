local Json = require('json')
local Fs = require('fs')

return function()
    local Text, Err = Fs.readFileSync('user_config.json')
    assert(Text, string.format([[Can't read config file, error: %s]], Err))

    return Json.decode(Text)
end