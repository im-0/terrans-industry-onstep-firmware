#!/bin/bash

set -x -e -u -o pipefail

REPO_URL="https://github.com/hjd1964/OnStepX"
# Date:   Fri Aug 7 11:07:40 2026
COMMIT="d4874283ab74e390329b007f253595138e617752"

FQBN="esp32:esp32:esp32:CPUFreq=240,FlashFreq=80,FlashMode=qio,FlashSize=4M,PartitionScheme=huge_app,PSRAM=disabled,LoopCore=1,EventsCore=1,DebugLevel=none,EraseFlash=none"

ARDUINO_CLI_DIR="${HOME}/.arduino-cli-bin"

export PATH="${ARDUINO_CLI_DIR}:${PATH}"

if [ ! -e "./OnStepX" ]; then
    git clone \
            --depth 1 \
            --revision "${COMMIT}" \
            "${REPO_URL}" "./OnStepX"

    if ls ./OnStepX-changes/*.patch >/dev/null 2>&1; then
        ls -1 ./OnStepX-changes/*.patch | while read patch; do
            set -x -e -u -o pipefail

            patch="${PWD}/${patch}"
            patch --directory "./OnStepX" --strip 1 <"${patch}"
        done
    fi

    [ -e "./OnStepX-changes/files" ] && cp \
            --force \
            --recursive \
            --verbose \
            "./OnStepX-changes/files/." "./OnStepX"
fi

arduino-cli compile \
        --fqbn "${FQBN}" \
        --export-binaries \
        --verbose \
        "./OnStepX"
cp ~/.arduino*/packages/esp32/hardware/esp32/*/tools/partitions/boot_app0.bin ./OnStepX/build/*/
