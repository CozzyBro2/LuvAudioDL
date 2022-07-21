require('helpful')('string')

local Prompt = require('prompt') {}

local Commands = require('commands/init.lua')
local Parser = require('parser')
local Config = require('config')

local PromptEnabled = false

local function handleCommand(Input)
    local Arguments, Flags = Parser.parseCommand(Input)
    local Success, Err = pcall(Commands.run, Arguments, Flags)

    if not Success then
        print(Config.errorify(Err))

        os.exit()
    end
end

local function startPrompt()
    PromptEnabled = true
    print(Config.boldify(Config._welcome_message))

    while PromptEnabled do
        local Response = Prompt(Config._prompt_message)

        handleCommand(Response)
    end
end

if args[2] then
    handleCommand(args)
else
    startPrompt()
end