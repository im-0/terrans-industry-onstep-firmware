#!/bin/sh

set -x -e -u

ARDUINO_CLI_DIR="/opt/arduino-cli"

export PATH="${ARDUINO_CLI_DIR}:${PATH}"

FQBN="esp8266:esp8266:d1:xtal=80,vt=flash,exception=disabled,ssl=all,eesz=4M3M,ip=lm2f,dbg=Disabled,lvl=None____,wipe=none,baud=921600"
arduino-cli compile \
        --fqbn "${FQBN}" \
        --export-binaries \
        --verbose \
        "./SmartWebServer"
