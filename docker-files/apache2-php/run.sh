#!/bin/bash
set -e

#PHP_ERROR_REPORTING=${PHP_ERROR_REPORTING:-"E_ALL & ~E_DEPRECATED & ~E_NOTICE"}
#sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php5/apache2/php.ini
#sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php5/cli/php.ini
#sed -ri "s/^error_reporting\s*=.*$//g" /etc/php5/apache2/php.ini
#sed -ri "s/^error_reporting\s*=.*$//g" /etc/php5/cli/php.ini
#echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php5/apache2/php.ini
#echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php5/cli/php.ini


# need host name and IP of the server who runs containers

# update /etc/hosts file based on ENV variable provided to point to HOST_MACHINE
echo "Updating /etc/hosts to make apache2-php-docker point to $HOST_MACHINE_IP ($HOST_MACHINE_HOSTNAME)"
if grep '$HOST_MACHINE_HOSTNAME' /etc/hosts >/dev/null; then
  sudo sed -i "s/^.*$HOST_MACHINE_HOSTNAME.*\$/$HOST_MACHINE_IP $HOST_MACHINE_HOSTNAME/" /etc/hosts
else
  sudo sh -c "echo '$HOST_MACHINE_IP $HOST_MACHINE_HOSTNAME' >> /etc/hosts"
fi

mkdir -p /mnt/olyfe_img/cache
chown www-data:www-data -R /mnt/olyfe_img

#source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND
service apache2 restart


# infinite loop
while :; do echo "Running Apache2 ..."; sleep 5; done