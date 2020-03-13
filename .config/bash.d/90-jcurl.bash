# shellcheck shell=bash
jcurl() {
    curl -s "$@" | jq
}
