#!/bin/bash

mkdir -p /etc/nginx/ssl/certs

# Configuring ssl certificate
if [ ! -f /etc/nginx/ssl/certs/inception.crt ]; then
    openssl req -x509 -nodes -out /etc/nginx/ssl/certs/inception.crt \
    -keyout /etc/nginx/ssl/certs/inception.key \
    -subj "/C=NL/ST=NH/L=Amsterdam/O=42/OU=Codam/CN=bfranco.42.fr/UID=bfranco"

    chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html
    chmod 777 /etc/nginx/ssl/ && chown -R www-data:www-data /etc/nginx/ssl/
fi

echo "Nginx is ready";
exec "$@";