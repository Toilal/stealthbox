FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update nginx && rm -rf /var/cache/apk/*

RUN mkdir -p /tmp/nginx/client-body

ADD nginx /etc/nginx

WORKDIR /etc/nginx/
VOLUME /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]