#!/bin/bash

#Starting MariaDB

service mariadb start;

# Creating database

echo "SET PASSWORD FOR 'root'@'%' = PASSWORD('$DB_ROOT_PASSWORD');" >> db-setup.sql
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db-setup.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
echo "ALTER USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql

mysql < db-setup.sql

exec "$@"

