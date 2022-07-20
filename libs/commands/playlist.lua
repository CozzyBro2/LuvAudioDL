local Module = {}
local SubCommands = {}

local Config = require('config')
local AudioConfig = require('audioConfig')

function Module.run(Arguments, Flags)
    local SubName = Arguments[2]
    local Sub = SubCommands[SubName]

    if Sub then
        Sub(Arguments, Flags)
    else
        print(Config.warnify(Config._subcommand_invalid_format:format(SubName)))
    end
end

function SubCommands.create(Arguments, Flags)
    table.insert(AudioConfig.playlists, {test = true})
    -- ^ do playlist stuff here

    AudioConfig.write()
end

function SubCommands.delete(Arguments, Flags)

end

function SubCommands.list(Arguments, Flags)

end

SubCommands.make = SubCommands.create
SubCommands.mk = SubCommands.create
SubCommands.m = SubCommands.create
SubCommands.new = SubCommands.create

SubCommands.remove = SubCommands.delete
SubCommands.rm = SubCommands.delete
SubCommands.r = SubCommands.delete
SubCommands.del = SubCommands.delete

SubCommands.ls = SubCommands.list
SubCommands.l = SubCommands.list

return Module