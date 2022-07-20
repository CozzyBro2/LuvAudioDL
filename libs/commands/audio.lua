local Module = {}
local SubCommands = {}

local Config = require('config')

function Module.run(Arguments, Flags)
    local SubName = Arguments[2]
    local Sub = SubCommands[SubName]

    if Sub then
        Sub(Arguments, Flags)
    else
        print(Config.warnify(Config._subcommand_invalid_format:format(SubName)))
    end
end

function SubCommands.add(Arguments, Flags)

end

function SubCommands.remove(Arguments, Flags)

end

SubCommands.add = SubCommands.add
SubCommands.download = SubCommands.add
SubCommands.get = SubCommands.add
SubCommands.new = SubCommands.add

SubCommands.remove = SubCommands.remove
SubCommands.rm = SubCommands.remove
SubCommands.r = SubCommands.remove
SubCommands.del = SubCommands.remove

return Module