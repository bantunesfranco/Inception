#!/bin/bash

#Installing Wordpress
# echo "Installing Wordpress"

wget https://wordpress.org/wordpress-6.3.tar.gz -P /var/www/

cd /var/www && tar -xvf wordpress-6.3.tar.gz
rm -rf wordpress-6.3.tar.gz
mv /var/www/wordpress /var/www/html

chown -R www-data:www-data /var/www/html

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

rm -rf /var/www/html/wp-config-sample.php

#Configuring Wordpress

echo "Configuring Wordpress"

wp core download --allow-root

wp config create --allow-root --dbname=$DB_NAME \
 --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD \
 --dbhost=$DB_HOST --dbcharset="utf8" \
 --dbcollate="utf8_general_ci" 

wp core install --allow-root --url=$DOMAIN_NAME/wordpress \
 --title=$WP_TITLE --admin_user=$WP_ADMIN_USR \
 --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL \
 --skip-email 

#Creating Wordpress User

echo "Creating Wordpress User"
wp user create --allow-root $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD
#  --path=$WP_PATH

# sed -i -r "s/user/$DB_USER/1"		wp-config.php
# sed -i -r "s/pwd/$DB_PASSWORD/1"	wp-config.php
# sed -i -r "s/db1/$DB_NAME/1"		wp-config.php


echo "Starting Wordpress"
exec "$@"
