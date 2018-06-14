FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update python py-pip git jq && rm -rf /var/cache/apk/*
RUN pip install cheetah

RUN adduser -u 1337 -S box
RUN chown -R box:nogroup /home/box
USER box

RUN git clone https://github.com/SickRage/SickRage.git /home/box/sickrage/install

COPY data /home/box/sickrage/data
COPY run.sh /home/box/sickrage/run.sh

EXPOSE 8074

VOLUME /home/box/sickrage
WORKDIR /home/box/sickrage

CMD ["/home/box/sickrage/run.sh"]
