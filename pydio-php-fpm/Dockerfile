FROM php:7.2-fpm-alpine
MAINTAINER Rémi Alvergnat <toilal.dev@gmail.com>

RUN apk add --update libxml2-dev freetype-dev libjpeg-turbo-dev libpng-dev sqlite-dev icu-dev mysql-dev postgresql-dev &&\
    docker-php-ext-install gd json dom exif iconv pdo_sqlite pdo_mysql pdo_pgsql &&\
    rm -rf /var/cache/apk/*

RUN docker-php-ext-install opcache intl
RUN docker-php-ext-install pgsql
