# Dockerfile for base image for emoncms
FROM ubuntu:14.04
MAINTAINER Lam Kee Wei <kee.wei@cosmiqo.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -yq install supervisor apache2 mysql-server mysql-client php5 libapache2-mod-php5 php5-mysql php5-curl php-pear \
    php5-dev php5-mcrypt php5-json git-core redis-server build-essential ufw ntp pwgen

# Install pecl dependencies
RUN pear channel-discover pear.swiftmailer.org
RUN pear channel-discover pear.apache.org/log4php
RUN pear install log4php/Apache_log4php
RUN pecl install channel://pecl.php.net/dio-0.0.6 redis swift/swift

# Add pecl modules to php5 configuration
RUN sh -c 'echo "extension=dio.so" > /etc/php5/apache2/conf.d/20-dio.ini'
RUN sh -c 'echo "extension=dio.so" > /etc/php5/cli/conf.d/20-dio.ini'
RUN sh -c 'echo "extension=redis.so" > /etc/php5/apache2/conf.d/20-redis.ini'
RUN sh -c 'echo "extension=redis.so" > /etc/php5/cli/conf.d/20-redis.ini'

# Enable modrewrite for Apache2
RUN a2enmod rewrite

# AllowOverride for / and /var/www
RUN sed -i '/<Directory \/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Set a server name for Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
