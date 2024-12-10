#!/usr/bin/env bash

name='maximsmol/libguestfs'
version='v1'
tag="${name}:${version}"

docker build \
  --tag "${tag}" \
  .

docker push "${tag}"

docker tag "${tag}" "${name}:latest"
docker push "${name}:latest"
