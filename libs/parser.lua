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
    local Flags = {}

    for Index, Flag in ipairs(Arguments) do
        local IsFlag = Flag:sub(1, 1) == Config._flag_symbol

        if IsFlag then
            local IsOption = Flag:sub(1, 2) == Config._option_symbol
            local Value = true

            if IsOption then
                local _, Argument = next(Arguments, Index)

                if Argument then
                    Value = Argument
                else
                    error(Config._unfufilled_option:format(Flag))
                end
            end

            Flags[Flag] = Value
        end
    end

    return Arguments, Flags
end

return Module