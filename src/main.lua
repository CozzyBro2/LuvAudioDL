local Prompt = require('prompt') {}

local Parser = require('parser')
local Config = require('config')

local PromptEnabled = false

local function handleCommand(Input)
    local Arguments, Flags = Parser.parseCommand(Input)

    p(Arguments, Flags)
end

local function startPrompt()
    PromptEnabled = true
    print(Config._welcome_message)

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