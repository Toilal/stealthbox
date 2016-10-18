FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN adduser -u 1337 -S box

COPY conf /home/box/conf

RUN chown -R box /home/box && chgrp -R nogroup /home/box

WORKDIR /home/box/conf
VOLUME /home/box/conf

USER box
CMD ["echo", "Stealthbox Conf Data Container"]