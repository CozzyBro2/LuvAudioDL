local Module = {}

local Config = require("src/config")

function Module.run(_, Map)
    local Concat = {}

    for Name in pairs(Map) do
        local CommandTip = Config[string.format(Config.help_command_prefix, Name)]

        table.insert(Concat, string.format(

            Config.help_command_format,

            Name,
            CommandTip

        ))
    end

    print(string.format(Config.help_wrapper, table.concat(Concat, "\n")))
end

return Module