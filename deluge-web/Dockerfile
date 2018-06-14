FROM alpine:edge
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

# Install CA certificates
RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*

# Install SSL support
RUN apk add --update openssl && rm -rf /var/cache/apk/*

# Testing repository is required for libtorrent-rasterbar
RUN echo @testing http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

# install deluge alpine dependencies
RUN apk add --update jq git build-base openssl-dev bzip2-dev python-dev libtorrent-rasterbar@testing libffi-dev geoip-dev intltool py2-pip py-cffi py-gtk xdg-utils &&\
    rm -rf /var/cache/apk/*

# install deluge pip dependencies
RUN pip install setuptools six pyopenssl twisted[tls] chardet mako pyxdg slimit service_identity

# clone and install deluge
RUN git clone -b 1.3-stable https://github.com/deluge-torrent/deluge.git /home/box/deluge-web/install &&\
 cd /home/box/deluge-web/install && \
 python setup.py build_plugins &&\
 python setup.py install

RUN rm /usr/bin/deluged # We don't want to launch deluged in this container

RUN adduser -u 1337 -S box
RUN chown -R box:nogroup /home/box
USER box


COPY data /home/box/deluge-web/data
COPY run.sh /home/box/deluge-web
COPY *.py /home/box/deluge-web/

EXPOSE 8112

WORKDIR /home/box/deluge-web
VOLUME /home/box/deluge-web

CMD ["/home/box/deluge-web/run.sh"]