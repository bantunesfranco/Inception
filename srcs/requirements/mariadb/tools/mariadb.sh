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

exec mysql -u root -e "CREATE DATABASE IF NOT EXISTS inception;"
exec mysql -u root -e "CREATE USER IF NOT EXISTS 'bfranco'@'localhost' IDENTIFIED BY '1234';"
exec mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'bfranco'@'localhost';"
exec mysql -u root -e "FLUSH PRIVILEGES;"
exec mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '1234';"

# exec $@
exec /bin/bash

