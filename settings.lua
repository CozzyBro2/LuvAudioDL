Config = {

    _welcome_message = [[Welcome to LuvAudioDL, type 'help' to get help.]],
    _goodbye_message = [[See ya]],

    _command_invalid_format = [[Command %s invalid]],
    _subcommand_invalid_format = [[Sub-command %s invalid]],

    _error_format = "[ERROR] Command failed with error: \n%s",
    _warn_format = "[WARNING] %s",

    _prompt_message = "",

    _command_gmatch = "%S+",

    _flag_symbol = "-",
    _option_symbol = "--",

    _commands_map = {

        q = "exit",
        quit = "exit",
        exit = "exit",

        help = "help",
        h = "help",

        playlist = "playlist",
        lists = "playlist"

    },

    _help_map = {

        exit = [[Exits the prompt, if you're in one.
        
        --silent: no goodbye message :c
        ]],

        help = [[Shows this command.]],
        playlist = [[Manages your playlists. 
        
        make:
                Makes playlists. 
                
                --force: ignores things like duplication checks and writes anyway. 
                            
        remove:
                Removes playlists.
        list:
                Lists your playlists
        ]]
    },

    _help_format = "%s\n%s"
}

local error_color = "\27[1;31m%s\27[0m"
local warn_color = "\27[1;33m%s\27[0m"
local bold_color = "\27[1;37m%s\27[0m"

function Config.errorify(Message)
    local Base = Config._error_format:format(Message)

    return error_color:format(Base)
end

function Config.warnify(Message)
    local Base = Config._warn_format:format(Message)

    return warn_color:format(Base)
end

function Config.boldify(Message)
    return bold_color:format(Message)
end

return Config