# `libguestfs` in Docker

`libguestfs` and its tools in a minimal Alpine-based Docker image. Usable in Mac OS.

# Usage

The target VM image needs to be mounted into the container.

[Example wrapper scripts are provided.](./scripts)

## Interactive `guestfish` Session

```bash
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
```

## Running a Command

```bash
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
```

# Building

`./build_and_push.bash`
