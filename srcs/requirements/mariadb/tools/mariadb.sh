#!/bin/bash

#Creating database
if [ ! -f db-setup.sql ]; then
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db-setup.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
echo "ALTER USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
fi

echo "MariaDB is ready";
exec "$@" < db-setup.sql

