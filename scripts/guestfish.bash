#!/usr/bin/env bash

set \
  -o errexit \
  -o pipefail \
  -o nounset \
  -o errtrace

shopt -s \
  inherit_errexit \
  shift_verbose

if (( $# != 1 )); then
  echo >&2 "Usage: guestfish.bash <image>"
  exit 1
fi

base=$(basename "$1")
dir=$(dirname "$(realpath "$1")")

docker run \
  --interactive \
  --tty \
  --privileged `# for QEMU KVM` \
  --mount "type=bind,source=${dir},target=/mnt" \
  maximsmol/libguestfs:latest \
  guestfish \
    --rw \
    --add "/mnt/${base}" \
    --inspector
