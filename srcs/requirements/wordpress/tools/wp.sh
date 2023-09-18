#!/bin/bash

#Installing Wordpress
# echo "Installing Wordpress"
wget https://wordpress.org/wordpress-6.3.tar.gz -P /var/www/html
tar -xvf wordpress-6.3.tar.gz
cp -r /var/www/html/wordpress/* /var/www/html
rm -rf /var/www/html/wordpress

chown -R root:root /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv ./wp-cli.phar /usr/local/bin/wp

#Configuring Wordpress
echo "Configuring Wordpress"
# wp config create --allow-root --dbname=$DB_NAME \
#  --dbuser=$DB_USER --dbpass=$DB_PASSWORD \
#  --dbhost=$DB_HOST --dbcharset="utf8" \
#  --dbcollate="utf8_general_ci"
mv  /wp-config.php /var/www/html/wp-config.php
sed -i -r "s/user/$DB_USER/1"		/var/www/html/wp-config.php
sed -i -r "s/pwd/$DB_PASSWORD/1"	/var/www/html/wp-config.php
sed -i -r "s/db1/$DB_NAME/1"		/var/www/html/wp-config.php

wp core install --allow-root --url=$DOMAIN_NAME/wordpress \
 --title=$WP_TITLE --admin_user=$WP_ADMIN_USR \
 --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL \
 --skip-email 

#Creating Wordpress User

echo "Creating Wordpress User"
wp user create --allow-root $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD
#  --path=$WP_PATH



echo "Starting Wordpress"
exec "$@"
