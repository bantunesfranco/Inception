#!/bin/bash

# Add ftp user

adduser -D $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
echo "$FTP_USER" >> /etc/vsftpd/vsftpd.userlist

sed -i "s/anonymous_enable=YES/anonymous_enable=NO/g" /etc/vsftpd/vsftpd.conf
sed -i "s/local_enable=NO/local_enable=YES/g" /etc/vsftpd/vsftpd.conf
sed -i "s/ssl_enable=NO/ssl_enable=YES/g" /etc/vsftpd/vsftpd.conf
sed -i "s/chroot_local_user=NO/chroot_local_user=YES/g" /etc/vsftpd/vsftpd.conf





echo "Ftp is ready"
exec "$@"