#!/bin/bash

set -e

cd $(dirname $0)

dnf clean all
dnf update -y
dnf install -y --setopt=tsflags='' $(cat packages.txt)

if [[ "$(uname -m)" == "amd64" ]]
then
    dnf install -y $(cat cuda-packages.txt)
fi

mandb -c
