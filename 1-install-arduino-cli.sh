#!/bin/sh

set -x -e -u

ARDUINO_CLI_VERSION="0.18.3"
ARDUINO_CLI_DIR="${HOME}/.arduino-cli-bin"

mkdir --parents --verbose "${ARDUINO_CLI_DIR}"

curl -fL \
        "https://downloads.arduino.cc/arduino-cli/arduino-cli_${ARDUINO_CLI_VERSION}_Linux_64bit.tar.gz" |
        tar -xz -C "${ARDUINO_CLI_DIR}"

"${ARDUINO_CLI_DIR}/arduino-cli" version
