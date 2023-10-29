#!/bin/bash

# Creating ftp user and config
if [ ! -f /etc/vsftpd/vsftpd.conf.bak ]; then

    mv /etc/vsftpd.conf /etc/vsftpd.conf.bak
    mv /vsftpd.conf /etc/vsftpd.conf

    adduser $FTP_USER --disabled-password --gecos ""
    echo $FTP_USER:$FTP_PASSWORD | chpasswd

    chown -R $FTP_USER:$FTP_USER /var/www/html
    echo $FTP_USER >> /etc/vsftpd.userlist
fi

echo "Ftp is ready"
exec "$@"