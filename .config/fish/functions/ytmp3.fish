function ytmp3 --description "Convert YouTube URL to an MP3"
    youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --output "%(title)s.%(ext)s" $argv
end
