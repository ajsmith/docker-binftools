#!/bin/bash -e

cd $(dirname $0)

dnf install -y --setopt=tsflags='' $(cat packages.txt)
dnf clean all

mandb -c
