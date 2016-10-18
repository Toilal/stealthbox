FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update ca-certificates git python py-lxml py-openssl py-cryptography py-enum34 py-cffi jq && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box

RUN git clone -b master https://github.com/CouchPotato/CouchPotatoServer.git /home/box/couchpotato/install

COPY data /home/box/couchpotato/data
COPY run.sh /home/box/couchpotato/run.sh

EXPOSE 5050

RUN chown -R box /home/box && chgrp -R nogroup /home/box

WORKDIR /home/box/couchpotato
VOLUME /home/box/couchpotato

USER box
CMD ["/home/box/couchpotato/run.sh"]
