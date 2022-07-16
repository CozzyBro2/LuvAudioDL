local Module = {}

local Config = require("src/config")

local Spawn = require("coro-spawn")
local Uv = require("uv")

function Module.run(Arguments)
    local Query = Arguments[2]

    if string.sub(Query, 1, 5) ~= "https" and Config.add_enable_ytsearch then
        print([[Does not look like a url, using `ytsearch`.]])

        Query = "ytsearch:" .. Query
    end

    local Started = Uv.hrtime()
    print(string.format(Config.bold_format, [[Attempting download...]]))

    local Child = Spawn("yt-dlp", {
        args = {

            "-e",
            "-x",
            "-q",

            "--no-simulate",
            "--verbose",
            "--restrict-filenames",

            Query,

        },

        stdio = {nil, true, true},
    })

    local Code = Child.waitExit()

    if Code == 0 then
        local TimeTaken = (Uv.hrtime() - Started) / 1e9
        local Title = Child.stdout.read()

        print(string.format(

            "Downloaded %s in %s",

            Title,
            string.format(Config.bold_format, string.format("%.2fs", TimeTaken)))

        )

        return true
    end

    return error(string.format("Bad exit code recieved, stderr:", Child.stderr.read()))
end

return Module