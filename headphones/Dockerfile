FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update ca-certificates python && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box

RUN apk add --update git &&\
 git clone -b master https://github.com/rembo10/headphones.git /home/box/headphones/install &&\
 apk del git &&\
 rm -rf /var/cache/apk/*

COPY data /home/box/headphones/data

RUN chown -R box /home/box && chgrp -R nogroup /home/box

EXPOSE 8181

WORKDIR /home/box/headphones
VOLUME /home/box/headphones

USER box
CMD ["python", "/home/box/headphones/install/Headphones.py", "-p", "8181", "--datadir", "/home/box/headphones/data", "--nolaunch"]
