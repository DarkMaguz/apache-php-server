#!/bin/bash
source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec /usr/sbin/apache2 -DFOREGROUND

