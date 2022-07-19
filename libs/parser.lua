local Module = {}

local Config = require('config')

local function getArguments(Input)
    local Arguments = {}

    if type(Input) == 'string' then
        for _, Argument in Input:gmatch(Config._command_gmatch) do
            table.insert(Arguments, Argument)
        end
    elseif type(Input) == 'table' then
        Input[0] = nil
        table.remove(Input, 1)

        Arguments = Input
    end

    return Arguments
end

function Module.parseCommand(Input)
    local Arguments = getArguments(Input)

    local NewArgs = {}
    local Flags = {}

    local Blacklist = {}

    for Index, Flag in ipairs(Arguments) do
        local IsFlag = Flag:sub(1, 1) == Config._flag_symbol

        if IsFlag then
            local IsOption = Flag:sub(1, 2) == Config._option_symbol
            local Value = true

            if IsOption then
                local ArgumentIndex, Argument = next(Arguments, Index)

                if Argument then
                    Blacklist[ArgumentIndex] = true

                    Value = Argument
                end
            end

            Blacklist[Index] = true
            Flags[Flag] = Value
        end

        if not Blacklist[Index] then
            table.insert(NewArgs, Flag)
        end
    end

    return NewArgs, Flags
end

return Module