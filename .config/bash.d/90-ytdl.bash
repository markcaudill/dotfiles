# shellcheck shell=bash
ytdl() {
    youtube-dl -f bestvideo+bestaudio "$@"
}
