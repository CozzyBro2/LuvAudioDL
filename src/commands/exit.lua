local Module = {}

local Printer = require("pretty-print")

function Module.run(Arguments)
    if not Arguments["-s"] then
        Printer.print("Be seeing ya")
    end

    os.exit()
end

return Module