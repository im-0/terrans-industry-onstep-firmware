#!/bin/bash

set -x -e -u -o pipefail

REPO_URL="https://github.com/hjd1964/SmartWebServer"
# Date:   Tue Jul 21 11:38:54 2026
COMMIT="193a81809f5b19b3afa2a8c58f18291c2f0b0475"

FQBN="esp8266:esp8266:d1:xtal=80,vt=flash,exception=disabled,ssl=all,eesz=4M3M,ip=lm2f,dbg=Disabled,lvl=None____,wipe=none,baud=921600"

ARDUINO_CLI_DIR="${HOME}/.arduino-cli-bin"

export PATH="${ARDUINO_CLI_DIR}:${PATH}"

if [ ! -e "./SmartWebServer" ]; then
    git clone \
            --depth 1 \
            --revision "${COMMIT}" \
            "${REPO_URL}" "./SmartWebServer"

    if ls ./SmartWebServer-changes/*.patch >/dev/null 2>&1; then
        ls -1 ./SmartWebServer-changes/*.patch | while read patch; do
            set -x -e -u -o pipefail

            patch="${PWD}/${patch}"
            patch --directory "./SmartWebServer" --strip 1 <"${patch}"
        done
    fi

    [ -e "./SmartWebServer-changes/files" ] && cp \
            --force \
            --recursive \
            --verbose \
            "./SmartWebServer-changes/files/." "./SmartWebServer"
fi

arduino-cli compile \
        --fqbn "${FQBN}" \
        --export-binaries \
        --verbose \
        "./SmartWebServer"
