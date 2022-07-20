local Module = {}
local SubCommands = {}

local Prompt = require('prompt') {}
local Config = require('config')
local AudioConfig = require('audioConfig')

local Playlists = AudioConfig.playlists

local playlist_feedback = 'Making a playlist named "%s"'
local playlist_already_exists = 'Playlist named "%s" already exists, not creating'

local playlist_cant_delete = 'Playlist %s does not exist, not deleting anything'
local playlist_delete_confirmation = 'Playlist "%s" is not empty, please be sure whether you want to delete it.'
local playlist_delete_feedback = 'Deleting "%s"'

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
    local PlaylistName = Arguments[3]

    print(Config.boldify(playlist_feedback:format(PlaylistName)))

    if Playlists[PlaylistName] and not Flags['--force'] and not Flags['-f'] then
        print(Config.warnify(playlist_already_exists:format(PlaylistName)))

        return
    end

    Playlists[PlaylistName] = MakePlaylist()
    AudioConfig.write()
end

function SubCommands.delete(Arguments, Flags)
    local PlaylistName = Arguments[3]
    local Playlist = Playlists[PlaylistName]

    if not Playlist then
        print(Config.warnify(playlist_cant_delete):format(PlaylistName))

        return
    end

    if next(Playlist.audios) then
        print(Config.warnify(playlist_delete_confirmation):format(PlaylistName))

        local Confirmation = Prompt('Are you? [y/n]')

        if Confirmation == 'n' then
            return
        end
    end

    print(Config.boldify(playlist_delete_feedback):format(PlaylistName))

    Playlists[PlaylistName] = nil
    AudioConfig.write()
end

function SubCommands.list(Arguments, Flags)
    local Concat = {}

    for PlaylistName, Contents in pairs(Playlists) do
        table.insert(Concat, Config.boldify(PlaylistName))

        local AudioConcat = {}

        for _, Audio in ipairs(Contents.audios) do
            table.insert(AudioConcat, '    ' .. Audio.name)
        end

        table.insert(Concat, table.concat(AudioConcat, '\n'))
    end

    print(table.concat(Concat, '\n'))
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