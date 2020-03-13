# shellcheck shell=bash
ytmp3() {
    youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --output "%(title)s.%(ext)s" "$@"
}
