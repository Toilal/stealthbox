FROM debian:wheezy
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

# mono 3.10 currently doesn't install in debian jessie due to libpeg8 being removed.

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
  && echo "deb http://apt.sonarr.tv/ master main" | tee -a /etc/apt/sources.list \
  && apt-get update -q \
  && apt-get install -qy nzbdrone mediainfo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -u 1337 box
RUN chown -R box:nogroup /home/box
USER box

COPY data /home/box/sonarr/data

RUN mkdir -p /home/box/sonarr/data/config/sonarr /home/box/sonarr/data/completed /home/box/sonarr/data/media

EXPOSE 8989
EXPOSE 9898

VOLUME /home/box/sonarr
WORKDIR /home/box/sonarr

CMD ["mono", "/opt/NzbDrone/NzbDrone.exe", "--no-browser", "-data=/home/box/sonarr/data/config/sonarr"]