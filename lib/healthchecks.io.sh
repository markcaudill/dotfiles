# Cron monitoring tool
# https://healthchecks.io/
# https://github.com/healthchecks/healthchecks

API_BASE="https://hc-ping.com"
CURL_OPTS="-fsS --retry 3"

hc_get() {
    curl ${CURL_OPTS} "${API_BASE}/${1}" > /dev/null
}

hc_start() {
    uuid="${1:-${HCUUID}}"
    hc_get "${uuid}/start"
}

hc_fail() {
    uuid="${1:-${HCUUID}}"
    hc_get "${uuid}/fail"
}

hc_success() {
    uuid="${1:-${HCUUID}}"
    hc_get "${uuid}"
}
