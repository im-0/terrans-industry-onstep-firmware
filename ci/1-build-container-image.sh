#!/bin/bash

set -x -e -u -o pipefail

IMAGE_TAG="ghcr.io/im-0/terrans-industry-onstep-firmware-ci"
IMAGE_TITLE="terrans-industry-onstep-firmware-ci"
IMAGE_DESC="CI image for terrans-industry-onstep-firmware. Contains Arduino, ESP toolchains and libraries preinstalled."
IMAGE_SOURCE="https://github.com/im-0/terrans-industry-onstep-firmware"

[ -e "./1-build-container-image.sh" ] || exit 1
cd ".."

BRANCH="$( git rev-parse --abbrev-ref HEAD )"
DATE="$( git log -1 --format=%cd --date=format:%Y-%m-%d -- . )"
MANIFEST="${IMAGE_TAG}:${BRANCH}-${DATE}"
buildah inspect \
        --format "{{ .ImageCreatedBy }}" \
        "${MANIFEST}" \
    || buildah build \
        --isolation "chroot" \
        --tag "${MANIFEST}" \
        --annotation "org.opencontainers.image.title=${IMAGE_TITLE}" \
        --annotation "org.opencontainers.image.description=${IMAGE_DESC}" \
        --annotation "org.opencontainers.image.source=${IMAGE_SOURCE}" \
		--file "./ci/container/Containerfile"
