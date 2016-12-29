FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

# Install CA certificates
RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*

# Add boost dependencies
RUN apk add --update build-base boost linux-headers bzip2-dev python python-dev &&\
    rm -rf /var/cache/apk/*

# Build boost
RUN wget http://freefr.dl.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.gz &&\
    mkdir -p /usr/src &&\
    tar -zxf boost_1_60_0.tar.gz -C /usr/src &&\
    ln -s /usr/src/boost_1_60_0 /usr/src/boost &&\
    rm boost_1_60_0.tar.gz && \
    cd /usr/src/boost &&\
    bjam -d 0 release &&\
    bjam -d 0 --includedir=/usr/include --libdir=/usr/lib install &&\
    ln -s /usr/bin/bjam /usr/local/bin/b2

ENV BOOST_ROOT /usr/src/boost
ENV BOOST_BUILD_PATH /usr/src/boost/tools/build

# Add libtorrent dependencies
RUN apk add --update openssl openssl-dev &&\
   rm -rf /var/cache/apk/*

# build libtorrent
RUN wget https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_0_10/libtorrent-rasterbar-1.0.10.tar.gz &&\
    mkdir -p /usr/src &&\
    tar -zxf libtorrent-rasterbar-1.0.10.tar.gz -C /usr/src &&\
    ln -s /usr/src/libtorrent-rasterbar-1.0.10 /usr/src/libtorrent &&\
    rm libtorrent-rasterbar-1.0.10.tar.gz &&\
    cd /usr/src/libtorrent &&\
    bjam -d 0 release encryption=openssl

# build libtorrent python bindings
RUN cd /usr/src/libtorrent/bindings/python && python setup.py install

# install deluge alpine dependencies
RUN apk add --update libffi-dev geoip-dev intltool py-pip py-cffi py-gtk xdg-utils &&\
    rm -rf /var/cache/apk/*

# install deluge pip dependencies
RUN pip install setuptools six pyopenssl twisted[tls] chardet mako pyxdg slimit service_identity &&\

RUN adduser -u 1337 -S box

# clone and install deluge
RUN apk add --update git &&\
 git clone -b 1.3-stable https://github.com/deluge-torrent/deluge.git /home/box/deluge/install &&\
 cd /home/box/deluge/install && \
 python setup.py build_plugins &&\
 # setup.py install doesn't work properly with deluge 2.0, fallback to develop mode.
 python setup.py develop &&\
 apk del git &&\
 rm -rf /var/cache/apk/*

# install s6 overlay
RUN wget https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz -O /tmp/s6-overlay.tar.gz &&\
 tar xzf /tmp/s6-overlay.tar.gz -C / &&\
 rm /tmp/s6-overlay.tar.gz

COPY services.d /etc/services.d
COPY fix-attrs.d /etc/fix-attrs.d

COPY data /home/box/deluge/data
RUN mkdir -p /home/box/deluge/data/downloads

RUN chown -R box /home/box && chgrp -R nogroup /home/box

EXPOSE 8112
EXPOSE 58846

WORKDIR /home/box/deluge
VOLUME /home/box/deluge

ENTRYPOINT ["/init"]