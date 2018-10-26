FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update wget ca-certificates libssl1.0 sqlite libarchive-tools curl jq && rm -rf /var/cache/apk/*

RUN mkdir -p /opt && \
  wget -qO- https://download.pydio.com/pub/core/archives/pydio-core-8.2.2.zip | bsdtar -xvf- && \
  mv pydio-core-8.2.2 /opt/pydio

#COPY pydio/bootstrap.json /opt/pydio/data/plugins/boot.conf/
#COPY pydio/pydio.db /opt/pydio/data/plugins/conf.sql/
#COPY pydio/cache/ /opt/pydio/data/cache/

COPY run.sh /home/box/pydio/run.sh

RUN chown -R nobody:nogroup /opt/pydio

COPY scripts/* /opt/scripts/
RUN chown -R nobody:nogroup /opt/scripts

VOLUME /opt/scripts/

VOLUME /opt/pydio/
WORKDIR /home/box/pydio/