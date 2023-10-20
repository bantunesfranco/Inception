#!/bin/bash

mkdir -p /run/php/

wget -O adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

mkdir -p /var/www/html
ls -la /var/www/html

chmod 777 ./adminer.php
mv ./adminer.php /var/www/html/index.php
chown -R www-data:www-data /var/www/html

echo "Adminer is ready!"
exec "$@"
