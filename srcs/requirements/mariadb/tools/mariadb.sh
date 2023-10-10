#!/bin/bash

#Starting MariaDB

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

# Creating database

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db-setup.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'localhost';" >> db-setup.sql
echo "FLUSH PRIVILEGES;" >> db-setup.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';" >> db-setup.sql

exec "$@"

