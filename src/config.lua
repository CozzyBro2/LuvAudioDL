return {

    bold_format = "\27[1;37m%s\27[0m",
    error_format = "\27[1;31m%s\27[0m",

    welcome_message = [[Welcome to the interactive prompt for LuvMusicDL, type "help" (no quotes) for help.]],
    prompt_message = [[What to do? ]],

    help_wrapper = "%s",

    help_command_prefix = "%s_help",
    help_command_format = "\n \27[1;37m%s\27[0m\n %s \n",

    help_help = [[Shows this]],
    exit_help = [[Exits the prompt]],

    add_help = [[Downloads audio
    add <URL>
    ]],

    add_enable_ytsearch = true,

    -- gmatch pattern to use for detecting commands and their arguments
    -- default: "%S+"
    argument_match = "%S+",

    -- audio backend
    -- default: "cvlc" (cli vlc)
    audio_backend = "cvlc",

    -- ..and it's arguments
    -- %s = audio file
    -- to achieve something like: `vlc -e %s` you can just append "-e", to this array.

    backend_arguments = {

        "--play-and-exit",
        "%s",

    },

    audio_working_directory = "./audio",

    
}