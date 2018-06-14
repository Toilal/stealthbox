FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update git jq ca-certificates python && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box
RUN chown -R box:nogroup /home/box

USER box

RUN git clone -b master https://github.com/rembo10/headphones.git /home/box/headphones/install

COPY data /home/box/headphones/data
COPY run.sh /home/box/headphones/run.sh

EXPOSE 8181

WORKDIR /home/box/headphones
VOLUME /home/box/headphones

CMD ["/home/box/headphones/run.sh"]
