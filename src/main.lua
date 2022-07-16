local Prompt = require("prompt") {}
local Printer = require("pretty-print")

local CommandMap = require("./commands/init").Map
local Config = require("./config")

local function ParseFlags(Arguments, Input)
    for Argument in string.gmatch(Input, Config.flag_match) do
        Arguments[Argument] = true
    end
end

Printer.print(Config.welcome_message)

while true do
    local Arguments = {}
    local Command

    local Input = Prompt(Config.prompt_message):lower()

    for Argument in string.gmatch(Input, Config.argument_match) do
        local CommandModule = CommandMap[Argument]

        if CommandModule and not Command then
            Command = CommandModule
        end

        Arguments[Argument] = true
    end

    if Command then
        ParseFlags(Arguments, Input)

        Command.run(Arguments)
    end
end