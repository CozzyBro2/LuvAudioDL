local Prompt = require("prompt") {}

local CommandMap = require("./commands/mapper").Map
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

        table.insert(Arguments, Argument)
    end

    if Command then
        local state, err = pcall(Command.run, Arguments, CommandMap)

        if not state then
            print(string.format(Config.error_format, string.format("[ERROR] Command failed with error: \n%s", err)))
        end
    end
end

print(string.format(Config.bold_format, Config.welcome_message))

while true do
    GetInput()
end