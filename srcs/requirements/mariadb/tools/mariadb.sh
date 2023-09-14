#!/bin/bash

#Installing MariaDB
# echo "Installing MariaDB";

service mysql start;

# Healthcheck
if service mysql status >/dev/null 2>&1; then
	echo "MariaDB is running."
else
	echo "MariaDB is not running. Restarting..."
	service mysql restart

	# Check again after restarting
	if service mysql status >/dev/null 2>&1; then
		echo "MariaDB is running."
	else
		echo "MariaDB is not running. Exiting..."
		exit 1
	fi

	echo "MariaDB is running."
fi

# Create database

scripts/mariadb-install-db --user=$DB_USER \
	--password=$DB_PASSWORD \
	--basedir=/var/lib/mysql



exec "$@";