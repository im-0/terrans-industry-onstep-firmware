#!/bin/bash

set -x -e -u -o pipefail

REPO_URL="https://github.com/hjd1964/SmartHandController"
# Date:   Thu Jul 16 12:43:24 2026
COMMIT="8560682f64aa6baa83f1ad7f96a0b5b81405cac9"

FQBN="esp32:esp32:esp32:CPUFreq=240,FlashFreq=80,FlashMode=qio,FlashSize=4M,PartitionScheme=huge_app,PSRAM=disabled,LoopCore=1,EventsCore=1,DebugLevel=none,EraseFlash=none"

ARDUINO_CLI_DIR="${HOME}/.arduino-cli-bin"

export PATH="${ARDUINO_CLI_DIR}:${PATH}"

export GIT_AUTHOR_NAME="Builder"
export GIT_AUTHOR_EMAIL="builder@builder"
export GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
export GIT_COMMITTER_EMAIL="${GIT_AUTHOR_EMAIL}"

if [ ! -e "./SmartHandController" ]; then
    git clone \
            --depth 1 \
            --revision "${COMMIT}" \
            "${REPO_URL}" "./SmartHandController"

    if ls ./SmartHandController-changes/*.patch >/dev/null 2>&1; then
        ls -1 ./SmartHandController-changes/*.patch | while read patch; do
            set -x -e -u -o pipefail

            patch="${PWD}/${patch}"
            patch --directory "./SmartHandController" --strip 1 <"${patch}"

            git -C "./SmartHandController" add "."
            git -C "./SmartHandController" commit -m "patch ${patch} applied"
        done
    fi

    [ -e "./SmartHandController-changes/files" ] && cp \
            --force \
            --recursive \
            --verbose \
            "./SmartHandController-changes/files/." "./SmartHandController"
    git -C "./SmartHandController" add "."
    git -C "./SmartHandController" commit -m "file overrides applied"
fi

arduino-cli compile \
        --fqbn "${FQBN}" \
        --export-binaries \
        --verbose \
        "./SmartHandController"
cp ~/.arduino*/packages/esp32/hardware/esp32/*/tools/partitions/boot_app0.bin ./SmartHandController/build/*/
