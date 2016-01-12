FROM ubuntu:14.04
MAINTAINER Ninel Hodzic <ninel.hodzic@gmail.com>

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    LANG=C.UTF-8 add-apt-repository ppa:ondrej/php5-5.6 && \
    apt-get update && \
    apt-get install -y apache2 php5 libapache2-mod-php5 php5-gd php5-json php5-curl nano curl
    
ENV TERM xterm  

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
RUN a2enmod rewrite

EXPOSE 80
#CMD ["/usr/local/bin/run"]
CMD ["/bin/bash", "run.sh"]

