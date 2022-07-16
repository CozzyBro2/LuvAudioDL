local Module = {}

local Printer = require("pretty-print")
local Config = require("src/config")

function Module.run()
    Printer.print(Config.help_message)
end

return Module