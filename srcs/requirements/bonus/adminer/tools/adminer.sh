#!/bin/bash

mkdir -p /run/php/

curl -O https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

cat adminer-4.8.1.php

mkdir -p /var/www/html
chmod 777 adminer-4.8.1.php
mv adminer-4.8.1.php /var/www/html/index.php

echo "Adminer is ready!"
exec "$@"
