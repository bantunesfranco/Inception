#!/bin/bash

while ! mysqladmin ping -h"$DB_HOST" --silent; do
	echo "Waiting for database connection..."
	sleep 5
done

mkdir -p /run/php/

if [ ! -f /var/www/html/wp-config.php ]; then

	wp core download --allow-root --path=/var/www/html --version=$WP_VERSION --locale=$WP_LOCALE

	wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD \
	 --dbhost=$DB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --config-file=/var/www/html/wp-config.php

	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6973 --raw --allow-root
	wp config set WP_CACHE true --allow-root
	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	wp redis enable --allow-root

	wp core install --allow-root --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER \
	 --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL \
	 --skip-email --skip-themes

	wp user create --allow-root $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD

fi

echo "Wordpress is ready!"
exec "$@"
