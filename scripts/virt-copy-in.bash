#!/usr/bin/env bash

set \
  -o errexit \
  -o pipefail \
  -o nounset \
  -o errtrace

shopt -s \
  inherit_errexit \
  shift_verbose

if (( $# != 2 )); then
  echo >&2 "Usage: virt-copy-in.bash <image> <src> <dst>"
  exit 1
fi

base=$(basename "$1")
dir=$(dirname "$(realpath "$1")")

src=$(realpath "$2")
dst="$3"

src_base=$(basename "${src}")

docker run \
  --privileged `# for QEMU KVM` \
  --mount "type=bind,source=${dir},target=/mnt" \
  --mount "type=bind,source=${src},target=/src/${src_base}" \
  maximsmol/libguestfs:latest \
  guestfish \
    --rw \
    --add "/mnt/${base}" \
    --inspector \
<<EOF
  copy-in "/src/${src_base}" "${dst}"
  umount-all
EOF
