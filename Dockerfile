FROM --platform=$BUILDPLATFORM fedora:42
LABEL org.opencontainers.image.authors="Alexander Smith <asmitl@gmu.edu>"

WORKDIR /root
COPY fedora/setup.sh .
COPY fedora/packages.txt .
RUN /bin/bash setup.sh
RUN useradd -u 1001 -m me

USER me
WORKDIR /home/me
COPY --chown=me:me fedora/user-files/.emacs .
