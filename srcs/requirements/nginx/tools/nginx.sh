#!/bin/bash

# Installing Nginx
echo "Installing nginx";

apt-get update -y && apt-get upgrade -y \
&& apt-get install -y mariadb-server mariadb-client;

exec "$@";