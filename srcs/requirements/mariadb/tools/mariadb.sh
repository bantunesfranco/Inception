#!/bin/bash

#Creating database

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

    if [ ! -f db-setup.sql ]; then
        echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > db-setup.sql
        echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
        echo "ALTER USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
        echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> db-setup.sql
        echo "FLUSH PRIVILEGES;" >> db-setup.sql
    fi

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db --skip-name-resolve --auth-root-authentication-method=normal

    service mariadb start
    mysql < db-setup.sql
    service mariadb stop
fi

echo "MariaDB is ready";
exec "$@" 
