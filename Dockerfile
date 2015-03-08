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
RUN apt-get install -y wget

# php5-fpm
RUN apt-get install -y php5 php5-fpm php5-gd php5-cli php5-mcrypt php5-sqlite

# nginx
RUN apt-get install -y nginx

# deluge
RUN apt-get update -y
RUN apt-get install -y deluged deluge-web

# flexget
RUN apt-get install -y python-pip
RUN pip install flexget
RUN pip install six --upgrade # python-six is 1.5.2 but flexget requires >= 1.7

# pydio
RUN mkdir -p /opt/pydio
RUN wget -qO- http://sourceforge.net/projects/ajaxplorer/files/pydio/stable-channel/6.0.5/pydio-core-6.0.5.tar.gz \
    | tar xvz --strip-components=1 -C /opt/pydio

# stealthbox
ADD stealthbox /opt/

# +-----------+
# | CONFIGURE |
# +-----------+

RUN adduser --disabled-password --gecos "" box
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

# TODO: Create flexget access in deluge auth file for deluge plugin

# pydio
RUN sed -ri 's/^(define\("AJXP_DATA_PATH",\s*).*(\);)/\1"\/home\/box\/pydio"\2/' /opt/pydio/conf/bootstrap_context.php
RUN mv /opt/pydio/data /home/box/pydio

ADD pydio/bootstrap.json /home/box/pydio/plugins/boot.conf/
ADD pydio/pydio.db /home/box/pydio/plugins/conf.sql/
ADD pydio/cache/* /home/box/pydio/cache/

# deluge
ADD deluge/* /home/box/.config/deluge/
RUN mkdir -p /home/box/deluge/autoadd
RUN mkdir -p /home/box/deluge/downloads
RUN mkdir -p /home/box/deluge/tmp
RUN mkdir -p /home/box/deluge/torrents

# nginx
RUN mkdir -p /home/box/nginx
ADD nginx/* /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/proxy
RUN ln -s /etc/nginx/sites-available/proxy-ssl /etc/nginx/sites-enabled/proxy-ssl

RUN sed -ri 's/^[;#]?(user\s*).*;/\1box;/' /etc/nginx/nginx.conf

#stealthbox
RUN mkdir -p /opt/stealthbox
ADD stealthbox /opt/stealthbox

# when-changed
RUN pip install https://github.com/joh/when-changed/archive/master.zip

# Add my_init
ADD my_init.d/* /etc/my_init.d/

# Add services
ADD services/ /etc/service/
RUN mkdir -p /home/box/logs
RUN /opt/stealthbox/lsb_compat.sh
RUN /opt/stealthbox/runit_logs.sh

# +---------+
# | PREPARE |
# +---------+

# Fix permissions
RUN chown -R box:box /home/box
RUN chown -R box:box /opt/*

# Enable SSH
RUN rm -f /etc/service/sshd/down

# Mount home volume and expose required ports
VOLUME /home/box
EXPOSE 443 22 80 6881 58846