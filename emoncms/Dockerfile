FROM cosmiqo/emonbase:latest

MAINTAINER Lam Kee Wei <kee.wei@cosmiqo.com>
RUN rm -rf /var/www/html
RUN git clone https://github.com/emoncms/emoncms.git /var/www/html

# Add db setup script
ADD db.sh /db.sh
RUN chmod 755 /*.sh

# Start mysql and setup database
RUN /db.sh

# Create required data repositories for emoncms feed engine
RUN mkdir /var/lib/phpfiwa
RUN mkdir /var/lib/phpfina
RUN mkdir /var/lib/phptimeseries

# Expose them as volumes for mounting by host
VOLUME ["/etc/mysql", "/var/lib/mysql", "/var/lib/phpfiwa", "/var/lib/phpfina", "/var/lib/phptimeseries"]

# Add supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80 3306
RUN bash /etc/apache2/envvars
WORKDIR /var/www/emoncms
CMD ["/usr/bin/supervisord"]
