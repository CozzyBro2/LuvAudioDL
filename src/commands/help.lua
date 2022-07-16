local Module = {}

--local Printer = require("pretty-print")
local Config = require("src/config")

function Module.run(_, Map)
    local Concat = {}

    for Name in pairs(Map) do
        table.insert(Concat, string.format(

            Config.help_command_format,
            Name,
            Config[string.format(Config.help_command_prefix, Name)]

        ))
    end

    print(string.format(Config.help_wrapper, table.concat(Concat, "\n")))
end

return Module