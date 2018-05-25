FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update nginx && rm -rf /var/cache/apk/*
RUN chown -R nobody:nobody /var/lib/nginx /var/tmp/nginx

ADD nginx /etc/nginx

WORKDIR /etc/nginx/
VOLUME /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]