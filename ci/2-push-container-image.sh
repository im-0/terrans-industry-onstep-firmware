#!/bin/bash

set -x -e -u -o pipefail

IMAGE_TAG="ghcr.io/im-0/terrans-industry-onstep-firmware-ci"

[ -e "./2-push-container-image.sh" ] || exit 1
cd ".."

BRANCH="$( git rev-parse --abbrev-ref HEAD )"
DATE="$( git log -1 --format=%cd --date=format:%Y-%m-%d -- . )"
MANIFEST="${IMAGE_TAG}:${BRANCH}-${DATE}"
buildah push \
        --all \
        "${MANIFEST}"
