local Module = {}
local SubCommands = {}

local Config = require('config')
local AudioConfig = require('audioConfig')

local Playlists = AudioConfig.playlists

local playlist_feedback = 'Making a playlist named "%s"'
local playlist_already_exists = 'Playlist named "%s" already exists, not creating'

local function MakePlaylist()
    return {

        audios = {},

    }
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

function SubCommands.create(Arguments, Flags)
    local PlaylistName = Arguments[2]
    print(playlist_feedback:format(PlaylistName))

    if Playlists[PlaylistName] then
        print(Config.warnify(playlist_already_exists:format(PlaylistName)))

        return
    end

    Playlists[PlaylistName] = MakePlaylist()
    AudioConfig.write()
end

function SubCommands.delete(Arguments, Flags)

end

function SubCommands.list(Arguments, Flags)

end

SubCommands.make = SubCommands.create
SubCommands.mk = SubCommands.create
SubCommands.m = SubCommands.create
SubCommands.new = SubCommands.create

SubCommands.remove = SubCommands.delete
SubCommands.rm = SubCommands.delete
SubCommands.r = SubCommands.delete
SubCommands.del = SubCommands.delete

SubCommands.ls = SubCommands.list
SubCommands.l = SubCommands.list

return Module