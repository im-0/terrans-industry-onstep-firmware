#!/bin/sh

set -x -e -u

ARDUINO_CLI_DIR="/opt/arduino-cli"

export PATH="${ARDUINO_CLI_DIR}:${PATH}"

arduino-cli config init --overwrite
arduino-cli config set "library.enable_unsafe_install" "true"

arduino-cli lib update-index

while read lib_name; do
	arduino-cli lib install "${lib_name}"
# See https://onstep.groups.io/g/main/wiki/32776
done <<'EOF'
Rtc by Makuna@2.3.5
Adafruit BME280 Library@2.2.2
Adafruit BMP280 Library@2.6.6
TMCStepper@0.7.3
ODriveArduino@0.10.9
QuickPID@3.1.9
EspSoftwareSerial@8.1.0
U8g2@2.36.19
EOF

arduino-cli lib install --git-url "https://github.com/hjd1964/Ephemeris"
