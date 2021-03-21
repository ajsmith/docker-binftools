#!/bin/bash

# Abort immediately on error
set -e

image_repo=${1}
image_tag=${2}

if [[ -z "${image_repo}" ]]
then
    image_repo=${USER}
fi

build_opts="\
--force-rm -f docker/Dockerfile -t ${image_repo}/binftools${image_tag}
"

cd $(dirname $0)/..
docker build ${build_opts} .
