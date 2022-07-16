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

    Concat = table.concat(Concat, "\n")
    --Printer.print(string.format(Config.help_wrapper, Concat))
    --Printer.prettyPrint(string.format(Config.help_wrapper, Concat))
    print(string.format(Config.help_wrapper, Concat))
end

return Module