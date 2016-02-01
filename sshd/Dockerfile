FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update bash openssh &&\
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config &&\
    rm -rf /var/cache/apk/*
RUN adduser -u 1337 -S box -s /bin/bash
RUN echo "root:box12345" | chpasswd
RUN echo "box:box12345" | chpasswd

COPY rootfs /

CMD /sshd
