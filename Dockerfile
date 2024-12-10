from alpine:3.20.3

shell [ \
  "/usr/bin/env", "sh", \
  "-o", "errexit", \
  "-o", "pipefail", \
  "-o", "nounset", \
  "-o", "verbose", \
  "-o", "errtrace", \
  "-c" \
]

run <<EOF
  apk add \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  --no-cache \
  guestfs-tools
EOF

run <<EOF
  apk add \
    --no-cache \
    xz \
    tar \

  curl \
    --location \
    --output appliance.tar.xz \
    https://libguestfs.org/download/binaries/appliance/appliance-1.54.0.tar.xz

  mkdir --parents /usr/local/lib/guestfs
  tar \
    -xJv \
    -f appliance.tar.xz \
    -C /usr/local/lib/guestfs \
    --no-same-owner \
    --strip-components=1

  rm appliance.tar.xz

  chmod -v \
    a+rwx,u-x,g-wx,o-wx \
    /usr/local/lib/guestfs/*

  apk del \
    xz \
    tar
EOF

cmd ["guestfish"]
