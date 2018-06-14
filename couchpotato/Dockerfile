FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update ca-certificates git python py-lxml py-openssl py-cryptography py-enum34 py-cffi jq && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box
RUN chown -R box:nogroup /home/box
USER box

RUN git clone -b master https://github.com/CouchPotato/CouchPotatoServer.git /home/box/couchpotato/install

COPY data /home/box/couchpotato/data
COPY run.sh /home/box/couchpotato/run.sh

EXPOSE 5050

WORKDIR /home/box/couchpotato
VOLUME /home/box/couchpotato

CMD ["/home/box/couchpotato/run.sh"]
