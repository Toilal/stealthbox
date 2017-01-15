FROM alpine:edge
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

# Install CA certificates
RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*

# Install SSL support
RUN apk add --update openssl && rm -rf /var/cache/apk/*

# Install s6 overlay
RUN wget http://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz -O /tmp/s6-overlay.tar.gz &&\
 tar xzf /tmp/s6-overlay.tar.gz -C / &&\
 rm /tmp/s6-overlay.tar.gz

COPY services.d /etc/services.d
COPY fix-attrs.d /etc/fix-attrs.d

# Testing repository is required for libtorrent-rasterbar
RUN echo @testing http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

# install deluge alpine dependencies
RUN apk add --update build-base openssl-dev bzip2-dev python-dev libtorrent-rasterbar@testing libffi-dev geoip-dev intltool py2-pip py-cffi py-gtk xdg-utils &&\
    rm -rf /var/cache/apk/*

# install deluge pip dependencies
RUN pip install setuptools six pyopenssl twisted[tls] chardet mako pyxdg slimit service_identity

RUN adduser -u 1337 -S box

# clone and install deluge
RUN apk add --update git &&\
 git clone -b 1.3-stable https://github.com/deluge-torrent/deluge.git /home/box/deluge/install &&\
 cd /home/box/deluge/install && \
 python setup.py build_plugins &&\
 python setup.py install &&\
 apk del git &&\
 rm -rf /var/cache/apk/*

COPY data /home/box/deluge/data
RUN mkdir -p /home/box/deluge/data/downloads

RUN chown -R box /home/box && chgrp -R nogroup /home/box

EXPOSE 8112
EXPOSE 58846

WORKDIR /home/box/deluge
VOLUME /home/box/deluge

ENTRYPOINT ["/init"]