#!/bin/bash

# Fix permissions of images folder
chown -R 999:999 /images /var/www/mediawiki/images

# Set upload size default to be used in PHP config
MEDIAWIKI_MAX_UPLOAD_SIZE="100M"
export MEDIAWIKI_MAX_UPLOAD_SIZE

# Apply PHP-FPM worker count to config file
PHPFPM_WORKERS_START=1
PHPFPM_WORKERS_MIN=1
PHPFPM_WORKERS_MAX=20
sed -i "s/\$PHPFPM_WORKERS_START/$PHPFPM_WORKERS_START/g" /usr/local/etc/php-fpm.conf
sed -i "s/\$PHPFPM_WORKERS_MIN/$PHPFPM_WORKERS_MIN/g" /usr/local/etc/php-fpm.conf
sed -i "s/\$PHPFPM_WORKERS_MAX/$PHPFPM_WORKERS_MAX/g" /usr/local/etc/php-fpm.conf

# Apply Parsoid worker count to config file
PARSOID_WORKERS=1
sed -i "s/\$PARSOID_WORKERS/$PARSOID_WORKERS/g" /usr/lib/parsoid/src/config.yaml

# Start supervisord
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
