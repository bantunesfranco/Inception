#!/bin/bash

# mkdir -p /run/mysqld
# touch /run/mysqld/mysqld.sock
# chmod 777 /run/mysqld/mysqld.sock

#Starting MariaDB
service mariadb start;

#Creating database
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db-setup.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
echo "ALTER USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
# echo "ALTER USER 'root'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
# echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';" >> db-setup.sql
# echo "FLUSH PRIVILEGES;" >> db-setup.sql

mysql < db-setup.sql

echo "MariaDB is ready";
exec "$@"

