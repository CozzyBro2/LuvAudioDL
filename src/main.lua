local Prompt = require("prompt") {}

local CommandMap = require("./commands/init").Map
local Config = require("./config")

local function GetInput()
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
        Command.run(Arguments, CommandMap)
    end
end

print(string.format(Config.welcome_format, Config.welcome_message))

while true do
    GetInput()
end