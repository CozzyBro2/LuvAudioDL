local Module = {}

local Config = require('config')

local Commands = {

    exit = require('./exit'),
    help = require('./help'),
    playlist = require("./playlist"),

}

function Module.run(Arguments, Flags)
    local Name = Arguments[1]

    if Name then
        local RealName = Config._commands_map[Name]

        if RealName then
            local Command = Commands[RealName]

            if Command then
                Command.run(Arguments, Flags)

                return true
            end
        end
    end

    print(Config.warnify(Config._command_invalid_format:format(Name)))
end

return Module