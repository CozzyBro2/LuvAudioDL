Config = {

    -- NOTE: These CANNOT be relative paths, e.g:
    -- no: ~/luvaudiodl/config,
    -- yes: /home/${USER}/luvaudiodl/config

    config_path = 'audio_config.json',
    default_config_path = 'defaults/default_audio_config.json',
    audio_storage_path = 'audio',

    -- prefix for the search query if it doesn't look like a url, e.g: 'ytsearch:crowntheempirememories'
    -- yt-dlp can support a few of these, visit it's docs for a list
    default_searcher = 'ytsearch',

    -- yt-dlp by default, can use youtube-dl too but yt-dlp seems to be faster
    audio_downloader = 'yt-dlp',

    -- arguments to pass to downloader, search query is always appended to be last
    downloader_arguments = {

        '-x',
        '--sponsorblock-remove',
        'all',
        '-o %(title)s.%(ext)s'

    },

    -- arguments to pass to downloader when fetching media title
    downloader_title_arguments = {

        '--get-title',
        '--simulate'

    },

    -- audio player to use to play your audio
    -- vlc by default, i recommend cvlc but most people won't have that
    audio_backend = 'vlc',

    -- arguments to pass to backend, audio file is always appended to be last
    audio_backend_arguments = {

        '--play-and-exit',

    },

    error_color = '\27[1;31m%s\27[0m',
    warn_color = '\27[1;33m%s\27[0m',
    bold_color = '\27[1;37m%s\27[0m',

    _welcome_message = [[Welcome to LuvAudioDL, type 'help' to get help.]],
    _goodbye_message = [[See ya]],

    _command_invalid_format = [[Command %s invalid]],
    _subcommand_invalid_format = [[Sub-command %s invalid]],

    _file_error = [[Can't %s file, error: %s]],
    _error_format = "[ERROR] Command failed with error: \n%s",
    _warn_format = "[WARNING] %s",

    _prompt_message = '',

    _command_gmatch = '%S+',

    _flag_symbol = '-',
    _option_symbol = '--',

    _commands_map = {

        q = 'exit',
        quit = 'exit',
        exit = 'exit',

        help = 'help',
        h = 'help',

        playlist = 'playlist',
        lists = 'playlist',
        l = 'playlist',

        song = 'audio',
        music = 'audio',
        sound = 'audio',
        audio = 'audio',

        p = 'playback',
        playback = 'playback',
        play = 'playback',
        player = 'playback',

    },

    _help_map = {

        {name = 'help', tip = [[Shows this command.]]},
        {name = 'exit', tip = [[Exits the prompt, if you're in one.
        
        -s: no goodbye message :c

        ]]},

        {name = 'playlist', tip = [[Manages your playlists. 
        
        make <NAME> :

                Makes a new playlist with a name. 
                
                -f: ignores things like duplication checks and writes anyway. 
                            
        remove <NAME> :

                Removes a playlist by name

                <NAME> can be fuzzy searched if no exact match is found.

        list :

                Lists all your playlists.

        ]]},

        {name = 'audio', tip = [[Manages your audio. 
        
        add <URL/SEARCH_QUERY> <PLAYLIST_NAME> :
    
                Downloads audio and adds it to a playlist. 
                This can be fetched either through a URL, or a search query.

                <PLAYLIST_NAME> can be fuzzy searched if no exact match is found,

                -f: ignores things like playlist existing checks and makes one if needed, etc.
                --playlist: specify the playlist to use, incase you want to download multiple audios'
                --genre: unused, but you can tag your audio with genres to help make identification easier
                --searcher: lets you pick the query prefix for downloading, "ytsearch:" by default. 
                            
        remove <NAME> <PLAYLIST_NAME> :

                Removes audio from a playlist by name.
    
                <NAME> can be fuzzy searched if no exact match is found,
                if you don't specify a playlist, it'll look through all of them for the most similar song.

        list:

                Lists your playlists

        ]]},

    },

    _help_format = "%s\n%s"
}


function Config.errorify(Message)
    local Base = Config._error_format:format(Message)

    return Config.error_color:format(Base)
end

function Config.warnify(Message)
    local Base = Config._warn_format:format(Message)

    return Config.warn_color:format(Base)
end

function Config.boldify(Message)
    return Config.bold_color:format(Message)
end

return Config