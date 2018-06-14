FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN adduser -u 1337 -S box
RUN chown -R box:nogroup /home/box
USER box

COPY tools /home/box/tools

WORKDIR /home/box/tools
VOLUME /home/box/tools

CMD ["echo", "Stealthbox Tools Data Container"]