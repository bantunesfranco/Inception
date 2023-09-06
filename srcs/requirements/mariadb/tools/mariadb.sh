#!/bin/bash

# Installing MariaDB
echo "Installing MariaDB";

apt-get update -y && apt-get upgrade -y \
&& apt-get install -y mariadb-server mariadb-client;

rm -rf 

exec "$@";