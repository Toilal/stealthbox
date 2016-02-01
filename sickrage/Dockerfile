FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update python py-pip git && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box

RUN git clone https://github.com/SickRage/SickRage.git /home/box/sickrage/install
RUN pip install cheetah

COPY data /home/box/sickrage/data

RUN chown -R box /home/box && chgrp -R nogroup /home/box

EXPOSE 8074

VOLUME /home/box/sickrage
WORKDIR /home/box/sickrage

USER box
CMD ["python", "/home/box/sickrage/install/SickBeard.py", "--datadir=/home/box/sickrage/data", "--nolaunch"]
