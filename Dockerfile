FROM fedora:36
MAINTAINER Alexander Smith <asmitl@gmu.edu>

WORKDIR /root
COPY fedora/setup.sh .
COPY fedora/packages.txt .
RUN /bin/bash setup.sh
RUN useradd -u 1001 -m me

USER me
WORKDIR /home/me
