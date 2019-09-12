API_BASE="https://hc-ping.com"
CURL_OPTS="-fsS --retry 3"

hc_get() {
    curl "${CURL_OPTS}" "${API_BASE}/${1}"
}

hc_start() {
    uuid="${1}"
    http_get "${uuid}/start"
}

hc_fail() {
    uuid="${1}"
    http_get "${uuid}/fail"
}

hc_success() {
    uuid="${1}"
    http_get "${uuid}"
}
