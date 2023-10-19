#!/bin/bash

mkdir -p /run/php/

curl -o adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

mkdir -p /var/www/html
mv adminer.php /var/www/html/index.php

exec "$@"
