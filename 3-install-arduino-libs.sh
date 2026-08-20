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

git_checkout_tmp=$( mktemp --directory --tmpdir "install-arduino-libs.tmp.XXXXXXXXXX" )
while read lib_git; do
    set -x -e -u -o pipefail

    lib_name=$( echo "${lib_git}" | cut -d " " -f 1 )
    lib_url=$( echo "${lib_git}" | cut -d " " -f 2 )
    lib_rev=$( echo "${lib_git}" | cut -d " " -f 3 )

    lib_tmp_dir="${git_checkout_tmp}/${lib_name}"
    git clone \
            --depth 1 \
            --revision "${lib_rev}" \
            "${lib_url}" "${lib_tmp_dir}"
    git -C "${lib_tmp_dir}" switch --create "checkout"

    arduino-cli lib install --git-url "${lib_tmp_dir}"
done <<'EOF'
OneWire https://github.com/hjd1964/OneWire 11a688fe8f672d45763f619cdc58fca7f264be83
DallasTemperature https://github.com/hjd1964/Arduino-DS1820-Temperature-Library 7e8ffcbef7aebb841dcf26617d155e50ec495bbd
TMC2209 https://github.com/hjd1964/TMC2209 61503030a4f5eaa21ba0bb8e76a66e63f821267f
DallasGPIO https://github.com/hjd1964/Arduino-DS2413GPIO-Control-Library e54d8ad4f037bf6e17a120a451fd844b08e55c58
Ephemeris https://github.com/hjd1964/Ephemeris b06f11d5c73eb99793ed69e0791523f3982d079f
EOF
rm --recursive --force "${git_checkout_tmp}"
