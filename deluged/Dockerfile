FROM alpine:edge
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

# Install CA certificates
RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*

# Install SSL support
RUN apk add --update openssl && rm -rf /var/cache/apk/*

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
 git clone -b 1.3-stable https://github.com/deluge-torrent/deluge.git /home/box/deluged/install &&\
 cd /home/box/deluged/install && \
 python setup.py build_plugins &&\
 python setup.py install &&\
 apk del git &&\
 rm -rf /var/cache/apk/*

RUN apk add --update jq &&\
 rm -rf /var/cache/apk/*

COPY data /home/box/deluged/data
COPY run.sh /home/box/deluged

RUN mkdir -p /home/box/deluge/data/downloads
RUN mkdir -p /home/box/deluge/data/torrents
RUN mkdir -p /home/box/deluge/data/tmp
RUN mkdir -p /home/box/deluge/data/autoadd
RUN mkdir -p /home/box/deluge/data/plugins

RUN chown -R box /home/box && chgrp -R nogroup /home/box

EXPOSE 58846

WORKDIR /home/box/deluged
VOLUME /home/box/deluged
VOLUME /home/box/deluge

USER box
CMD ["/home/box/deluged/run.sh"]