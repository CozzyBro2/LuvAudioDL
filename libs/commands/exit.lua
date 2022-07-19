local Module = {}

local Config = require('config')

function Module.run()
    print(Config._goodbye_message)

    os.exit()
end

return Module