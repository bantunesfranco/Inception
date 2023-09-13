#!/bin/bash

# Installing Nginx
# echo "Installing nginx";

# Configuring ssl certificate
echo "Configuring ssl certificate";
mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
 -keyout /etc/nginx/ssl/inception.key \
 -subj "/C=NL/ST=NH/L=Amsterdam/O=42/OU=Codam/CN=bfranco.42.fr/UID=bfranco"

chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

echo "Starting nginx";
exec "$@";