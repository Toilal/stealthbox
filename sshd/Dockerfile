FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update bash openssh jq &&\
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config &&\
    rm -rf /var/cache/apk/*
RUN adduser -u 1337 -S box -s /bin/bash

COPY rootfs /
COPY run.sh /home/box/sshd/run.sh

CMD ["/home/box/sshd/run.sh"]
