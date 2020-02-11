#!/bin/sh


## Help message
usage() {
    cat <<USAGE
Generate an Ansible role skeleton for a generic Linux service/daemon.

Usage: $(basename "${0}") [-h] <name> <service name> [<roles directory>]
  -h                  this message
  <name>              the name of the role (e.g. apache-web-server)
  <service name>      the name used (e.g. by systemctl) to manage
                      the service
  <roles directory>   the directory in which to create the role
                      (default is "roles")

USAGE
}

## Logging Functions
msg() {
    echo "$*"
}

errormsg() {
    msg "ERROR: $*"
}

warnmsg() {
    msg "WARN: $*"
}

infomsg() {
    msg "INFO: $*"
}

debugmsg() {
    msg "DEBUG: $*"
}

## Template Functions
yaml_header() {
    cat <<YAML
---
# ${*}

YAML
}


#
# main
#
ROLE="${1}"
SERVICE_NAME="${2}"
ROLES_DIR="${3:-roles}"

test "${1}" = "-h" -o "${1}" = "--help" && usage && exit 0
test -z "${ROLE}" -o -z "${SERVICE_NAME}" && usage && exit 1
test ! -d "${ROLES_DIR}" && errormsg "Unable to find roles directory: ${ROLES_DIR}" && exit 1
DEST="${ROLES_DIR}/${ROLE}"
test -e "${DEST}" && errormsg "Role already exists: ${DEST}" && exit 1
ROLE_CONFIG="$(echo "${ROLE}" | tr '-' '_')_config"

# Make defaults
infomsg "Creating defaults in ${DEST}/defaults"
mkdir -p "${DEST}/defaults"
DEFAULTS="${DEST}/defaults/main.yaml"
# shellcheck disable=2094
yaml_header "${DEFAULTS}" > "${DEFAULTS}"
cat <<EODEFAULTS >> "${DEFAULTS}"
${ROLE_CONFIG}:
  dependencies: []
  packages: []
  firewall_ports: []
  service_name: ${SERVICE_NAME}
EODEFAULTS

# Make tasks
infomsg "Creating tasks in ${DEST}/tasks"
mkdir -p "${DEST}/tasks"
TASKS="${DEST}/tasks/main.yaml"
# shellcheck disable=2094
yaml_header "${TASKS}" > "${TASKS}"
cat <<EOTASKS >> "${TASKS}"
- name: ENSURE DEPENDENCIES ARE INSTALLED
  package:
    name: "{{ ${ROLE_CONFIG}['dependencies'] }}"
  notify:
    - restart ${SERVICE_NAME}
  tags:
    - ${ROLE}

- name: ENSURE PACKAGES ARE INSTALLED
  package:
    name: "{{ ${ROLE_CONFIG}['packages'] }}"
  notify:
    - restart ${SERVICE_NAME}
  tags:
    - ${ROLE}

- name: ENSURE FIREWALL PORTS ARE OPEN
  firewalld:
    port: "{{ item }}"
    state: enabled
    permanent: yes
    immediate: yes
  loop: "{{ ${ROLE_CONFIG}['firewall_ports'] }}"
  tags:
    - ${ROLE}

- name: ENSURE SERVICE IS CONFIGURED TO START ON BOOT
  service:
    name: "{{ ${ROLE_CONFIG}['service_name'] }}"
    enabled: yes
  tags:
    - ${ROLE}

- name: ENSURE SERVICE IS RUNNING
  service:
    name: "{{ ${ROLE_CONFIG}['service_name'] }}"
    state: started
  tags:
    - ${ROLE}
EOTASKS

# Make handlers
infomsg "Creating handlers in ${DEST}/handlers"
mkdir -p "${DEST}/handlers"
HANDLERS="${DEST}/handlers/main.yaml"
# shellcheck disable=2094
yaml_header "${HANDLERS}" > "${HANDLERS}"
cat <<EOHANDLERS >> "${HANDLERS}"
- name: restart ${SERVICE_NAME}
  service:
    name: "{{ ${ROLE_CONFIG}['service_name'] }}"
    state: restarted
EOHANDLERS

# Make templates
mkdir -p "${DEST}/templates"

# Make files
mkdir -p "${DEST}/files"
