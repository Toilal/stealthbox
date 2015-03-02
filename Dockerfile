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
ADD apt-sources/* /etc/apt/sources.list.d/
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
RUN wget http://sourceforge.net/projects/ajaxplorer/files/pydio/stable-channel/6.0.3/pydio-core-6.0.3.tar.gz -O /tmp/pydio-core.tar.gz
RUN tar zxvf /tmp/pydio-core.tar.gz -C /opt

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

RUN mkdir /etc/service/php5-fpm
ADD services/php5-fpm.sh /etc/service/php5-fpm/run
RUN chmod +x /etc/service/php5-fpm/run
RUN mv /etc/init.d/php5-fpm /etc/init.d/php5-fpm.lsb
RUN chmod -x /etc/init.d/php5-fpm.lsb
RUN ln -s /usr/bin/sv /etc/init.d/php5-fpm

#flexget
RUN mkdir -p /home/box/flexget
ADD flexget/* /home/box/flexget/

RUN mkdir /etc/service/flexget
ADD services/flexget.sh /etc/service/flexget/run
RUN chmod +x /etc/service/flexget/run
RUN ln -s /usr/bin/sv /etc/init.d/flexget
# TODO: Create flexget access in deluge auth file for deluge plugin

# pydio
RUN ln -s /opt/pydio-core-6.0.3 /opt/pydio

RUN sed -ri 's/^(define\("AJXP_DATA_PATH",\s*).*(\);)/\1"\/home\/box\/pydio"\2/' /opt/pydio-core-6.0.3/conf/bootstrap_context.php
RUN mv /opt/pydio-core-6.0.3/data /home/box/pydio

ADD pydio/bootstrap.json /home/box/pydio/plugins/boot.conf/
ADD pydio/pydio.db /home/box/pydio/plugins/conf.sql/
ADD pydio/cache/* /home/box/pydio/cache/

# deluge
ADD deluge/* /home/box/.config/deluge/
RUN mkdir -p /home/box/deluge/autoadd
RUN mkdir -p /home/box/deluge/downloads
RUN mkdir -p /home/box/deluge/tmp
RUN mkdir -p /home/box/deluge/torrents

RUN mkdir /etc/service/deluged
ADD services/deluged.sh /etc/service/deluged/run
RUN chmod +x /etc/service/deluged/run
RUN ln -s /usr/bin/sv /etc/init.d/deluged

RUN mkdir /etc/service/deluge-web
ADD services/deluge-web.sh /etc/service/deluge-web/run
RUN chmod +x /etc/service/deluge-web/run
RUN ln -s /usr/bin/sv /etc/init.d/deluge-web

# nginx
RUN mkdir -p /home/box/nginx
ADD nginx/* /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/proxy

RUN sed -ri 's/^[;#]?(user\s*).*;/\1box;/' /etc/nginx/nginx.conf
RUN sed -ri 's/^(proxy_set_header\s*Host\s*).*;/\1$http_host:$http_port;/' /etc/nginx/proxy_params
RUN mkdir /etc/service/nginx
ADD services/nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run
RUN mv /etc/init.d/nginx /etc/init.d/nginx.lsb
RUN chmod -x /etc/init.d/nginx.lsb
RUN ln -s /usr/bin/sv /etc/init.d/nginx

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
EXPOSE 80 22 8112 6881 58846