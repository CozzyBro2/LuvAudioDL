local Module = {}

local Config = require('config')

function Module.run()
    print('Displaying help message..\n')

    local Concat = {}

    for _, Command in ipairs(Config._help_map) do
        local FormattedName = Config.boldify(Command.name)
        local Segment = Config._help_format:format(FormattedName, Command.tip)

        table.insert(Concat, Segment)
    end

    print(table.concat(Concat, '\n\n'))
end

return Module