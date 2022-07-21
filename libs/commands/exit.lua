local Module = {}

local Config = require('config')

function Module.run(_, Flags)
    if not Flags['-s'] then
        print(Config._goodbye_message)
    end

    os.exit()
end

return Module