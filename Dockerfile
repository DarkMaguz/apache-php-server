FROM debian:buster

# Install services
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php nano ssl-cert

# Prepair app directory
RUN mkdir -p /var/www/app

RUN echo "ServerName example.com">> /etc/apache2/apache2.conf

# Install certificates
COPY ssl-parms.conf /etc/apache2/conf-available/ssl-parms.conf
#RUN mkdir -p /etc/letsencrypt/live/example.com
#RUN cp /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/letsencrypt/live/example.com/fullchain.pem
#RUN cp /etc/ssl/private/ssl-cert-snakeoil.key /etc/letsencrypt/live/example.com/privkey.pem

# Configure sites
RUN rm -rf /etc/apache2/sites-available
COPY sites-available /etc/apache2/sites-available

#COPY letsencrypt/etc /etc/letsencrypt

# Configure apache
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl
RUN a2dissite 000-default
RUN a2ensite app
RUN a2ensite app-ssl
RUN a2enconf ssl-parms

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV ENVIRONMENT docker

#RUN apachectl -S

EXPOSE 80
EXPOSE 443

ADD docker-run.sh /docker-run.sh
RUN chmod 755 /*.sh

CMD ["/docker-run.sh"]
