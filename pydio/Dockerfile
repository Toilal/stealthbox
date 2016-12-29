FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update wget ca-certificates libssl1.0 sqlite curl jq && rm -rf /var/cache/apk/*

RUN mkdir -p /opt
RUN wget --no-check-certificate -qO- https://sourceforge.net/projects/ajaxplorer/files/pydio/stable-channel/6.4.2/pydio-core-6.4.2.tar.gz \
    | tar xvz -C /opt
RUN ln -s /opt/pydio-core-6.4.2 /opt/pydio

COPY pydio/bootstrap.json /opt/pydio/data/plugins/boot.conf/
COPY pydio/pydio.db /opt/pydio/data/plugins/conf.sql/
COPY pydio/cache/ /opt/pydio/data/cache/

COPY run.sh /home/box/pydio/run.sh

RUN chown -R nobody:nogroup /opt/pydio-core-6.4.2

COPY scripts/* /opt/scripts/
RUN chown -R nobody:nogroup /opt/scripts

VOLUME /opt/scripts/

VOLUME /opt/pydio/
WORKDIR /home/box/pydio/

CMD ["/home/box/pydio/run.sh"]