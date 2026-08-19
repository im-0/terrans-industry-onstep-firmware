#!/bin/bash

set -x -e -u -o pipefail

ARDUINO_CLI_DIR="${HOME}/.arduino-cli-bin"

export PATH="${ARDUINO_CLI_DIR}:${PATH}"

ESP32_INDEX="https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json"
ESP8266_INDEX="https://raw.githubusercontent.com/esp8266/esp8266.github.io/refs/heads/master/stable/package_esp8266com_index.json"

ESP32_VERSION="2.0.17"
ESP8266_VERSION="2.7.4"

arduino-cli core update-index \
        --additional-urls "${ESP32_INDEX}"
arduino-cli core update-index \
        --additional-urls "${ESP8266_INDEX}"

arduino-cli core install "esp32:esp32@${ESP32_VERSION}" \
        --additional-urls "${ESP32_INDEX}"
arduino-cli core install "esp8266:esp8266@${ESP8266_VERSION}" \
        --additional-urls "${ESP8266_INDEX}"
