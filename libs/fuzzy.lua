local Module = {}

local Playlists = require('audioConfig').playlists
local Config = require('config')

local function SearchPlaylists(Query)
    local BestDistance = 0
    local BestPlaylist

    for Name, Playlist in pairs(Playlists) do
        local Distance = string.levenshtein(Name, Query)

        if Distance > BestDistance then
            BestPlaylist = Distance

            BestPlaylist = Playlist
        end
    end

    return BestPlaylist
end

function Module.getPlaylist(PlaylistName)
    local Playlist = Playlists[PlaylistName]

    if not Playlist then
        Playlist = SearchPlaylists(PlaylistName)
    end

    return Playlist
end

function Module.getAudio(AudioName)

end

return Module