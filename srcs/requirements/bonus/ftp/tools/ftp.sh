#!/bin/bash

# Creating ftp user and config
if [ ! -f /etc/vsftpd.conf.bak ]; then

    mv /etc/vsftpd.conf /etc/vsftpd.conf.bak
    mv /vsftpd.conf /etc/vsftpd.conf

    id -u "$FTP_USER" &>/dev/null
    if [ $? -eq 1 ]; then
        adduser $FTP_USER --disabled-password --gecos ""
        echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

        chown -R "$FTP_USER":"$FTP_USER" /home/"$FTP_USER"/ftp
        echo $FTP_USER >> /etc/vsftpd.userlist
    fi
fi

echo "Ftp is ready"
exec "$@"