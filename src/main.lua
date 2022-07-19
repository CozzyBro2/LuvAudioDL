local Prompt = require('prompt') {}
local Config = require('config') ()

print(Config.welcome_message)

while true do
    local Response = Prompt(Config.prompt_message)
end