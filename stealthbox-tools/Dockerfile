FROM alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN adduser -u 1337 -S box

COPY tools /home/box/tools

RUN chown -R box /home/box && chgrp -R nogroup /home/box

WORKDIR /home/box/tools
VOLUME /home/box/tools

USER box
CMD ["echo", "Stealthbox Tools Data Container"]