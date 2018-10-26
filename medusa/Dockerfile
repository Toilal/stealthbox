FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update git jq python py-pip build-base python-dev libffi-dev openssl-dev libxml2-dev libxslt-dev linux-headers && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box

RUN git clone https://github.com/pymedusa/Medusa.git /home/box/medusa/install
RUN cd /home/box/medusa/install && pip install -r requirements.txt
COPY data /home/box/medusa/data
COPY run.sh /home/box/medusa/run.sh

RUN chown -R box:nogroup /home/box
USER box

EXPOSE 8074

VOLUME /home/box/medusa
WORKDIR /home/box/medusa

CMD ["/home/box/medusa/run.sh"]
