#!/bin/bash

#Installing Wordpress
echo "Installing Wordpress";

apt-get update -y && apt-get upgrade -y \
&& apt-get install -y php8.1 php-fpm php-mysql mariadb-client wget;

wget https://wordpress.org/wordpress-6.3.tar.gz -P /var/www/

cd /var/www && tar -xvf wordpress-6.3.tar.gz
rm -rf wordpress-6.3.tar.gz
mv /var/www/wordpress /var/www/html

chown -R root:root /var/www/html

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

rm -rf /var/www/html/wp-config-sample.php
mv /wp-config.php /var/www/html/wp-config.php

#Configuring Wordpress

echo "Configuring Wordpress";
wp config create --allow-root \
 --dbname=$DB_NAME \
 --dbuser=$DB_USER \
 --dbpass=$DB_PASSWORD \
 --dbhost=$DB_HOST:$DB_PORT \
 --path=$WP_PATH

sed -i -r "s/db1/$DB_NAME/1"		wp-config.php
sed -i -r "s/user/$DB_USER/1"		wp-config.php
sed -i -r "s/pwd/$DB_PASSWORD/1"	wp-config.php

wp core install --url=$DOMAIN_NAME/ \
 --title=$WP_TITLE \
 --admin_user=$WP_ADMIN_USR \
 --admin_password=$WP_ADMIN_PWD \
 --admin_email=$WP_ADMIN_EMAIL \
 --skip-email --allow-root

#Creating Wordpress User

echo "Creating Wordpress User";
wp user create $WP_USER $WP_USER_EMAIL \
 --user_pass=$WP_USER_PASSWORD \
 --path=$WP_PATH

echo "Starting Wordpress";
exec "$@"
