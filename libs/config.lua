local Json = require('json')
local Fs = require('fs')

local Text, Err = Fs.readFileSync('user_config.json')
assert(Text, string.format([[Can't read config file, error: %s]], Err))

local Config = Json.decode(Text)

local error_color = "\27[1;31m%s\27[0m"
local warn_color = "\27[1;33m%s\27[0m"
local bold_color = "\27[1;37m%s\27[0m"

function Config.errorify(Message)
    local Base = Config._error_format:format(Message)

    return error_color:format(Base)
end

function Config.warnify(Message)
    local Base = Config._warn_format:format(Message)

    return warn_color:format(Base)
end

function Config.boldify(Message)
    return bold_color:format(Message)
end

return Config