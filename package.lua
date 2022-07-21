  return {
    name = "LuvAudioDL",
    version = "0.0.1",
    description = "Youtube DL audio player written in Luvit",
    tags = { "lua", "lit", "luvit", "youtube-dl", "yt-dlp", "music", "audio", "audio-player" },
    license = "Unlicense",
    author = { name = "CozzyBro2", email = "gojinhan2@gmail.com" },
    homepage = "https://github.com/LuvAudioDL",
    dependencies = {
      "creationix/prompt@2.0.1",
      "creationix/coro-spawn@3.0.2",
    },
    files = {
      "**.lua",
      "!test*"
    }
  }