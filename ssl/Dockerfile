FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update bash openssl && rm -rf /var/cache/apk/*

WORKDIR /etc/stealthbox/ssl/
VOLUME /etc/stealthbox/ssl/

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]