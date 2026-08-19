#!/bin/bash

set -x -e -u -o pipefail

ARDUINO_CLI_DIR="${HOME}/.arduino-cli-bin"

export PATH="${ARDUINO_CLI_DIR}:${PATH}"

arduino-cli config init --overwrite
arduino-cli config set "library.enable_unsafe_install" "true"

arduino-cli lib update-index

# See https://onstep.groups.io/g/main/wiki/32776
# See https://onstep.groups.io/g/main/wiki/7152

while read lib_name; do
    set -x -e -u -o pipefail

    arduino-cli lib install "${lib_name}"
done <<'EOF'
Rtc by Makuna@2.3.5
TinyGPSPlus@1.0.3
Adafruit BME280 Library@2.2.2
Adafruit BMP280 Library@2.6.6
TMCStepper@0.7.3
ODriveArduino@0.10.9
QuickPID@3.1.9
PCF8575@0.3.0
TCA9555@0.4.4
Adafruit MCP23017 Arduino Library@2.3.2
EspSoftwareSerial@8.1.0
U8g2@2.36.19
EOF

while read lib_git; do
    set -x -e -u -o pipefail

    arduino-cli lib install --git-url "${lib_git}"
done <<'EOF'
https://github.com/hjd1964/TMC2209
https://github.com/hjd1964/Ephemeris
EOF
