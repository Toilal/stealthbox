FROM phusion/baseimage:0.9.16

MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

# +------+
# | INIT |
# +------+

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Define environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# Workaround a possible bug 
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=617856
RUN rm -f /etc/apt/apt.conf.d/docker-gzip-indexes

# Add custom apt sources
RUN add-apt-repository ppa:deluge-team/ppa
RUN apt-get update -y

# +---------+
# | INSTALL |
# +---------+

# tools
RUN apt-get install -y wget git sqlite3 pwgen libcrack2 expect python-pip
RUN pip install virtualenv

# php5-fpm
RUN apt-get install -y php5 php5-fpm php5-gd php5-cli php5-mcrypt php5-sqlite

# nginx
RUN apt-get install -y nginx

# deluge
RUN apt-get update -y
RUN apt-get install -y deluged deluge-web

# flexget
RUN apt-get install -y 
RUN git clone -b master https://github.com/Flexget/Flexget.git /opt/flexget

# deluge plugin currently requires --system-site-packages virtualenv.
RUN pip install --upgrade six
RUN cd /opt/flexget && python /opt/flexget/bootstrap.py --system-site-packages

# pydio
RUN mkdir -p /opt/pydio
RUN wget -qO- http://sourceforge.net/projects/ajaxplorer/files/pydio/stable-channel/6.0.5/pydio-core-6.0.5.tar.gz \
    | tar xvz --strip-components=1 -C /opt/pydio

# SickRage
RUN apt-get install -y python-cheetah
RUN mkdir -p sickrage
RUN git clone https://github.com/SiCKRAGETV/SickRage.git /opt/sickrage

# CouchPotato
RUN mkdir -p couchpotato
RUN git clone https://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato

# HeadPhones
RUN mkdir -p headphones
RUN git clone https://github.com/rembo10/headphones /opt/headphones

# +-----------+
# | CONFIGURE |
# +-----------+

RUN useradd -ms /bin/bash box
RUN echo 'box:box12345' | chpasswd

# php5-fpm
RUN sed -ri 's/^[;#]?(file_uploads\s*=\s*).*/\1On/' /etc/php5/fpm/php.ini
RUN sed -ri 's/^[;#]?(post_max_size\s*=\s*).*/\1512G/' /etc/php5/fpm/php.ini
RUN sed -ri 's/^[;#]?(upload_max_filesize\s*=\s*).*/\1512G/' /etc/php5/fpm/php.ini
RUN sed -ri 's/^[;#]?(max_file_uploads\s*=\s*).*/\120000/' /etc/php5/fpm/php.ini
RUN sed -ri 's/^[;#]?(output_buffering\s*=\s*).*/\1Off/' /etc/php5/fpm/php.ini

RUN php5enmod mcrypt

RUN sed -ri 's/^[;#]?(user\s*=\s*).*/\1box/' /etc/php5/fpm/pool.d/www.conf
RUN sed -ri 's/^[;#]?(group\s*=\s*).*/\1box/' /etc/php5/fpm/pool.d/www.conf
RUN sed -ri 's/^[;#]?(listen.owner\s*=\s*).*/\1box/' /etc/php5/fpm/pool.d/www.conf
RUN sed -ri 's/^[;#]?(listen.group\s*=\s*).*/\1box/' /etc/php5/fpm/pool.d/www.conf

#flexget
RUN mkdir -p /home/box/flexget
ADD flexget/* /home/box/flexget/

# pydio
RUN sed -ri 's/^(define\("AJXP_DATA_PATH",\s*).*(\);)/\1"\/home\/box\/pydio"\2/' /opt/pydio/conf/bootstrap_context.php
RUN mv /opt/pydio/data /home/box/pydio
RUN ln -s /home/box/pydio /opt/pydio/data

ADD pydio/bootstrap.json /home/box/pydio/plugins/boot.conf/
ADD pydio/pydio.db /home/box/pydio/plugins/conf.sql/
ADD pydio/cache/* /home/box/pydio/cache/

# SickRage
RUN mkdir -p /home/box/sickrage
RUN mkdir -p /home/box/sickrage/data
ADD sickrage/* /home/box/sickrage/

# CouchPotato
RUN mkdir -p /home/box/couchpotato
ADD couchpotato/* /home/box/couchpotato/

# 3rd party providers for CouchPotato
# https://couchpota.to/forum/viewtopic.php?f=17&t=1428&p=6115
RUN mkdir -p /home/box/couchpotato/custom_plugins
RUN git clone https://github.com/djoole/couchpotato.provider.t411 /home/box/couchpotato/custom_plugins/t411

# HeadPhones
RUN mkdir -p /home/box/headphones
ADD headphones/* /home/box/headphones/

# deluge
ADD deluge/* /home/box/deluge/
RUN mkdir -p /home/box/deluge/autoadd
RUN mkdir -p /home/box/deluge/downloads
RUN mkdir -p /home/box/deluge/tmp
RUN mkdir -p /home/box/deluge/torrents

# nginx
RUN mkdir -p /home/box/nginx
ADD nginx/* /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/stealthbox /etc/nginx/sites-enabled/stealthbox

RUN sed -ri 's/^[;#]?(user\s*).*;/\1box;/' /etc/nginx/nginx.conf

# stealthbox
ADD stealthbox /opt/stealthbox/

RUN ln -s /opt/stealthbox/boxpasswd.sh /usr/bin/boxpasswd

# when-changed
RUN pip install https://github.com/joh/when-changed/archive/master.zip

# Add my_init
ADD my_init.d/* /etc/my_init.d/

# Add services
ADD services/ /etc/service/
RUN mkdir -p /home/box/logs
RUN /opt/stealthbox/docker/lsb_compat.sh
RUN /opt/stealthbox/docker/runit_logs.sh

# Add bin
ADD bin /home/box/bin

# +---------+
# | PREPARE |
# +---------+

# Fix permissions
RUN chown -R box:box /home/box
RUN chown -R box:box /opt/*

# Remove PAM checks on password
RUN sed -ri 's/^(password\s+.*?\s+pam_unix.so\s+).*/\1sha512 minlen=0/' /etc/pam.d/common-password

# Enable SSH
RUN rm -f /etc/service/sshd/down

# Mount home volume and expose required ports
VOLUME /home/box
VOLUME /etc/stealthbox/ssl

EXPOSE 443 80 22 6881