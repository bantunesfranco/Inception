#!/bin/bash

mkdir -p /run/php/
mkdir -p /var/www/html

if [ ! -f adminer.php ]; then
    wget -O adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php
    chmod 777 ./adminer.php
    cp ./adminer.php /var/www/html/index.php
fi

chown -R www-data:www-data /var/www/html

echo "Adminer is ready!"
exec "$@"
