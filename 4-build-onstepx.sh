#!/bin/sh

set -x -e -u

ARDUINO_CLI_DIR="/opt/arduino-cli"

export PATH="${ARDUINO_CLI_DIR}:${PATH}"

FQBN="esp32:esp32:esp32:CPUFreq=240,FlashFreq=80,FlashMode=qio,FlashSize=4M,PartitionScheme=huge_app,PSRAM=disabled,LoopCore=1,EventsCore=1,DebugLevel=none,EraseFlash=none"
arduino-cli compile \
        --fqbn "${FQBN}" \
        --export-binaries \
        --verbose \
        "./OnStepX"
cp ~/.arduino*/packages/esp32/hardware/esp32/*/tools/partitions/boot_app0.bin ./OnStepX/build/*/
