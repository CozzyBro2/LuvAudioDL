local Module = {}

local Config = require('config')

function Module.run()
    print('Displaying help message..\n')

    local Concat = {}

    for CommandName, Message in pairs(Config._help_map) do
        local FormattedName = Config.boldify(CommandName)
        local Segment = Config._help_format:format(FormattedName, Message)

        table.insert(Concat, Segment)
    end

    print(table.concat(Concat, '\n\n'))
    print([[Command aliases/shorthands are listed in 'user_config.json']])
end

return Module