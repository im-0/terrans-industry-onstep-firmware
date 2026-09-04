#!/bin/bash

printf "Write uppercase YES to remove OnStepX, SmartHandController and SmartWebServer source trees: "
read confirm
if [ "${confirm}" == "YES" ]; then
    echo "Removing..."
else
    echo "Aborted!"
    exit 1
fi

set -x -e -u -o pipefail

[ -e "./X-clean.sh" ] || exit 1

rm --force --recursive "./OnStepX"
rm --force --recursive "./SmartHandController"
rm --force --recursive "./SmartWebServer"
