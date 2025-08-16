#!/bin/bash

# Abort immediately on error
set -e

source build.conf


if [[ -z "${image_repo}" ]]
then
    image_repo=${USER}
fi

if [[ -z "${image_tag}" ]]
then
    image_tag="build"
fi


image_str="${image_repo}/binftools:${image_tag}"


build_opts="\
--force-rm -f Dockerfile --platform=linux/arm64/v8 -t ${image_str}
"

cd $(dirname $0)
docker build ${build_opts} .
