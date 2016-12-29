FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update ca-certificates python jq && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box

RUN apk add --update git &&\
 git clone -b master https://github.com/rembo10/headphones.git /home/box/headphones/install &&\
 apk del git &&\
 rm -rf /var/cache/apk/*

COPY data /home/box/headphones/data
COPY run.sh /home/box/headphones/run.sh

RUN chown -R box /home/box && chgrp -R nogroup /home/box

EXPOSE 8181

WORKDIR /home/box/headphones
VOLUME /home/box/headphones

USER box
CMD ["/home/box/headphones/run.sh"]
