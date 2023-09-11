#!/bin/bash

# Installing MariaDB
echo "Installing MariaDB";

apt-get update -y && apt-get upgrade -y \
&& apt-get install mariadb-server -y mariadb-client -y;

echo "Installed on $(which mariadb)"

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

# mysql_install_db --user=root --basedir=/home/bfranco --datadir=/home/bfranco/data


# exec "$@";