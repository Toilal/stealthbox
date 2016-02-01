FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update python bash openssl && rm -rf /var/cache/apk/*

RUN adduser -u 1337 -S box

COPY cli /home/box/cli

RUN chown -R box /home/box && chgrp -R nogroup /home/box

WORKDIR /home/box/cli
VOLUME /home/box/cli

USER box
CMD ["echo", "Stealthbox Cli Data Container"]