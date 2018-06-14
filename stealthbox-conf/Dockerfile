FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN adduser -u 1337 -S box

COPY conf /home/box/conf
RUN chown -R box:nogroup /home/box
USER box

WORKDIR /home/box/conf
VOLUME /home/box/conf

CMD ["echo", "Stealthbox Conf Data Container"]