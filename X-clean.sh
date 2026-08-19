#!/bin/bash

set -x -e -u -o pipefail

[ -e "./X-clean.sh" ] || exit 1

rm --force --recursive "./OnStepX"
rm --force --recursive "./SmartHandController"
rm --force --recursive "./SmartWebServer"
