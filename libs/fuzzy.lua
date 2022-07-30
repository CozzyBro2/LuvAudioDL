local Module = {}

local Playlists = require('audioConfig').playlists
local Config = require('config')

local audio_search_failed = [[Audio search for "%s" turned up no result.]]

local function IsBest(CurrentBest, First, Second)
    local Distance = string.levenshtein(First, Second)

    if Distance > CurrentBest then
        return Distance
    end
end

local function SearchForPlaylist(Query)
    local BestDistance = 0
    local BestPlaylist

    for Name, Playlist in pairs(Playlists) do
        local NewBest = IsBest(BestDistance, Name, Query)

        if NewBest then
            BestDistance = NewBest

            BestPlaylist = Playlist
        end
    end

    return BestPlaylist
end

function Module.getPlaylist(PlaylistName)
    local Playlist = Playlists[PlaylistName]

    if not Playlist then
        Playlist = SearchForPlaylist(PlaylistName)
    end

    return Playlist
end

function Module.getAudio(AudioName, PlaylistName)
    local FoundPlaylist = Playlists[PlaylistName]

    local BestDistance = 0
    local BestAudio

    if PlaylistName and not FoundPlaylist then
        FoundPlaylist = Module.getPlaylist(PlaylistName)
    end

    local function GetBestAudio(Playlist)
        for _, Audio in ipairs(Playlist.audios) do
            local NewBest = IsBest(BestDistance, Audio.name, AudioName)

            if NewBest then
                BestDistance = NewBest

                BestAudio = Audio
            end
        end
    end

    if FoundPlaylist then
        GetBestAudio(FoundPlaylist)
    else
        for _, Playlist in pairs(Playlists) do
            GetBestAudio(Playlist)
        end
    end

    if BestAudio then
        return BestAudio
    end

    error(audio_search_failed:format(AudioName), 0)
end

return Module