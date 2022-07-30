local Module = {}
local SubCommands = {}

local Uv = require('uv')
local Spawn = require('coro-spawn')
local Split = require('split')

local Config = require('config')
local AudioConfig = require('audioConfig')
local Fuzzy = require('fuzzy')
local PlaylistManager = require('./playlist')

local Playlists = AudioConfig.playlists

local spawn_failed = "Couldn't spawn audio downloader, make sure you have it and it's available"
local download_failed = "Couldn't download using audio downloader, stderr: \n%s"
local playlist_not_exist = [[Playlist "%s" does not exist, can't add to it. (use -f to override)]]

local finished_feedback = 'Finished in %.2fs'
local title_feedback = [[Fetched title "%s" successfully]]
local download_feedback = 'Downloading "%s"'
local searcher_format = '%s:%s'

local function getArguments(Class, Query)
    local NewArguments = {}

    for _, Argument in ipairs(Class) do
        table.insert(NewArguments, Argument)
    end

    table.insert(NewArguments, Query)
    return NewArguments
end

local function isUrl(Str)
    return Str:sub(1, 4) == 'http'
end

local function spawnDownloader(Arguments)
    local Child = Spawn(Config.audio_downloader, {

        args = Arguments,
        stdio = {nil, true, true},
        cwd = Config.audio_storage_path,

    })

    if not Child then
        return error(spawn_failed, 0)
    end

    local ExitCode = Child.waitExit()

    if ExitCode ~= 0 then
        error(download_failed:format(Child.stderr.read()), 0)
    end

    return Child
end

local function getAudio(Query)
    local Arguments = getArguments(Config.downloader_arguments, Query)

    print(Config.boldify(download_feedback:format(Query)))

    local Child = spawnDownloader(Arguments)

    local Chunk = Child.stdout.read()
    local Output = Split(Chunk)

    print('Downloaded & parsed succesfully')

    return Output[1]
end

local function getTitle(Query)
    local Arguments = getArguments(Config.downloader_title_arguments, Query)

    print('Fetching audio title')

    local Child = spawnDownloader(Arguments)

    local Chunk = Child.stdout.read()
    local Output = Split(Chunk)

    local Title = Output[1]
    print(Config.boldify(title_feedback:format(Title)))

    return Title
end

function SubCommands.add(Arguments, Flags)
    local Query = Arguments[3]
    local PlaylistArgument = Arguments[4]

    local PlaylistName = PlaylistArgument or Flags['--playlist']
    local Playlist = Fuzzy.get(PlaylistName)

    if not Playlist then
        if Flags['-f'] then
            PlaylistManager.run({"playlist", "create", PlaylistName}, {})
        else
            print(Config.warnify(playlist_not_exist:format(PlaylistName)))

            return
        end
    end

    if not isUrl(Query) then
        local Searcher = Flags['--searcher'] or Config.default_searcher

        Query = searcher_format:format(Searcher, Query)
    end

    local Start = Uv.hrtime()

    getAudio(Query)

    table.insert(Playlist.audios, {

        name = getTitle(Query),
        genre = Flags['--genre'],

    })

    print(finished_feedback:format((Uv.hrtime() - Start) / 1e9))
    AudioConfig.write()
end

function SubCommands.remove(Arguments, Flags)

end

function Module.run(Arguments, Flags)
    local SubName = Arguments[2]
    local Sub = SubCommands[SubName]

    if Sub then
        Sub(Arguments, Flags)
    else
        print(Config.warnify(Config._subcommand_invalid_format:format(SubName)))
    end
end

SubCommands.add = SubCommands.add
SubCommands.download = SubCommands.add
SubCommands.get = SubCommands.add
SubCommands.new = SubCommands.add

SubCommands.remove = SubCommands.remove
SubCommands.rm = SubCommands.remove
SubCommands.r = SubCommands.remove
SubCommands.del = SubCommands.remove

return Module