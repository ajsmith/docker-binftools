#!/bin/bash

# Abort immediately on error
set -e

# Set defaults
image_repo=${USER}
image_tag="build"
platform="linux/arm64,linux/amd64"

# Set build variables from conf file
source build.conf

image_str="${image_repo}/binftools:${image_tag}"

build_opts="\
--force-rm -f Dockerfile --platform=${platform} -t ${image_str}
"

cd $(dirname $0)
docker build ${build_opts} .
