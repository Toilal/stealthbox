FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update ca-certificates python py-pip && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box

RUN apk add --update git &&\
 git clone -b master https://github.com/Flexget/Flexget.git /home/box/flexget/install &&\
 apk del git &&\
 rm -rf /var/cache/apk/*

WORKDIR /home/box/flexget/install
RUN pip install paver
RUN pip install -e .

COPY data /home/box/flexget/data

RUN chown -R box /home/box && chgrp -R nogroup /home/box

WORKDIR /home/box/flexget
VOLUME /home/box/flexget

USER box
CMD ["flexget", "-c", "data/config.yml", "daemon", "start"]
